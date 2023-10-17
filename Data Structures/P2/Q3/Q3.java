import java.util.Arrays;
import java.util.Scanner;

public class Q3 {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        String line = input.nextLine();
        int n = Integer.parseInt(line.split(" ")[0]);
        int m = Integer.parseInt(line.split(" ")[1]);
        int result = 0;
        int[] prefix = new int[n * 60];
        for (int i = 0; i < n; i++) {
            line = input.nextLine();
            for (int j = 0; j < line.length(); j++) {
                prefix[i * 60 + j] = hash(line.substring(0, j + 1));
            }
        }
        Arrays.sort(prefix);
        for (int i = 0; i < m; i++) {
            line = input.nextLine();
            int hashCode = hash(line);
            if (Arrays.binarySearch(prefix, hashCode) >= 0) {
                result++;
            }
        }
        System.out.println(result);
    }

    static int hash(String string) {
        int hash = 0;
        int prime = 16777619;
        for (int i = 0; i < string.length(); i++) {
//            hash = (hash * 31 + string.charAt(i));
            hash = hash * prime;
            hash = hash ^ string.charAt(i);
        }
        return hash;
    }
}
