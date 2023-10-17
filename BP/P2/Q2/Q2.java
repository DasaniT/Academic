import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Q2 {
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
        VectorB vectorB = wordsVector(n, wordsMatrix(n, stringArrayList, splitter), stringArrayList, splitter);//v_0
        VectorB transferWordVector = transferWordVector(transferMatrix, vectorB);//output
        ArrayList<Double> doubleArrayList = new ArrayList<>();
        for (int i = 0; i < transferWordVector.getValues().length; i++) {
            doubleArrayList.add(transferWordVector.getValues()[i]);
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

    private static Matrix wordsMatrix(int n, ArrayList<String> stringArrayList, String splitter) {
        Matrix ints = new Matrix(n + 1, sortAndMainLine(stringArrayList, splitter).size());
        ArrayList<String> mainline = sortAndMainLine(stringArrayList, splitter);
        for (int i = 0; i < n + 1; i++) {
            ArrayList<String> temp = split(stringArrayList.get(i), splitter);
            for (int j = 0; j < mainline.size(); j++) {
                for (int k = 0; k < temp.size(); k++) {
                    if (mainline.get(j).equals(temp.get(k))) {
                        ints.getValues()[i][j]++;
                    }
                }
            }
        }
        return ints;
    }

    private static VectorB wordsVector(int n, Matrix matrix, ArrayList<String> stringArrayList, String splitter) {
        VectorB ints = new VectorB(n);
        ArrayList<String> s = sortAndMainLine(stringArrayList, splitter);
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < s.size(); j++) {
                ints.getValues()[i] += matrix.getValues()[i][j] * matrix.getValues()[matrix.getRows() - 1][j];
            }
        }
        return ints;
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

    private static VectorB transferWordVector(Matrix matrix, VectorB vector) throws MatrixMultiplyVectorException, SumOfMatrixException {//matrix = A | transferMatrix and vector = v_0

        Matrix one = new Matrix(matrix.getRows(), matrix.getColumns());
        for (int i = 0; i < matrix.getRows(); i++) {
            for (int j = 0; j < matrix.getColumns(); j++) {
                one.getValues()[i][j] = 1;
            }
        }
        VectorB temp = new VectorB(vector.getRows());
        vector = vector.normal();
        Matrix tem = matrix.scalarMultiplication(0.85);
        one = one.scalarMultiplication(0.15 / matrix.getRows());
        Matrix temporary = tem.sum(one);
        temp = temporary.matrixMultiplyVector(vector);
        for (int i = 0; i < 1000; i++) {
//        while (!temp.convergence((temporary).matrixMultiplyVector(temp))) {
            temp = temp.normal();
            temp = (temporary).matrixMultiplyVector(temp);

        }
        return temp.normal();
    }

    private static int findGreatestIndex(ArrayList<Double> doubles) {
        int max_index = 0;
        for (int i = 1; i < doubles.size(); i++) {
            max_index = doubles.get(i) > doubles.get(max_index) ? i : max_index;
        }
        return max_index;
    }


}