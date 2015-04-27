package qeval;

interface QueryFunction {

    SchemeList invoke(Object arg, SchemeList frameStream);
}
