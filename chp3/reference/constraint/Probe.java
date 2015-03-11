package constraint;

public class Probe implements Constraint {

    private String name;

    private Connector<?> connector;

    private Probe(String name, Connector<?> connector) {

        this.name = name;
        this.connector = connector;
    }

    public static Probe create(String name, Connector<?> connector) {

        Probe probe = new Probe(name, connector);
        connector.connect(probe);
        return probe;
    }

    @Override
    public void processNewValue() {

        printProbe(connector.getValue());
    }

    @Override
    public void processForgetValue() {

        printProbe("?");
    }

    private void printProbe(Object value) {

        System.out.print("Probe: ");
        System.out.print(name);
        System.out.print(" = ");
        System.out.print(value);
        System.out.println();
    }

    @Override
    public String toString() {

        return "Probe [name=" + name + ", connector=" + connector + "]";
    }
}
