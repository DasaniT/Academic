import java.util.Scanner;

public class Q1 {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        int n = input.nextInt();
        int[] l = new int[n];
        int[] c = new int[n];
        for (int i = 0; i < n; i++) {
            l[i] = input.nextInt();
        }
        for (int i = 0; i < n; i++) {
            c[i] = input.nextInt();
        }
        int max_so_far = Integer.MIN_VALUE;
        int max_ending_here = 0;
        int begin = -1;
        int end = -1;
//        boolean flag = false;
        for (int i = n - 1; i >= 0; i--) {
            max_ending_here = max_ending_here + (c[i] - l[i]);
            if (max_so_far < max_ending_here) {
                max_so_far = max_ending_here;
                begin = i;
            }
            if (max_ending_here < 0) {
                max_ending_here = 0;
            }
        }
        for (int i = 0; i < n; i++) {
            max_ending_here = max_ending_here + (c[i] - l[i]);
            if (max_so_far < max_ending_here) {
                max_so_far = max_ending_here;
                end = i;
            }
            if (max_ending_here < 0) {
                max_ending_here = 0;
            }
        }
        int temp = max_so_far;
        for (int i = 0; i < begin; i++) {
            temp += c[i] - l[i];
        }
        for (int i = n - 1; i > end; i--) {
            temp += c[i] - l[i];
            if (temp > max_so_far) {
                max_so_far = temp;
                begin = i;
            }
        }
//        System.out.println(max_so_far);
        System.out.println(begin + 1);
    }
}
