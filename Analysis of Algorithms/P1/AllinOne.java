import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;

public class AllinOne {
    static boolean[] marked;
    static int count = 0;
    int time = 0;
    static boolean connected = false;
    static ArrayList<String> edges = new ArrayList<>();
    static ArrayList<ArrayList<Integer>> colonies = new ArrayList<>();

    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        int n = input.nextInt();
        int k = input.nextInt();
        int[] cols = new int[k];
        int[][] A = new int[n][n];
        int[][] B = new int[n][n];
        marked = new boolean[n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int a = input.nextInt();
                A[i][j] = a;
                B[i][j] = a;
            }
        }
        for (int i = 0; i < k; i++) {
            cols[i] = input.nextInt();
        }
        Depth(A);
        if (count == 1) {
            System.out.println(1);
            connected = true;
        } else {
            System.out.println(0);
        }
        int max = Integer.MIN_VALUE;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int a = BFS(i, j, A);
                if (a > max) {
                    max = a;
                }
            }
        }
        System.out.println(max);
        if (connected) {
            int vertix = -1;
            int min = Integer.MAX_VALUE;
            for (int i = 0; i < n; i++) {
                int a = 0;
                for (int j = 0; j < n; j++) {
                    a += BFS(i, j, A);
                }
                if (a < min) {
                    min = a;
                    vertix = i;
                }
            }
            System.out.println(vertix + 1);
        } else {
            System.out.println(-1);
        }
        for (int p = 0; p < k; p++) {

            int q = cols[p];
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    B[i][j] = A[i][j];
                }
            }
            a:
            while (true) {
                count = 0;
                for (int i = 0; i < n; i++) {
                    marked[i] = false;
                }
                Depth(B);
                if (count == q) {
                    break;
                } else {
                    colonies.clear();
                    new AllinOne().bridge(B, n);
                    if (edges.size() != 0) {
                        for (int i = 0; i < edges.size(); i++) {
                            int a = Integer.parseInt(edges.get(i).split(",")[0]);
                            int b = Integer.parseInt(edges.get(i).split(",")[1]);
                            B[a][b] = 0;
                            B[b][a] = 0;
                            count = 0;
                            for (int j = 0; j < n; j++) {
                                marked[j] = false;
                            }
                            Depth(B);
                            if (count == q) {
                                break a;
                            }
                        }
                        edges.clear();
                    } else {
                        int i = minDegree(B);
                        for (int j = 0; j < n; j++) {
                            if (B[i][j] == 1) {
                                B[i][j] = 0;
                                B[j][i] = 0;
                                break;
                            }
                        }
                    }
                }
            }
            for (int i = 0; i < colonies.size(); i++) {
                for (int j = 0; j < colonies.get(i).size(); j++) {
                    System.out.print((colonies.get(i).get(j) + 1) + " ");
                }
                System.out.print(",");
            }
            colonies.clear();
            edges.clear();
            System.out.println();
        }

    }

    public static void Depth(int[][] A) {
        int n = A.length;
        for (int i = 0; i < n; i++) {
            if (!marked[i]) {
                count++;
                colonies.add(new ArrayList<>());
                dfs(A, i);
            }
        }
    }

    private static void dfs(int[][] A, int i) {
        marked[i] = true;
        colonies.get(count - 1).add(i);
//        System.out.println(i);
        for (int j = 0; j < A.length; j++) {
            if (A[i][j] == 1) {
                if (!marked[j]) {
                    dfs(A, j);
                }
            }
        }

    }

    static int BFS(int u, int v, int[][] A) {
        int n = A.length;
        boolean[] visited = new boolean[n];
        int[] distance = new int[n];
        Queue queue = new LinkedList();
        distance[u] = 0;
        queue.add(u);
        visited[u] = true;
        while (!queue.isEmpty()) {
            int x = (int) queue.peek();
            queue.remove();
            for (int i = 0; i < n; i++) {
                if (A[x][i] == 1) {
                    if (visited[i])
                        continue;
                    distance[i] = distance[x] + 1;
                    queue.add(i);
                    visited[i] = true;
                }
            }
        }
        return distance[v];
    }

    void bridge(int[][] A, int n) {
        boolean[] visited = new boolean[n];
        int disc[] = new int[n];
        int[] low = new int[n];
        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = -1;
            visited[i] = false;
        }

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                bridges(i, visited, disc, low, parent, A);
            }
        }
    }

    private void bridges(int u, boolean[] visited, int[] disc, int[] low, int[] parent, int[][] A) {
        int children = 0;
        visited[u] = true;

        disc[u] = low[u] = ++time;

        for (int i = 0; i < A.length; i++) {
            if (A[u][i] == 1) {
                if (!visited[i]) {
                    parent[i] = u;
                    bridges(i, visited, disc, low, parent, A);

                    low[u] = Math.min(low[u], low[i]);

                    if (low[i] > disc[u]) {
                        edges.add(u + "," + i);
                    }
                } else if (i != parent[u]) {
                    low[u] = Math.min(low[u], disc[i]);
                }
            }
        }
    }

    static int minDegree(int[][] A) {
        int counter = 0;
        int min = Integer.MAX_VALUE;
        int ret = -1;
        for (int i = 0; i < A.length; i++) {
            for (int j = 0; j < A.length; j++) {
                if (A[i][j] == 1) {
                    counter++;
                }
            }
            if (counter < min && counter != 0) {
                min = counter;
                ret = i;
            }
            counter = 0;
        }
        return ret;
    }
}
