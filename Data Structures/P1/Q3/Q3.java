import java.util.Scanner;

/**
 * Created by Pixel on 12/15/2017.
 */
public class Q3 {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        int n = input.nextInt();
        int k = input.nextInt();
        Deque deque = new Deque();
        for (int i = 0; i < k; i++) {
            int price = input.nextInt();
            MyElement data = new MyElement(price,i);
            while (!deque.isEmpty() && price >= deque.peekLast().key)
                deque.removeLast();
            deque.addLast(data);
        }
        for (int i = k; i < n; i++) {
            System.out.print(deque.peekFirst().key + " ");
            int price = input.nextInt();
            MyElement data = new MyElement(price,i);
            while (!deque.isEmpty() && deque.peekFirst().position<= i-k)
                deque.removeFirst();
            while (!deque.isEmpty() && price >= deque.peekLast().key)
                deque.removeLast();
            deque.addLast(data);

        }
        System.out.print(deque.peekFirst().key);
    }
}

class Deque {
    LinkedList linkedList;

    public Deque() {
        linkedList = new LinkedList();
    }

    public void addFirst(MyElement a) {
        linkedList.addFirst(a);
    }

    public void addLast(MyElement a) {
        linkedList.addLast(a);
    }

    public void removeLast() {
        linkedList.removeLast();
    }

    public void removeFirst() {
        linkedList.removeFirst();
    }

    public MyElement peekFirst() {
        return linkedList.peekFirst();
    }

    public MyElement peekLast() {
        return linkedList.peekLast();
    }

    public boolean isEmpty() {
        return linkedList.isEmpty();
    }
}

class LinkedList {
    Node head;

    private static class Node {
        MyElement data;
        Node next;

        public Node() {
        }

        public Node(MyElement data, Node next) {
            this.data = data;
            this.next = next;
        }
    }

    public LinkedList() {
        head = new Node(new MyElement(-1,0), null);
    }

    public void addFirst(MyElement a) {
        Node node = new Node();
        node.data = a;
        node.next = head.next;
        head.next = node;
    }

    public void addLast(MyElement a) {
        if (head.next == null)
            addFirst(a);
        else {
            Node temp = head;
            while (temp.next != null) {
                temp = temp.next;
            }
            temp.next = new Node(a, null);
        }
    }

    public void removeFirst() {
        head.next = head.next.next;
    }

    public void removeLast() {
        Node temp = head;
        while (temp.next.next != null) {
            temp = temp.next;
        }
        temp.next = null;
    }

    public MyElement peekFirst() {
        return head.next.data;
    }

    public MyElement peekLast() {
        Node temp = head;
        while (temp.next != null) {
            temp = temp.next;
        }
        return temp.data;
    }

    public boolean isEmpty() {
        return head.next == null;
    }
}
class MyElement{
    int key;
    int position;

    public MyElement(int key, int position) {
        this.key = key;
        this.position = position;
    }
}