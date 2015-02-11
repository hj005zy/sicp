package constraint;

public class Adder implements Constraint {

    private Connector<Integer> a1;

    private Connector<Integer> a2;

    private Connector<Integer> sum;

    private Adder(Connector<Integer> a1, Connector<Integer> a2, Connector<Integer> sum) {

        this.a1 = a1;
        this.a2 = a2;
        this.sum = sum;
    }

    public static Adder create(Connector<Integer> a1, Connector<Integer> a2, Connector<Integer> sum) {

        Adder adder = new Adder(a1, a2, sum);
        adder.init();
        return adder;
    }

    private void init() {

        a1.connect(this);
        a2.connect(this);
        sum.connect(this);
    }

    @Override
    public void processNewValue() {

        if (a1.hasValue() && a2.hasValue()) {
            sum.setValue((a1.getValue() + a2.getValue()), this);
        } else if (a1.hasValue() && sum.hasValue()) {
            a2.setValue((sum.getValue() - a1.getValue()), this);
        } else if (a2.hasValue() && sum.hasValue()) {
            a1.setValue((sum.getValue() - a2.getValue()), this);
        }
    }

    @Override
    public void processForgetValue() {

        sum.forget(this);
        a1.forget(this);
        a2.forget(this);
        processNewValue();
    }
}
