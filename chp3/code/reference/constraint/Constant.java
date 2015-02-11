package constraint;

public class Constant<T> implements Constraint {

    private T value;

    private Connector<T> connector;

    private Constant(T value, Connector<T> connector) {

        this.value = value;
        this.connector = connector;
    }

    public static <T> Constant<T> create(T value, Connector<T> connector) {

        Constant<T> constant = new Constant<T>(value, connector);
        connector.connect(constant);
        connector.setValue(value, constant);
        return constant;
    }

    @Override
    public void processNewValue() {

        throw new UnsupportedOperationException("New value operation is unsupported in Constant");
    }

    @Override
    public void processForgetValue() {

        throw new UnsupportedOperationException("Forget value operation is unsupported in Constant");
    }

    @Override
    public String toString() {

        return "Constant [value=" + value + ", connector=" + connector + "]";
    }
}
