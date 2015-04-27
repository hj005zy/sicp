package qeval;

import java.util.Objects;

public abstract class QueryEvalUtils {

    public static boolean isVar(Object exp) {

        return taggedList(exp, "?");
    }

    public static boolean taggedList(Object exp, String tag) {

        if (isPair(exp)) {
            return tag.equals(((SchemeList) exp).car());
        } else {
            return false;
        }
    }

    public static boolean isPair(Object exp) {

        Objects.requireNonNull(exp);
        if (exp instanceof SchemeList) {
            return !((SchemeList) exp).isEmpty();
        } else {
            return false;
        }
    }

    public static SchemeList bindingInFrame(Object variable, SchemeList frame) {

        for (Object obj : frame) {
            if (isPair(obj)) {
                SchemeList pair = (SchemeList) obj;
                if (Objects.equals(variable, pair.car())) {
                    return pair;
                }
            }
        }
        return null;
    }

    public static Object bindingValue(SchemeList binding) {

        return binding.cdr();
    }
}
