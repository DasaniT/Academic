import java.util.Scanner;

public class IDK3 {
    public static void main(String[] args) {
        LLRB tree = new LLRB();
        Scanner in = new Scanner(System.in);
        String input = "a";
        while (in.hasNextLine()) {
            input = in.nextLine();
            if (input.length() == 0) {
                break;
            }
            if (input.split(" ").length == 2) {//insert or delete
                if (input.split(" ")[0].equals("insert")) {
                    if (!tree.contains(Integer.parseInt(input.split(" ")[1]))) {
                        tree.insert(Integer.parseInt(input.split(" ")[1]));
                    }
                } else {
                    if (tree.contains(Integer.parseInt(input.split(" ")[1]))) {
                        tree.delete(Integer.parseInt(input.split(" ")[1]));
                    }

                }
            } else {//print
                if (input.split("_")[1].equals("preorder")) {
                    if (tree.printpreorder(tree.root)) {
                        System.out.println();
                    }
                } else if (input.split("_")[1].equals("inorder")) {
                    if (tree.printinorder(tree.root)) {
                        System.out.println();
                    }
                } else {
                    if (tree.printpostorder(tree.root)) {
                        System.out.println();
                    }
                }
            }

        }
    }
}

class LLRB {
    Node root;

    private class Node {
        int key;
        Node left, right;
        boolean color;
        int size;

        public Node(int key, boolean color, int size) {
            this.key = key;
            this.color = color;
            this.size = size;
        }
    }

    public LLRB() {
    }

    private boolean isRed(Node x) {
        if (x == null) return false;
        return x.color;
    }

    private int size(Node x) {
        if (x == null) return 0;
        return x.size;
    }

    public int size() {
        return size(root);
    }

    public boolean isEmpty() {
        return root == null;
    }

    public Node get(int key) {
        return get(root, key);
    }

    private Node get(Node x, int key) {
        while (x != null) {
            if (key < x.key) {
                x = x.left;
            } else if (key > x.key) {
                x = x.right;
            } else {
                return x;
            }
        }
        return null;
    }

    public boolean contains(int key) {
        return get(key) != null;
    }

    public void insert(int key) {
        root = insert(root, key);
        root.color = false;
    }

    private Node insert(Node h, int key) {
        if (h == null) return new Node(key, true, 1);
        if (key < h.key) {
            h.left = insert(h.left, key);
        } else if (key > h.key) {
            h.right = insert(h.right, key);
        }

        // fix-up any right-leaning links
        if (isRed(h.right) && !isRed(h.left)) h = rotateLeft(h);
        if (isRed(h.left) && isRed(h.left.left)) h = rotateRight(h);
        if (isRed(h.left) && isRed(h.right)) flipColors(h);
        h.size = size(h.left) + size(h.right) + 1;

        return h;
    }

    private Node rotateRight(Node h) {
        // assert (h != null) && isRed(h.left);
        Node x = h.left;
        h.left = x.right;
        x.right = h;
        x.color = x.right.color;
        x.right.color = true;
        x.size = h.size;
        h.size = size(h.left) + size(h.right) + 1;
        return x;
    }

    private Node rotateLeft(Node h) {
        // assert (h != null) && isRed(h.right);
        Node x = h.right;
        h.right = x.left;
        x.left = h;
        x.color = x.left.color;
        x.left.color = true;
        x.size = h.size;
        h.size = size(h.left) + size(h.right) + 1;
        return x;
    }

    private void flipColors(Node h) {
        // h must have opposite color of its two children
        // assert (h != null) && (h.left != null) && (h.right != null);
        // assert (!isRed(h) &&  isRed(h.left) &&  isRed(h.right))
        //    || (isRed(h)  && !isRed(h.left) && !isRed(h.right));
        h.color = !h.color;
        h.left.color = !h.left.color;
        h.right.color = !h.right.color;
    }

    public void deleteMin() {
        if (isEmpty()) return;

        if (!isRed(root.left) && !isRed(root.right))
            root.color = true;

        root = deleteMin(root);
        if (!isEmpty()) root.color = false;
    }

    private Node deleteMin(Node h) {
        if (h.left == null)
            return null;

        if (!isRed(h.left) && !isRed(h.left.left))
            h = moveRedLeft(h);

        h.left = deleteMin(h.left);
        return balance(h);
    }

    private Node moveRedLeft(Node h) {

        flipColors(h);
        if (isRed(h.right.left)) {
            h.right = rotateRight(h.right);
            h = rotateLeft(h);
            flipColors(h);
        }
        return h;
    }

    private Node moveRedRight(Node h) {
        flipColors(h);
        if (isRed(h.left.left)) {
            h = rotateRight(h);
            flipColors(h);
        }
        return h;
    }

    private Node balance(Node h) {

        if (isRed(h.right)) h = rotateLeft(h);
        if (isRed(h.left) && isRed(h.left.left)) h = rotateRight(h);
        if (isRed(h.left) && isRed(h.right)) flipColors(h);

        h.size = size(h.left) + size(h.right) + 1;
        return h;
    }

    public void delete(int key) {
        if (!contains(key)) return;

        if (!isRed(root.left) && !isRed(root.right))
            root.color = true;

        root = delete(root, key);
        if (!isEmpty()) root.color = false;
    }

    // delete the key-value pair with the given key rooted at h
    private Node delete(Node h, int key) {
        if (key < h.key) {
            if (!isRed(h.left) && !isRed(h.left.left))
                h = moveRedLeft(h);
            h.left = delete(h.left, key);
        } else {
            if (isRed(h.left))
                h = rotateRight(h);
            if ((key == h.key) && (h.right == null))
                return null;
            if (!isRed(h.right) && !isRed(h.right.left))
                h = moveRedRight(h);
            if (key == h.key) {
                Node x = min(h.right);
                h.key = x.key;
                h.right = deleteMin(h.right);
            } else h.right = delete(h.right, key);
        }
        return balance(h);
    }

    public int min() {
        if (isEmpty()) return -1;
        return min(root).key;
    }

    // the smallest key in subtree rooted at x; null if no such key
    private Node min(Node x) {
        // assert x != null;
        if (x.left == null) return x;
        else return min(x.left);
    }

    boolean printinorder(Node x) {
        if (x == null)
            return false;
        printinorder(x.left);
        if (isRed(x)) {
            System.out.print(x.key + "r ");
        } else {
            System.out.print(x.key + "b ");
        }
        printinorder(x.right);
        return true;
    }

    boolean printpreorder(Node x) {
        if (x == null)
            return false;
        if (isRed(x)) {
            System.out.print(x.key + "r ");
        } else {
            System.out.print(x.key + "b ");
        }
        printpreorder(x.left);
        printpreorder(x.right);
        return true;
    }

    boolean printpostorder(Node x) {
        if (x == null)
            return false;
        printpostorder(x.left);
        printpostorder(x.right);
        if (isRed(x)) {
            System.out.print(x.key + "r ");
        } else {
            System.out.print(x.key + "b ");
        }
        return true;
    }
}
