import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Scanner;

public class SlidingWindow {
    static int w;
    static boolean firstTime = true;
    static LinkedList<Integer> list;

    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        String t = input.nextLine();
        int n = Integer.parseInt(t.split(" ")[0]);
        w = Integer.parseInt(t.split(" ")[1]);
        String string = input.nextLine();
        Map<Character, LinkedList<Integer>> map = new HashMap<>();
        int length = -1;
//        int j_x = -1;
        LinkedList<Integer> indexs = null;
        int first = -1;
        boolean flag = false;
        boolean[] alreadyDeleted = new boolean[n];
        int[] add = {-1, -1};
        int[] remove = {-1, -1};
        boolean decreaseI = false;
        int last = -1;
        int[] check = null;
        for (int i = 0; i < n; i++) {
            if (i - w > 0 && !alreadyDeleted[i]) {
                if (!flag && remove[0] == -1) {
                    map.get(string.charAt(i - w - 1)).removeFirst();
                    if (map.get(string.charAt(i - w - 1)).size() == 0) {
                        map.put(string.charAt(i - w - 1), null);
                    }
                    alreadyDeleted[i - w - 1] = true;
                } else if (!flag && remove[0] != -1) {
                    for (int j = remove[0]; j <= remove[1]; j++) {
                        if (!alreadyDeleted[j]) {
                            map.get(string.charAt(j)).removeFirst();
                            if (map.get(string.charAt(j)).size() == 0) {
                                map.put(string.charAt(j), null);
                            }
                        }
                        alreadyDeleted[j] = true;
                    }
                    remove[0] = -1;
                    remove[1] = -1;
                } else if (flag) {
                    if (remove[0] == -1) {
                        remove[0] = i - w - 1;
                        remove[1] = i - w - 1;

                    } else {
                        remove[1]++;
                    }
                }

            }
            if (!flag) {
                if (map.get(string.charAt(i)) == null) {
                    System.out.print("[0,0]" + string.charAt(i));
                } else {
                    flag = true;
                    firstTime = true;
                    first = i;
                    last = i;
                    length = 1;
                    indexs = map.get(string.charAt(i));
                    add[0] = i;
                    add[1] = i;
                    int j_x = last - w > 0 ? indexs.getFirst() - last + w : indexs.getFirst();
                    if (i == n - 1) {
                        System.out.print("[" + j_x + "," + 1 + "]");
                        break;
                    }
                }
            } else {
                check = null;
                if (i == n - 1 && !flag) {
                    check = new int[]{-1, length};
                } else {
                    check = checkNextCharacter(string, i, indexs, length, first);

                }
                if (check[0] == -1) {
                    int j_x = last - w > 0 ? check[1] - last + w : check[1];
                    System.out.print("[" + j_x + "," + length + "]");
                    indexs = null;
                    flag = false;
                    decreaseI = true;
                    first = -1;
                    length = -1;
                } else {
                    length++;
                    last++;
                    add[1]++;
                }
            }
            if (!flag && add[0] == -1) {
                if (map.get(string.charAt(i)) == null) {
                    LinkedList<Integer> temp = new LinkedList<>();
                    temp.add(i);
                    map.put(string.charAt(i), temp);
                } else {
                    map.get(string.charAt(i)).addLast(i);
                }
            } else if (!flag && add[0] != -1) {
                for (int j = add[0]; j <= add[1]; j++) {
                    if (map.get(string.charAt(j)) == null) {
                        LinkedList<Integer> temp = new LinkedList<>();
                        temp.add(j);
                        map.put(string.charAt(j), temp);
                    } else {
                        map.get(string.charAt(j)).addLast(j);
                    }
                }
                add[0] = -1;
                add[1] = -1;
            }

            if (decreaseI) {
                i--;
                decreaseI = false;
            }
        }
        if (check != null && check[0] != -1) {
            int j_x = last - w > 0 ? list.getLast() - last + w : list.getLast();
            System.out.print("[" + j_x + "," + length + "]");
        }

    }

    private static int[] checkNextCharacter(String string, int index, LinkedList<Integer> temp, int length, int first) {
        if (firstTime) {
            list = new LinkedList<>();
            for (int i = temp.size() - 1; i >= 0; i--) {
                list.addLast(temp.get(i));
            }
            firstTime = false;
        }
        int j_x = -1;
        boolean alreadyIncreased = false;
        int thisLength = length;
        for (int i = 0; i < list.size(); i++) {
            if (list.size() == 1) {
                j_x = list.getFirst();
            }
            int j = list.get(i);
            if (j + thisLength >= first || first + thisLength - w > j) {
                list.remove(i);
                i--;
            } else if (string.charAt(index) != string.charAt(j + thisLength)) {
                list.remove(i);
                i--;
            } else {
                if (!alreadyIncreased) {
                    length++;
                    alreadyIncreased = true;
                }
            }
        }
        return list.size() == 0 ? new int[]{-1, j_x} : new int[]{length};
    }
}
