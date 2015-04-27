package qeval;

import static qeval.QueryEvalUtils.bindingInFrame;
import static qeval.QueryEvalUtils.bindingValue;
import static qeval.QueryEvalUtils.isPair;
import static qeval.QueryEvalUtils.isVar;
import static qeval.SchemeList.cons;
import static qeval.SchemeList.list;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class QueryDriverLoop {

    public static void main(String[] args) {

        QueryEvaluator evaluator = new QueryEvaluator();
        SchemeList rule1 = list("rule", list("append-to-form", list(), list("?", "y"), list("?", "y")));
        SchemeList rule2Part1 = list("append-to-form", list(list("?", "u"), "?", "v"), list("?", "y"),
                list(list("?", "u"), "?", "z"));
        SchemeList rule2Part2 = list("append-to-form", list("?", "v"), list("?", "y"), list("?", "z"));
        SchemeList rule2 = list("rule", rule2Part1, rule2Part2);
        evaluator.addRuleOrAssertion(rule1);
        evaluator.addRuleOrAssertion(rule2);

        SchemeList query = list("append-to-form", list("a", "b"), list("?", "y"), list("a", "b", "c", "d"));
        SchemeList evalResult = evaluator.eval(query, list(SchemeList.EMPTY_LIST));
        List<Object> convertedResult = new ArrayList<>(evalResult.size());
        for (Object frame : evalResult) {
            convertedResult.add(instantiate(query, (SchemeList) frame));
        }
        SchemeList results = list(convertedResult);
        Iterator<Object> iterator = evalResult.iterator();
        for (Object result : results) {
            System.out.println(iterator.next());
            System.out.println(result);
            System.out.println();
        }
    }

    private static Object instantiate(Object exp, SchemeList frame) {

        if (isVar(exp)) {
            SchemeList binding = bindingInFrame(exp, frame);
            if (binding != null) {
                return instantiate(bindingValue(binding), frame);
            } else {
                return contractQuestionMark((SchemeList) exp);
            }
        } else if (isPair(exp)) {
            SchemeList pair = (SchemeList) exp;
            return cons(instantiate(pair.car(), frame), instantiate(pair.cdr(), frame));
        } else {
            return exp;
        }
    }

    private static Object contractQuestionMark(SchemeList variable) {

        String result = null;
        Object value = variable.cadr();
        if (value.getClass() == int.class) {
            result = variable.caddr() + "=" + value;
        } else {
            result = value.toString();
        }
        return "?" + result;
    }
}
