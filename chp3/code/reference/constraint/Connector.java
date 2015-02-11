package constraint;

import java.util.Collections;
import java.util.LinkedList;
import java.util.Queue;

public class Connector<T> {

    private String name;

    private T value;

    private Object informant = null;

    private Queue<Constraint> constraints = Collections.asLifoQueue(new LinkedList<Constraint>());

    private Connector(String name) {

        this.name = name;
    }

    public static <T> Connector<T> create(String name) {

        return new Connector<>(name);
    }

    public boolean hasValue() {

        return informant != null;
    }

    public void setValue(T newVal, Object setter) {

        if (!hasValue()) {
            this.value = newVal;
            this.informant = setter;
            for (Constraint constraint : constraints) {
                if (!constraint.equals(setter)) {
                    constraint.processNewValue();
                }
            }
        } else if (!newVal.equals(value)) {
            throw new RuntimeException("Contradiction (" + value + " " + newVal + ")");
        }
    }

    public T getValue() {

        return this.value;
    }

    public void forget(Object retractor) {

        System.out.println(retractor);
        if (retractor.equals(informant)) {
            this.informant = null;
            for (Constraint constraint : constraints) {
                if (!constraint.equals(retractor)) {
                    constraint.processForgetValue();
                }
            }
        }
    }

    public void connect(Constraint newConstraint) {

        if (!constraints.contains(newConstraint)) {
            constraints.add(newConstraint);
        }
        if (hasValue()) {
            newConstraint.processNewValue();
        }
    }

    public String getName() {

        return name;
    }

    @Override
    public String toString() {

        return "Connector [name=" + name + ", value=" + value + ", informant=" + informant + "]";
    }
}
