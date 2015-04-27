package qeval;

import static qeval.QueryEvalUtils.bindingInFrame;
import static qeval.QueryEvalUtils.bindingValue;
import static qeval.QueryEvalUtils.isPair;
import static qeval.QueryEvalUtils.isVar;
import static qeval.QueryEvalUtils.taggedList;
import static qeval.SchemeList.cons;
import static qeval.SchemeList.list;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

public class QueryEvaluator {

    private static final String FAILED_SYMBOL = "failed";

    private int ruleCounter = 0;

    private Map<Object, QueryFunction> qprocMap = new HashMap<>();

    private List<SchemeList> globalRules = new ArrayList<>();

    private Map<Object, List<SchemeList>> ruleCache = new HashMap<>();

    public QueryEvaluator() {

        qprocMap.put("always-true", new AlwaysTrueQueryFunction());
    }

    public SchemeList eval(SchemeList query, SchemeList frameStream) {

        QueryFunction qproc = qprocMap.get(type(query));
        if (qproc != null) {
            return qproc.invoke(contents(query), frameStream);
        } else {
            return simpleQuery(query, frameStream);
        }
    }

    private SchemeList simpleQuery(SchemeList query, SchemeList frameStream) {

        List<Object> result = new ArrayList<>();
        for (Object frame : frameStream) {
            // TODO: find-assertions
            for (Object ruleResult : applyRules(query, (SchemeList) frame)) {
                result.add(ruleResult);
            }
        }
        return list(result);
    }

    private SchemeList applyRules(SchemeList query, SchemeList frame) {

        List<SchemeList> rules = fetchRules(query);
        List<Object> result = new ArrayList<>(rules.size());
        for (SchemeList rule : rules) {
            SchemeList applyResult = applyRule(query, rule, frame);
            if (applyResult != null) {
                for (Object object : applyResult) {
                    result.add(object);
                }
            }
        }
        return list(result);
    }

    private SchemeList applyRule(SchemeList query, SchemeList rule, SchemeList frame) {

        SchemeList cleanRule = renameVariablesIn(rule);
        Object unifyResult = unifyMatch(query, conclusion(cleanRule), frame);
        if (FAILED_SYMBOL.equals(unifyResult)) {
            return null;
        } else {
            return eval(ruleBody(cleanRule), list(unifyResult));
        }
    }

    private SchemeList renameVariablesIn(SchemeList rule) {

        increaseRuleApplicationId();
        return (SchemeList) treeWalk(rule);
    }

    private Object treeWalk(Object exp) {

        if (isVar(exp)) {
            return makeNewVariable((SchemeList) exp);
        } else if (isPair(exp)) {
            SchemeList pair = (SchemeList) exp;
            return cons(treeWalk(pair.car()), treeWalk(pair.cdr()));
        } else {
            return exp;
        }
    }

    private Object unifyMatch(Object p1, Object p2, Object frame) {

        if (FAILED_SYMBOL.equals(frame)) {
            return FAILED_SYMBOL;
        } else if (Objects.equals(p1, p2)) {
            return frame;
        } else if (isVar(p1)) {
            return extendIfPossible(p1, p2, (SchemeList) frame);
        } else if (isVar(p2)) {
            return extendIfPossible(p2, p1, (SchemeList) frame);
        } else if (isPair(p1) && isPair(p2)) {
            SchemeList pair1 = (SchemeList) p1;
            SchemeList pair2 = (SchemeList) p2;
            return unifyMatch(pair1.cdr(), pair2.cdr(), unifyMatch(pair1.car(), pair2.car(), frame));
        } else {
            return FAILED_SYMBOL;
        }
    }

    private Object extendIfPossible(Object var, Object val, SchemeList frame) {

        SchemeList binding = bindingInFrame(var, frame);
        if (binding != null) {
            return unifyMatch(bindingValue(binding), val, frame);
        } else if (isVar(val)) {
            binding = bindingInFrame(val, frame);
            if (binding != null) {
                return unifyMatch(var, bindingValue(binding), frame);
            } else {
                return extend(var, val, frame);
            }
        } else if (isDependsOn(val, var, frame)) {
            return FAILED_SYMBOL;
        } else {
            return extend(var, val, frame);
        }
    }

