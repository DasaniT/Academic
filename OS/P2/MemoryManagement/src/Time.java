import java.util.ArrayList;
/*
* each time object has terminated array list as its attribute
* terminated = id of processes that terminate on this time
* */
class Time {
    private ArrayList<Integer> terminated = new ArrayList<>();//process ids that terminate on this time

    //add process id to terminated array list
    void add(int i) {
        terminated.add(i);
    }

    //returns true if terminated array list is empty
    boolean isEmpty() {
        return terminated.isEmpty();
    }

    //returns terminated array list size
    int size() {
        return terminated.size();
    }

    //returns j-th element of terminated array list
    int get(int j) {
        return terminated.get(j);
    }
}
