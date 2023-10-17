import java.text.DecimalFormat;
import java.util.*;

public class Q4 {
    public static void main(String[] args) throws MatrixMultiplicationException, MatrixMultiplyVectorException {
        Scanner input = new Scanner(System.in);
        Integer n = Integer.parseInt(input.nextLine());
        String splitter = input.nextLine();
        ArrayList<String> stringArrayList = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            stringArrayList.add(input.nextLine());
        }
        String searcher = input.nextLine();
        ArrayList<Integer> indexes = new ArrayList<>();
        Set<String> result = new HashSet<>();
        ArrayList<String> newStringArrayList = new ArrayList<>();
        for (int i = 0; i < stringArrayList.size(); i++) {
            newStringArrayList.add(stringArrayList.get(i));
        }
        for (int i = 0; i < stringArrayList.size(); i++) {
            if (existsOrNot(split(searcher, splitter), split(hashtagRemover(stringArrayList).get(i), splitter))) {
                result.add(newStringArrayList.get(i));
                indexes.add(i + 1);
            }
        }
        if (result.size()==0) return;
        String temp = "";
        for (Integer i = 0; i < n; i++) {
            if (!indexes.contains(i + 1)) {
                for (int j = 0; j < newStringArrayList.get(i).length(); j++) {
                    if (newStringArrayList.get(i).charAt(j) == '#') {
                        while ((int) newStringArrayList.get(i).charAt(j + 1) >= 48 && (int) newStringArrayList.get(i).charAt(j + 1) <= 57) {
                            temp += newStringArrayList.get(i).charAt(j + 1);
                            j++;
                        }
                        if (indexes.contains(Integer.parseInt(temp))) {
                            result.add(newStringArrayList.get(i));
                            break;
                        }
                        temp = "";
                    }
                }
            }
        }
        temp = "";
        for (Integer i = 0; i < n; i++) {
            if (indexes.contains(i + 1)) {
                for (int j = 0; j < newStringArrayList.get(i).length(); j++) {
                    if (newStringArrayList.get(i).charAt(j) == '#') {
                        while ((int) newStringArrayList.get(i).charAt(j + 1) >= 48 && (int) newStringArrayList.get(i).charAt(j + 1) <= 57) {
                            temp += newStringArrayList.get(i).charAt(j + 1);
                            j++;
                        }
                        if (!indexes.contains(Integer.parseInt(temp))) {
                            result.add(newStringArrayList.get(Integer.parseInt(temp) - 1));


                        }
                        temp = "";
                    }
                }
            }
        }
        ArrayList<String> base = new ArrayList<>();
        Iterator i1 = result.iterator();
        while (i1.hasNext()) {
            String a = (String) i1.next();
            base.add(a);
        }
        ArrayList<String> base2 = new ArrayList<>();
        for (int i = 0; i < base.size(); i++) {
            base2.add(base.get(i));
        }