    private boolean isDependsOn(Object exp, Object var, SchemeList frame) {

        if (isVar(exp)) {
            if (Objects.equals(var, exp)) {
                return true;
            } else {
                SchemeList binding = bindingInFrame(exp, frame);
                if (binding != null) {
                    return isDependsOn(bindingValue(binding), var, frame);
                } else {
                    return false;
                }
            }
        } else if (isPair(exp)) {
            SchemeList pair = (SchemeList) exp;
            return (isDependsOn(pair.car(), var, frame)) || (isDependsOn(pair.cdr(), var, frame));
        } else {
            return false;
        }
    }

    private SchemeList extend(Object variable, Object value, SchemeList frame) {

        return cons(makeBinding(variable, value), frame);
    }

    private List<SchemeList> fetchRules(SchemeList pattern) {

        if (useIndex(pattern)) {
            return getIndexedRules(pattern);
        } else {
            return globalRules;
        }
    }

    private List<SchemeList> getIndexedRules(SchemeList pattern) {

        List<SchemeList> result = new ArrayList<>();
        for (SchemeList rule : getRules(indexKeyOf(pattern))) {
            result.add(rule);
        }
        for (SchemeList rule : getRules("?")) {
            result.add(rule);
        }
        return result;
    }

    private List<SchemeList> getRules(Object key) {

        List<SchemeList> rules = ruleCache.get(key);
        if (rules == null) {
            rules = new ArrayList<>(0);
            ruleCache.put(key, rules);
        }
        return rules;
    }

    private Object conclusion(SchemeList rule) {

        return rule.cadr();
    }

    private SchemeList makeNewVariable(SchemeList exp) {

        return cons("?", cons(ruleCounter, exp.cdr()));
    }

    private SchemeList makeBinding(Object variable, Object value) {

        return cons(variable, value);
    }

    private void increaseRuleApplicationId() {

        ruleCounter++;
    }

    private Object type(Object exp) {

        if (isPair(exp)) {
            return ((SchemeList) exp).car();
        } else {
            throw new RuntimeException("Unknown expression TYPE " + exp);
        }
    }

    private SchemeList ruleBody(SchemeList rule) {

        Object ruleBody = rule.caddr();
        if (ruleBody != null) {
            return (SchemeList) ruleBody;
        } else {
            return list("always-true");
        }
    }

    public String addRuleOrAssertion(SchemeList assertion) {

        if (isRule(assertion)) {
            return addRule(assertion);
        } else {
            return addAssertion(assertion);
        }
    }

    private String addAssertion(SchemeList assertion) {

        // TODO
        return "ok";
    }

    private String addRule(SchemeList rule) {

        storeRuleInIndex(rule);
        List<SchemeList> newRules = new ArrayList<>(globalRules.size() + 1);
        newRules.add(rule);
        newRules.addAll(globalRules);
        this.globalRules = newRules;
        return "ok";
    }

    private void storeRuleInIndex(SchemeList rule) {

        SchemeList pattern = (SchemeList) conclusion(rule);
        if (indexable(pattern)) {
            Object key = indexKeyOf(pattern);
            List<SchemeList> oldRules = ruleCache.get(key);
            if (oldRules == null) {
                oldRules = Collections.emptyList();
            }
            List<SchemeList> newRules = new ArrayList<>(oldRules.size() + 1);
            newRules.add(rule);
            if (!oldRules.isEmpty()) {
                newRules.addAll(oldRules);
            }
            ruleCache.put(key, newRules);
        }
    }

    private boolean indexable(SchemeList pattern) {

        return isConstantSymbol(pattern.car()) || isVar(pattern.car());
    }

    private boolean useIndex(SchemeList pattern) {

        return !pattern.isEmpty() && isConstantSymbol(pattern.car());
    }

    private Object indexKeyOf(SchemeList pattern) {

        Object key = pattern.car();
        return isVar(key) ? "?" : key;
    }

    private boolean isConstantSymbol(Object exp) {

        return exp != null && exp.getClass() == String.class;
    }

    private boolean isRule(SchemeList statement) {

        return taggedList(statement, "rule");
    }

    private Object contents(Object exp) {

        if (isPair(exp)) {
            return ((SchemeList) exp).cdr();
        } else {
            throw new RuntimeException("Unknown expression CONTENTS " + exp);
        }
    }
}
