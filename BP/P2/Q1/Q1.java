import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Q1 {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        Integer n = Integer.parseInt(input.nextLine());
        String splitter = input.nextLine();
        ArrayList<String> stringArrayList = new ArrayList<>();
        ArrayList<String> mainline = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            stringArrayList.add(input.nextLine());
        }
        Matrix transferMatrix = transferMatrix(stringArrayList);
        stringArrayList = hashtagRemover(stringArrayList);
        mainline = sortAndMainLine(stringArrayList, splitter);
        Matrix wordsMatrix = wordsMatrix(n, stringArrayList, splitter);
        for (int i = 0; i < mainline.size(); i++) {
            System.out.print(mainline.get(i) + " ");
        }
        System.out.println();
        DecimalFormat df = new DecimalFormat("0.#####");
        wordsMatrix.printMatrix();
        for (int i = 0; i < n; i++) {
            int[] wordsOrderMatrix = wordsOrderMatrix(stringArrayList, splitter, stringArrayList.get(i));
            for (int j = 0; j < wordsOrderMatrix.length; j++) {
                System.out.printf("%d ", wordsOrderMatrix[j]);
            }
            System.out.println();
        }
        transferMatrix.printMatrix();
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
        Matrix ints = new Matrix(n, sortAndMainLine(stringArrayList, splitter).size());
        ArrayList<String> mainline = sortAndMainLine(stringArrayList, splitter);
        for (int i = 0; i < n; i++) {
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


}
