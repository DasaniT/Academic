import java.util.ArrayList;

/*
* InputQueue class that has a array list queue as its attribute
* */

class InputQueue {
    //input queue
    ArrayList<Process> queue;

    //input queue constructor
    InputQueue() {
        queue = new ArrayList<>();
    }

    //add process to input queue and calls printQueue() method
    void add(Process process) {
        queue.add(process);
        printQueue();
    }

    //remove process from input queue and calls printQueue() method
    void remove(Process process) {
        queue.remove(process);
        printQueue();

    }

    //returns number of processes that currently are in input queue
    int size() {
        return queue.size();
    }

    //returns the i-th element of input queue
    Process get(int i) {
        return queue.get(i);
    }

    //prints the [ id of processes that are in the input queue ]
    private void printQueue() {
        System.out.print("          Input Queue: [");
        for (int i = 0; i < queue.size(); i++) {
            if (i == queue.size() - 1) {
                System.out.print(queue.get(i).getId());
            } else {
                System.out.print(queue.get(i).getId() + " ");
            }
        }
        System.out.print("]\n");
    }
}