        DecimalFormat df = new DecimalFormat("0.#####");
        Matrix transferMatrix = transferMatrix(base);
        Matrix transposedTransferMatrix = transferMatrix.transposed();
        VectorB hub = (transferMatrix.matrixMultiplication(transposedTransferMatrix)).eigenVector();
        VectorB authority = (transposedTransferMatrix.matrixMultiplication(transferMatrix)).eigenVector();
        ArrayList<Double> doubleArrayList = new ArrayList<>();
        base = hashtagRemover(base);
        base2 = hashtagRemover(base2);
        for (int i = 0; i < hub.getValues().length; i++) {
            doubleArrayList.add(hub.getValues()[i]);
        }
        int max_index = 0;
        System.out.println("hub");
        for (int i = 0; i < 10; i++) {
            max_index = findGreatestIndex(doubleArrayList);
            if (doubleArrayList.get(max_index)==0) break;
            System.out.print(df.format(doubleArrayList.get(max_index)) + ": " + base.get(max_index));
            System.out.println();
            base.remove(max_index);
            doubleArrayList.remove(max_index);

            if (doubleArrayList.size()==0) break;
        }
//        max_index = 0;
        doubleArrayList.clear();
        for (int i = 0; i < hub.getValues().length; i++) {
            doubleArrayList.add(authority.getValues()[i]);
        }
        System.out.println("----------------------------------");
        System.out.println("authority");
        for (int i = 0; i < 10; i++) {
            max_index = findGreatestIndex(doubleArrayList);
            if (doubleArrayList.get(max_index)==0) break;

            System.out.print(df.format(doubleArrayList.get(max_index)) + ": " + base2.get(max_index));
            System.out.println();
            doubleArrayList.remove(max_index);
            base2.remove(max_index);
            if (doubleArrayList.size()==0) break;
        }
//        System.out.println("hub");
//
//        System.out.println("----------------------------------");
//        for (Integer i = 0; i < n; i++) {
//            System.out.print(df.format(hub.getValues()[i]) + ": " + base.get(i));
//            System.out.println();
//        }
//        System.out.println("authority");
//        for (Integer i = 0; i < n; i++) {
//            System.out.print(df.format(authority.getValues()[i]) + ": " + base.get(i));
//            System.out.println();
//        }
    }

    private static ArrayList<String> split(String string, String splitter) {
        ArrayList<String> result = new ArrayList<>();
        String st1 = "";
        int m = 0;
        for (int i = 0; i < string.length(); i++) {
            for (int j = 0; j < splitter.length(); j++) {
                if (string.charAt(i) == splitter.charAt(j)) {
                    for (int i1 = m; i1 < i; i1++) {
                        st1 += string.charAt(i1);
                    }
                    m = i + 1;
                    if (st1 != "") {
                        result.add(st1);
                    }
                    st1 = "";
                    break;
                }
            }
        }
        st1 = "";
        for (int i = m; i < string.length(); i++) {
            st1 += string.charAt(i);

        }
        if (st1 != "") {
            result.add(st1);
        }

        return result;
    }

    private static boolean existsOrNot(ArrayList<String> searcherSplit, ArrayList<String> stringArrayListGetiSplit) {
        int counter = 0;
        if (searcherSplit.size() > stringArrayListGetiSplit.size()) return false;
        else {

            for (int i = 0; i < searcherSplit.size(); i++) {
                for (int j = 0; j < stringArrayListGetiSplit.size(); j++) {
                    if (searcherSplit.get(i).equals(stringArrayListGetiSplit.get(j))) {
                        counter++;
                        break;
                    }
                }
            }

        }
        if (counter == searcherSplit.size()) return true;
        else {
            return false;
        }

    }

    private static ArrayList<String> hashtagRemover(ArrayList<String> stringArrayList) {
        int n = stringArrayList.size();
        String temp = "";
        for (int i = 0; i < stringArrayList.size(); i++) {
            for (int j = 0; j < stringArrayList.get(i).length(); j++) {
                if (stringArrayList.get(i).charAt(j) == '#') {
                    while ((int) stringArrayList.get(i).charAt(j + 1) >= 48 && (int) stringArrayList.get(i).charAt(j + 1) <= 57) {
                        j++;
                    }
                } else {
                    temp += stringArrayList.get(i).charAt(j);
                }
            }
            stringArrayList.remove(i);
            stringArrayList.add(i, temp);
            temp = "";
        }
        return stringArrayList;
    }

    private static Matrix transferMatrix(ArrayList<String> stringArrayList) {
        Matrix result = new Matrix(stringArrayList.size(), stringArrayList.size());
        int n = stringArrayList.size();
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                result.getValues()[i][j] = 0.0;
            }
        }
        int[] temp = new int[n];
        for (int i = 0; i < temp.length; i++) {
            temp[i] = 0;
        }
        String tem = "";
        for (int i = 0; i < stringArrayList.size(); i++) {
            for (int j = 0; j < stringArrayList.get(i).length(); j++) {
                if (stringArrayList.get(i).charAt(j) == '#') {
                    temp[i]++;
                }
            }
        }
        tem = "";
        int temporary = 0;
        for (int i = 0; i < stringArrayList.size(); i++) {
            for (int k = 1; k <= n; k++) {
                for (int j = 0; j < stringArrayList.get(i).length(); j++) {
                    if (stringArrayList.get(i).charAt(j) == '#') {
                        while ((int) stringArrayList.get(i).charAt(j + 1) >= 48 && (int) stringArrayList.get(i).charAt(j + 1) <= 57) {
                            tem += stringArrayList.get(i).charAt(j + 1);
                            j++;
                            if (j==stringArrayList.get(i).length()-1) break;
                        }
                        if (Integer.parseInt(tem) == k) {
                            temporary++;
                        }
                        tem = "";
                    }
                }
                if (temporary != 0) {
                    if (temp[i] == 0) {
                        result.getValues()[i][k - 1] = 0.0;
                    } else {
                        result.getValues()[i][k - 1] = (double) temporary / (double) temp[i];
                    }
                    temporary = 0;
                }
            }
        }
        return result;
    }

    private static int findGreatestIndex(ArrayList<Double> doubles) {
        int max_index = 0;
        for (int i = 1; i < doubles.size(); i++) {
            max_index = doubles.get(i) > doubles.get(max_index) ? i : max_index;
        }
        return max_index;
    }

}
