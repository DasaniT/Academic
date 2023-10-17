
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Q3 {
    public static void main(String[] args) throws MatrixMultiplyVectorException, SumOfMatrixException {
        Scanner input = new Scanner(System.in);
        Integer n = Integer.parseInt(input.nextLine());
        String splitter = input.nextLine();
        ArrayList<String> stringArrayList = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            stringArrayList.add(input.nextLine());
        }
        String searcher = input.nextLine();
        Matrix transferMatrix = transferMatrix(stringArrayList);//A
        stringArrayList.add(searcher);
        stringArrayList = hashtagRemover(stringArrayList);
        VectorB wordsOrderVector = new VectorB(n);//v_0
        double[] result = new double[n];
        for (int i = 0; i < n; i++) {
            result[i] = wordsOrderVector(wordsOrderMatrix(stringArrayList, splitter, stringArrayList.get(i)), wordsOrderMatrix(stringArrayList, splitter, stringArrayList.get(stringArrayList.size() - 1)));
        }

        wordsOrderVector.setValues(result);
        VectorB orderTransferWordVector = orderTransferWordVector(transferMatrix, wordsOrderVector);//output
        ArrayList<Double> doubleArrayList = new ArrayList<>();
        for (int i = 0; i < orderTransferWordVector.getValues().length; i++) {
            doubleArrayList.add(orderTransferWordVector.getValues()[i]);
        }
        DecimalFormat df = new DecimalFormat("0.#####");
        int max_index = 0;
        for (int i = 0; i < 10; i++) {
            max_index = findGreatestIndex(doubleArrayList);
            System.out.print(df.format(doubleArrayList.get(max_index)) + ": " + stringArrayList.get(max_index));
            System.out.println();
            doubleArrayList.remove(max_index);
            stringArrayList.remove(max_index);
            if (doubleArrayList.size() == 0) break;
        }

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

    private static ArrayList<String> sortAndMainLine(ArrayList<String> stringArrayList, String splitter) {
        ArrayList<String> result = new ArrayList<>();
        for (int i = 0; i < stringArrayList.size(); i++) {
            ArrayList<String> strings = split(stringArrayList.get(i), splitter);
            for (int j = 0; j < strings.size(); j++) {
                if (!result.contains(strings.get(j))) {
                    result.add(strings.get(j));
                }
            }
            strings.clear();
        }
        Collections.sort(result);
        return result;
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
                            if (j == stringArrayList.get(i).length() - 1) break;
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

    private static VectorB orderTransferWordVector(Matrix matrix, VectorB vector) throws MatrixMultiplyVectorException, SumOfMatrixException {//matrix = A | transferMatrix and vector = v_0

        Matrix one = new Matrix(matrix.getRows(), matrix.getColumns());
        for (int i = 0; i < matrix.getRows(); i++) {
            for (int j = 0; j < matrix.getColumns(); j++) {
                one.getValues()[i][j] = 1;
            }
        }
        VectorB temp = new VectorB(vector.getRows());
        vector = vector.normal();
        temp = (matrix.scalarMultiplication(0.85).sum(one.scalarMultiplication(0.15 / matrix.getRows()))).matrixMultiplyVector(vector);
//        for (int i = 0; i < 100; i++) {
        while (!temp.convergence(matrix.scalarMultiplication(0.85).sum(one.scalarMultiplication(0.15 / matrix.getRows())).matrixMultiplyVector(temp))) {
            temp = temp.normal();
            temp = (matrix.scalarMultiplication(0.85).sum(one.scalarMultiplication(0.15 / matrix.getRows()))).matrixMultiplyVector(temp);
//        }
        }
        return temp.normal();
    }

    private static int[] wordsOrderMatrix(ArrayList<String> stringArrayList, String splitter, String string) {

        ArrayList<String> mainline = sortAndMainLine(stringArrayList, splitter);
        ArrayList<String> strings = split(string, splitter);
        int[] ints = new int[strings.size()];

        for (int i = 0; i < strings.size(); i++) {
            for (int j = 0; j < mainline.size(); j++) {
                if (strings.get(i).equals(mainline.get(j))) {
                    ints[i] = j;
                    break;
                }
            }
        }
        return ints;
    }

    private static double wordsOrderVector(int[] ints, int[] c) {//c=line akhar
        double doubles = 0.0;
//        String ft = stringArrayList.get(stringArrayList.size() - 1);
//        ArrayList<String> last = split(ft, splitter);
        ArrayList<Integer> lastLineInts = new ArrayList<>();


        for (int i = 0; i < c.length; i++) {
            lastLineInts.add(c[i]);
        }
        ArrayList<Integer> temp = new ArrayList<>();
        ArrayList<Integer> indexes = new ArrayList<>();
        int m = 0;
        int w = 0;
        int l = 0;
        for (int i = 0; i < ints.length; i++) {
            temp.add(ints[i]);
        }
        a:
        while (l < 10) {
            for (int j = 0; j < lastLineInts.size(); j++) {
                for (int k = 0; k < temp.size(); k++) {
                    if (temp.get(k) == lastLineInts.get(j)) {
                        if (j == 0 && k >= m) {
//                            temp.remove(k);
                            indexes.add(k);
                            m = k;
                            break;
                        } else if (j > 0 && k > w && k > m) {
                            indexes.add(k);
                            w = k;
                            break;
                        }
                    }
                }
            }
            if (temp.size() > 0) {
                temp.remove(m);
            }

            if (indexes.size() < lastLineInts.size()) {
                doubles += 0.0;
                indexes.clear();
                break a;
            } else {
                double h = (double) lastLineInts.size() / ((double) indexes.get(indexes.size() - 1) - (double) indexes.get(0) + 1);
                doubles += h;
                indexes.clear();
            }
            w = 0;
            m = 0;
            l++;
        }


        return doubles;
    }

    private static int findGreatestIndex(ArrayList<Double> doubles) {
        int max_index = 0;
        for (int i = 1; i < doubles.size(); i++) {
            max_index = doubles.get(i) > doubles.get(max_index) ? i : max_index;
        }
        return max_index;
    }

}