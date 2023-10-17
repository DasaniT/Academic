/*
* Memory class that contains size and mem[] as its attributes
* mem[] = main memory array
* size = size of the memory
* */

class Memory {

    int size;
    int[] mem;

    /*
    * Memory constructor
    * take size as its input
    * set the size attribute to this size
    * initialized an array with size of int size and elements to -1
    * -1 means empty
    * if element is != -1 the number represent id of the process occupying that element of memory
    * */
    Memory(int size) {
        this.size = size;
        mem = new int[size];
        for (int i = 0; i < size; i++) {
            mem[i] = -1;
        }
    }
}
