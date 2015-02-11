package constraint;

/**
 * The Java implementatioin of Propagation of Constraints
 * 
 * @author huangjing
 */
public class CelsiusFahrenheitConverter {

    public static void main(String[] args) {

        Connector<Integer> c = Connector.create("c");
        Connector<Integer> f = Connector.create("f");
        buildConstraintNetworks(c, f);

        Probe.create("Celsius temp", c);
        Probe.create("Fahrenheit temp", f);

        c.setValue(25, "user");

        // If we try to set F to a new value the connector
        // will complain that it has sensed a contradiction.
        try {
            f.setValue(212, "user");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        // So we should tell C to forget its old value first.
        // This information eventually propagates to F which now finds that
        // it has no reason for continuing to believe that its own value is 77.
        c.forget("user");

        f.setValue(212, "user");
    }

    private static void buildConstraintNetworks(Connector<Integer> c, Connector<Integer> f) {

        Connector<Integer> u = Connector.create("u");
        Connector<Integer> v = Connector.create("v");
        Connector<Integer> w = Connector.create("w");
        Connector<Integer> x = Connector.create("x");
        Connector<Integer> y = Connector.create("y");

        Multiplier.create(c, w, u);
        Multiplier.create(v, x, u);
        Adder.create(v, y, f);
        Constant.create(9, w);
        Constant.create(5, x);
        Constant.create(32, y);
    }
}
