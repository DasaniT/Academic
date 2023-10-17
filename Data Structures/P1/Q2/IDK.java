import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

/**
 * Created by Pixel on 12/15/2017.
 */
public class IDK {
    int[] count;

    public List<Integer> countSmaller(int[] nums, boolean rewind) {
        List<Integer> res = new ArrayList<Integer>();

        count = new int[nums.length];
        int[] indexes = new int[nums.length];
        for (int i = 0; i < nums.length; i++) {
            indexes[i] = i;
        }
        mergesort(nums, indexes, 0, nums.length - 1, rewind);
        for (int i = 0; i < count.length; i++) {
            res.add(count[i]);
        }
        return res;
    }

    private void mergesort(int[] nums, int[] indexes, int start, int end, boolean rewind) {
        if (end <= start) {
            return;
        }
        int mid = (start + end) / 2;
        mergesort(nums, indexes, start, mid, rewind);
        mergesort(nums, indexes, mid + 1, end, rewind);

        merge(nums, indexes, start, end, rewind);
    }

    private void merge(int[] nums, int[] indexes, int start, int end, boolean rewind) {
        int mid = (start + end) / 2;
        int left_index = start;
        int right_index = mid + 1;
        int rightcount = 0;
        int[] new_indexes = new int[end - start + 1];

        int sort_index = 0;
        while (left_index <= mid && right_index <= end) {
            if (!rewind) {
                if (nums[indexes[right_index]] < nums[indexes[left_index]]) {
                    new_indexes[sort_index] = indexes[right_index];
                    rightcount++;
                    right_index++;
                } else {
                    new_indexes[sort_index] = indexes[left_index];
                    count[indexes[left_index]] += rightcount;
                    left_index++;
                }
            } else {
                if (nums[indexes[right_index]] <= nums[indexes[left_index]]) {
                    new_indexes[sort_index] = indexes[right_index];
                    rightcount++;
                    right_index++;
                } else {
                    new_indexes[sort_index] = indexes[left_index];
                    count[indexes[left_index]] += rightcount;
                    left_index++;
                }
            }

            sort_index++;
        }
        while (left_index <= mid) {
            new_indexes[sort_index] = indexes[left_index];
            count[indexes[left_index]] += rightcount;
            left_index++;
            sort_index++;
        }
        while (right_index <= end) {
            new_indexes[sort_index++] = indexes[right_index++];
        }
        for (int i = start; i <= end; i++) {
            indexes[i] = new_indexes[i - start];
        }
    }

    public static void main(String[] args) {
        IDK idk = new IDK();
        Scanner input = new Scanner(System.in);
        int n = input.nextInt();

        int[] energy = new int[n];
        for (int i = 0; i < n; i++) {
            energy[i] = input.nextInt();
        }
        if (n == 1 || n == 2) {
            System.out.println(1);
            return;
        }
        List<Integer> smaller = idk.countSmaller(energy, true);
        //araye ro barax kon
        for (int i = 0; i < n / 2; i++) {
            int temp = energy[i];
            energy[i] = energy[n - 1 - i];
            energy[n - 1 - i] = temp;
        }
        List<Integer> g = idk.countSmaller(energy, false);
        int[] greater = new int[n];
        for (int i = 0; i < n; i++) {
            greater[i] = g.get(i);
        }
        for (int i = 0; i < n; i++) {
            greater[i] = n - 1 - i - greater[i];
        }
        for (int i = 0; i < n / 2; i++) {
            int temp = greater[i];
            greater[i] = greater[n - i - 1];
            greater[n - i - 1] = temp;
        }
        long result = 0;
//        for (int i = 0; i < n; i++) {
//            System.out.print(smaller.get(i) + " ");
//        }
//        System.out.println();
//        System.out.println(Arrays.toString(greater));
        for (int i = 0; i < n; i++) {
            result += greater[i] * smaller.get(i);
        }
        System.out.println(result);
    }
}