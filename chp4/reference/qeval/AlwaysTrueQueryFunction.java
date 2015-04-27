package qeval;

class AlwaysTrueQueryFunction implements QueryFunction {

    @Override
    public SchemeList invoke(Object arg, SchemeList frameStream) {

        return frameStream;
    }
}
