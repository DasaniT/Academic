import java.text.DecimalFormat;
import java.util.Scanner;

public class IDK {
    public static void main(String[] args) {
        BinarySearchTree bst = new BinarySearchTree();
        Scanner input = new Scanner(System.in);
        int n = input.nextInt();
        int m = input.nextInt();
        Car[] cars = new Car[m];
        for (int i = 0; i < m; i++) {//ip = chandomin mashine ke add shode
            cars[i] = new Car(i, input.nextDouble(), input.nextDouble());
        }
        quickSort(cars, 0, m - 1);
        DoubleLinkedList linkedList = new DoubleLinkedList();
        linkedList.add(new Car(m, n, 0));

        for (int i = m - 1; i >= 0; i--) {
            linkedList.add(cars[i]);
        }
        linkedList.add(new Car(-1, -1, 0));
        LinkedListNode x = linkedList.head;
//        int j = 0;
        while (x.next.next != null) {
            x = x.next;
            double v_i = x.car.getV();
            double x_i = x.car.getX();
            double v_j = x.next.car.getV();
            double x_j = x.next.car.getX();
            double time = (x_j - x_i) / (v_i - v_j);
            if (time >= 0 && time != Double.POSITIVE_INFINITY) {
                bst.insert(new Data(time, x, x.next));
            }
        }
        while (true) {
            Node node = bst.minimum();
            LinkedListNode first = node.data.first;
            LinkedListNode second = node.data.second;
            boolean flag = false;
            if (node.data.first.active && node.data.second.active) {
                flag = true;
                if (node.data.first.car.getIp() != -1) {
                    cars[node.data.first.car.getIp()].time = node.data.time;
                    if (node.data.second.car.getIp() != m) {
                        cars[node.data.first.car.getIp()].vsIP = node.data.second.car.getIp();
                    } else {
                        cars[node.data.first.car.getIp()].vsIP = -1;
                    }
                    first = first.prev;
                    linkedList.delete(node.data.first);

                }
                if (node.data.second.car.getIp() != m) {
                    cars[node.data.second.car.getIp()].time = node.data.time;
                    if (node.data.first.car.getIp() != -1) {
                        cars[node.data.second.car.getIp()].vsIP = node.data.first.car.getIp();
                    } else {
                        cars[node.data.second.car.getIp()].vsIP = -1;
                    }
                    second = second.next;
                    linkedList.delete(node.data.second);
                }
            }

            bst.delete(node.data);

            if (flag) {
                if (first.car.getIp() != -1 || second.car.getIp() != m) {
                    double v_i = first.car.getV();
                    double x_i = first.car.getX();
                    double v_j = second.car.getV();
                    double x_j = second.car.getX();
                    double time = (x_j - x_i) / (v_i - v_j);
                    if (time >= 0 && time != Double.POSITIVE_INFINITY) {
                        bst.insert(new Data(time, first, second));
                    }
                }
            }
            if (bst.size == 0) {
                break;
            }
        }
        DecimalFormat df = new DecimalFormat("0.#####");
        for (int i = 0; i < m; i++) {
            System.out.println(df.format(cars[i].time) + " " + cars[i].vsIP);
        }
    }

    public static void quickSort(Car[] elements, int low, int high) {
        if (low < high) {
            int p = partition(elements, low, high);

            quickSort(elements, low, p - 1);
            quickSort(elements, p + 1, high);
        }
    }

    private static int partition(Car[] elements, int low, int high) {
        double pivot = elements[high].getX();
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (elements[j].getX() <= pivot) {
                i++;

                Car temp = elements[i];
                elements[i] = elements[j];
                elements[j] = temp;
            }
        }
        Car temp = elements[i + 1];
        elements[i + 1] = elements[high];
        elements[high] = temp;

        return i + 1;

    }
}

class BinarySearchTree {
    public static Node root;
    int size;

    public BinarySearchTree() {
        this.root = null;
        size = 0;
    }

    public boolean find(Data id) {
        Node current = root;
        while (current != null) {
            if (current.data.time == id.time) {
                return true;
            } else if (current.data.time > id.time) {
                current = current.left;
            } else {
                current = current.right;
            }
        }
        return false;
    }

