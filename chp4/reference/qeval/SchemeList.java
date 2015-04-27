package qeval;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

public class SchemeList implements Iterable<Object> {

    public static final SchemeList EMPTY_LIST = new SchemeList(Collections.emptyList());

    private List<Object> list;

    private boolean pair = false;

    private SchemeList() {

    }

    private SchemeList(List<Object> list) {

        this.list = list;
    }

    public boolean isPair() {

        return pair;
    }

    @Override
    public Iterator<Object> iterator() {

        return list.iterator();
    }

    public Object car() {

        return isEmpty() ? null : iterator().next();
    }

    public Object cadr() {

        return list.size() > 1 ? list.get(1) : null;
    }

    public Object caddr() {

        return list.size() > 2 ? list.get(2) : null;
    }

    public Object cdr() {

        if (isEmpty()) {
            return EMPTY_LIST;
        } else if (isPair()) {
            return list.get(1);
        } else {
            SchemeList schemeList = new SchemeList();
            schemeList.list = this.list.subList(1, this.list.size());
            return schemeList;
        }
    }

    public boolean isEmpty() {

        return list == null || list.isEmpty();
    }

    public int size() {

        return list == null ? 0 : list.size();
    }

    @Override
    public int hashCode() {

        final int prime = 31;
        int result = 1;
        result = prime * result + ((list == null) ? 0 : list.hashCode());
        result = prime * result + (pair ? 1231 : 1237);
        return result;
    }

    @Override
    public boolean equals(Object obj) {

        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        SchemeList other = (SchemeList) obj;
        if (list == null) {
            if (other.list != null) {
                return false;
            }
        } else if (!list.equals(other.list)) {
            return false;
        }
        if (pair != other.pair) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {

        if (isPair()) {
            return "(" + list.get(0) + " . " + list.get(1) + ")";
        } else {
            boolean first = true;
            StringBuilder result = new StringBuilder();
            result.append("(");
            for (Object obj : list) {
                if (first) {
                    first = false;
                } else {
                    result.append(" ");
                }
                result.append(obj);
            }
            result.append(")");
            return result.toString();
        }
    }

    public static SchemeList cons(Object left, Object right) {

        SchemeList schemeList = new SchemeList();
        ArrayList<Object> pair = new ArrayList<>();
        pair.add(left);
        if (right instanceof SchemeList) {
            SchemeList rightList = (SchemeList) right;
            if (rightList.isPair()) {
                pair.add(rightList);
                schemeList.pair = true;
            } else {
                for (Object obj : rightList.list) {
                    pair.add(obj);
                }
            }
        } else {
            pair.add(right);
            schemeList.pair = true;
        }
        pair.trimToSize();
        schemeList.list = pair;
        return schemeList;
    }

    public static SchemeList list(Object... objs) {

        return list(Arrays.asList(objs));
    }

    public static SchemeList list(List<Object> list) {

        SchemeList schemeList = new SchemeList();
        if (list instanceof ArrayList) {
            ((ArrayList<?>) list).trimToSize();
        }
        schemeList.list = list;
        return schemeList;
    }
}
