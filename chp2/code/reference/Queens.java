import java.util.ArrayList;
import java.util.List;

/**
 * The java implementation of Eight Queens Puzzle 
 * 
 * @author huangjing
 */
public class Queens {

    private static final int BOARD_SIEZ = 8;

    public static void main(String[] args) throws Exception {

        List<List<Integer>> result = queenCols(BOARD_SIEZ);
        System.out.println(result.size());
        System.out.println(result);
    }

    private static List<List<Integer>> queenCols(int k) {

        if (k == 0) {
            return new ArrayList<>();
        }
        List<Integer> rowNumbers = new ArrayList<>(BOARD_SIEZ);
        for (int i = 1; i <= BOARD_SIEZ; i++) {
            rowNumbers.add(i);
        }
        List<List<Integer>> all = new ArrayList<>();
        List<List<Integer>> cols = queenCols(k - 1);
        if (cols.isEmpty()) {
            cols = new ArrayList<>();
            cols.add(new ArrayList<Integer>());
        }
        for (List<Integer> restOfQueens : cols) {
            for (Integer rowNumber : rowNumbers) {
                List<Integer> list = new ArrayList<>();
                list.add(rowNumber);
                list.addAll(restOfQueens);
                all.add(list);
            }
        }
        List<List<Integer>> result = new ArrayList<>();
        for (List<Integer> position : all) {
            if (isSafe(k, position)) {
                result.add(position);
            }
        }

        return result;
    }

    private static boolean isSafe(int k, List<Integer> position) {

        return checkSafe(position.get(0), position.subList(1, position.size()), 1);
    }

    private static boolean checkSafe(int rowOfNewQueen, List<Integer> restOfQueens, int i) {

        if (restOfQueens == null || restOfQueens.isEmpty()) {
            return true;
        }
        int rowOfCurrentQueen = restOfQueens.get(0);
        if (rowOfNewQueen == rowOfCurrentQueen) {
            return false;
        } else if (rowOfNewQueen == rowOfCurrentQueen + i) {
            return false;
        } else if (rowOfNewQueen == rowOfCurrentQueen - i) {
            return false;
        }
        return checkSafe(rowOfNewQueen, restOfQueens.subList(1, restOfQueens.size()), i + 1);
    }
}