    public boolean delete(Data id) {
        Node parent = root;
        Node current = root;
        boolean isLeftChild = false;
        while (current.data.time != id.time) {
            parent = current;
            if (current.data.time > id.time) {
                isLeftChild = true;
                current = current.left;
            } else {
                isLeftChild = false;
                current = current.right;
            }
            if (current == null) {
                return false;
            }
        }
        //if i am here that means we have found the node
        //Case 1: if node to be deleted has no children
        if (current.left == null && current.right == null) {
            if (current == root) {
                root = null;
            }
            if (isLeftChild == true) {
                parent.left = null;
            } else {
                parent.right = null;
            }
        }
        //Case 2 : if node to be deleted has only one child
        else if (current.right == null) {
            if (current == root) {
                root = current.left;
            } else if (isLeftChild) {
                parent.left = current.left;
            } else {
                parent.right = current.left;
            }
        } else if (current.left == null) {
            if (current == root) {
                root = current.right;
            } else if (isLeftChild) {
                parent.left = current.right;
            } else {
                parent.right = current.right;
            }
        } else if (current.left != null && current.right != null) {

            //now we have found the minimum element in the right sub tree
            Node successor = getSuccessor(current);
            if (current == root) {
                root = successor;
            } else if (isLeftChild) {
                parent.left = successor;
            } else {
                parent.right = successor;
            }
            successor.left = current.left;
        }
        size--;
        return true;
    }

    public Node getSuccessor(Node deleleNode) {
        Node successsor = null;
        Node successsorParent = null;
        Node current = deleleNode.right;
        while (current != null) {
            successsorParent = successsor;
            successsor = current;
            current = current.left;
        }
        //check if successor has the right child, it cannot have left child for sure
        // if it does have the right child, add it to the left of successorParent.
//		successsorParent
        if (successsor != deleleNode.right) {
            successsorParent.left = successsor.right;
            successsor.right = deleleNode.right;
        }
        return successsor;
    }

    public void insert(Data id) {
        size++;
        Node newNode = new Node(id);
        if (root == null) {
            root = newNode;
            return;
        }
        Node current = root;
        Node parent = null;
        while (true) {
            parent = current;
            if (id.time < current.data.time) {
                current = current.left;
                if (current == null) {
                    parent.left = newNode;
                    return;
                }
            } else {
                current = current.right;
                if (current == null) {
                    parent.right = newNode;
                    return;
                }
            }
        }
    }

    public void display(Node root) {
        if (root != null) {
            display(root.left);
            System.out.print(" " + root.data.time);
            display(root.right);
        }
    }

    Node minimum() {
        Node x = root;
        while (x.left != null) {
            x = x.left;
        }
        return x;
    }
}

class Node {
    Data data;
    Node left;
    Node right;

    public Node(Data data) {
//        data = new Data(number);
        this.data = data;
        left = null;
        right = null;
    }
}

class LinkedListNode {
    LinkedListNode next;
    LinkedListNode prev;
    Car car;
    boolean active;
//    Data a;
//    Data b;

    public LinkedListNode() {
        active = true;
//        a = null;
//        b = null;
    }
}

class Car {
    private double x;
    private double v;
    private int ip;
    int vsIP;
    double time;
//    double time;

    public Car(int ip, double x, double v) {
        this.ip = ip;
        this.x = x;
        this.v = v;
    }

    public Car() {
    }

    public double getX() {
        return x;
    }

    public double getV() {
        return v;
    }

    public void setX(int x) {
        this.x = x;
    }

    public void setV(int v) {
        this.v = v;
    }

    public int getIp() {
        return ip;
    }
}

class Data {
    double time;
    LinkedListNode first;//first car that crashes
    LinkedListNode second;//second car that crashes


    public Data() {
    }

    public Data(double time) {
        this.time = time;
    }

    public Data(double time, LinkedListNode first, LinkedListNode second) {
        this.time = time;
        this.first = first;
        this.second = second;
    }


}

class DoubleLinkedList {
    LinkedListNode head;
    int deleted;


    public DoubleLinkedList() {
        head = new LinkedListNode();
        head.next = null;
        head.prev = null;
        head.car = null;
    }

    void add(Car car) {
        LinkedListNode temp = new LinkedListNode();
        temp.car = car;
        temp.next = head.next;
        temp.prev = head;
        head.next = temp;
        if (temp.next != null) {
            temp.next.prev = temp;
        }
    }

    void delete(LinkedListNode x) {
        LinkedListNode next = x.next;
        LinkedListNode prev = x.prev;
        prev.next = next;
        next.prev = prev;
        x.active = false;
        deleted++;
    }

}