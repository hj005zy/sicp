package constraint;

public class Multiplier implements Constraint {

    private Connector<Integer> m1;

    private Connector<Integer> m2;

    private Connector<Integer> product;

    public Multiplier(Connector<Integer> m1, Connector<Integer> m2, Connector<Integer> product) {

        this.m1 = m1;
        this.m2 = m2;
        this.product = product;
    }

    public static Multiplier create(Connector<Integer> m1, Connector<Integer> m2, Connector<Integer> product) {

        Multiplier multiplier = new Multiplier(m1, m2, product);
        multiplier.init();
        return multiplier;
    }

    private void init() {

        m1.connect(this);
        m2.connect(this);
        product.connect(this);
    }

    @Override
    public void processNewValue() {

        if (m1.hasValue() && m1.getValue() == 0) {
            product.setValue(0, this);
        } else if (m2.hasValue() && m2.getValue() == 0) {
            product.setValue(0, this);
        } else if (m1.hasValue() && m2.hasValue()) {
            product.setValue((m1.getValue() * m2.getValue()), this);
        } else if (m1.hasValue() && product.hasValue()) {
            m2.setValue((product.getValue() / m1.getValue()), this);
        } else if (m2.hasValue() && product.hasValue()) {
            m1.setValue((product.getValue() / m2.getValue()), this);
        }
    }

    @Override
    public void processForgetValue() {

        product.forget(this);
        m1.forget(this);
        m2.forget(this);
        processNewValue();
    }
}
