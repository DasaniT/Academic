import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/*
* Memory Manager class
* memory, policy, parameter, input queue,and map as its attributes
* and plenty of functions
* */

class MM {
    private Memory memory;
    private int policy;//Management policy
    /*
    * //parameter of policy, if policy is PAG then parameter is page size and
    * if it's SEG or VSP then parameter is best-fit, worst-fit or first-fit*/
    private int parameter;
    private InputQueue inputQueue;//contains processes that are ready to execute
    private Map<Integer, Integer> map;//key is process id and value is the base address of memory for that process

    /*
    * MM constructor
    * gets memory, policy and parameter as its input and set the attributes of object to them
    * creates empty input queue and hash map
    * */
    MM(Memory memory, int policy, int parameter) {
        this.memory = memory;
        this.policy = policy;
        this.parameter = parameter;
        inputQueue = new InputQueue();
        map = new HashMap<>();//key = process id, value =  base
    }

    /*
    * handles new processes
    * add the new process to input queue
    * this method will be called by Main.java class whenever new process has arrived
    * */
    void newProcess(Process process) {
        inputQueue.add(process);
    }

    /*
    * from the first process in input queue to the last one
    * checks if the process can be moved to memory
    * returns an integer array list that contains id of processes that were in the input queue and now are in the memory
    * calls the proper method based on policy and parameter
    * */
    ArrayList<Integer> checkInputQueue() {
        ArrayList<Integer> result = new ArrayList<>();//process ids
        for (int i = 0; i < inputQueue.size(); i++) {
            int id = inputQueue.get(i).getId();
            if (policy == 1) {

                if (parameter == 1) {
                    if (firstFit(inputQueue.get(i))) {
                        i--;
                        printMemoryMap();
                        result.add(id);
                    }
                }
                if (parameter == 2) {
                    if (bestFit(inputQueue.get(i))) {
                        i--;
                        printMemoryMap();
                        result.add(id);
                    }
                }
                if (parameter == 3) {
                    if (worstFit(inputQueue.get(i))) {
                        i--;
                        printMemoryMap();
                        result.add(id);
                    }
                }
            } else if (policy == 2) {//paging
                if (findFrames(inputQueue.get(i))) {
                    i--;
                    printMemoryMap();
                    result.add(id);
                }

            } else {//policy = 3, segmentation
                if (parameter == 1) {
                    if (findSegments(inputQueue.get(i))) {
                        i--;
                        printMemoryMap();
                        result.add(id);
                    }
                }
                if (parameter == 2) {
                    if (findBestSegments(inputQueue.get(i))) {
                        i--;
                        printMemoryMap();
                        result.add(id);
                    }
                }
                if (parameter == 3) {
                    if (findWorstSegments(inputQueue.get(i))) {
                        i--;
                        printMemoryMap();
                        result.add(id);
                    }
                }

            }

        }
        return result;
    }

    /*
    * policy = VSP, parameter = first fit
    * returns true if the amount of memory that its needed for this process is available
    * and change the elements of memory from base to (base+process size) to process id
    * o.w. returns false
    * */
    private boolean firstFit(Process process) {
        if (policy == 1) {//contiguous
            int processSize = processSize(process);
            int base = findContiguousMemory(processSize);
            if (base != -1) {
                for (int i = 0; i < processSize; i++) {
                    memory.mem[base + i] = process.getId();
                }
                System.out.println("          " + "MM moves Process " + process.getId() + " to memory");
                inputQueue.remove(process);
                map.put(process.getId(), base);
                return true;
            }
        }
        return false;
    }

    /*
    * gets process size as its input
    * find the first contiguous memory that is bigger or equal to process size
    * and return the base address
    * returns -1 if find Contiguous Memory method couldn't find the amount of memory needed
    * */
    private int findContiguousMemory(int processSize) {
        int counter = 0;
        if (processSize <= memory.size) {
            for (int i = 0; i < memory.size; i++) {
                int j = i;
                while (j < memory.size && memory.mem[j] == -1) {
                    counter++;
                    j++;
                    if (counter == processSize) {
                        return i;
                    }
                }
                counter = 0;
            }
        }
        return -1;
    }

    /*
    * policy = VSP, parameter = best fit
    * like firstFit method, but uses findBestHole method instead of findContiguousMemory
    * */
    private boolean bestFit(Process process) {
        if (policy == 1) {//contiguous allocation
            int processSize = processSize(process);
            int base = findBestHole(processSize);
            if (base != -1) {
                for (int i = 0; i < processSize; i++) {
                    memory.mem[base + i] = process.getId();
                }
                System.out.println("          " + "MM moves Process " + process.getId() + " to memory");
                inputQueue.remove(process);
                map.put(process.getId(), base);
                return true;
            }

        }
        return false;
    }

    /*
    * find the smallest hole available in memory that is bigger than process size and
    * returns the address of first element which is found and
    * returns -1 if couldn't find anything
    * */
    private int findBestHole(int processSize) {
        int base = -1;
        int bestSize = Integer.MAX_VALUE;
        for (int i = 0; i < memory.size; i++) {
            int currentSize = 0;
            int j = i;
            while (j < memory.size && memory.mem[j] == -1) {
                j++;
                currentSize++;
            }

            if (currentSize < bestSize && currentSize >= processSize) {
                base = i;
                bestSize = currentSize;
            }
            if (j != i) {
                i = j - 1;
            }

        }
        return base;
    }

    /*
    * policy = VSP, parameter = worst fit
    * like firstFit method, uses findWorstHole instead of findContiguousMemory
    * */
    private boolean worstFit(Process process) {
        if (policy == 1) {//contiguous allocation
            int processSize = processSize(process);
            int base = findWorstHole(processSize);
            if (base != -1) {
                for (int i = 0; i < processSize; i++) {
                    memory.mem[base + i] = process.getId();
                }
                System.out.println("          " + "MM moves Process " + process.getId() + " to memory");
                inputQueue.remove(process);
                map.put(process.getId(), base);
                return true;
            }

        }
        return false;
    }

    /*
    * find the biggest hole available in memory thet s bigger than process size
    * returns the address of first element which is found
    * returns -1 if couldn't find anything
    * */
    private int findWorstHole(int processSize) {
        int base = -1;
        int worstSize = Integer.MIN_VALUE;
        for (int i = 0; i < memory.size; i++) {
            int currentSize = 0;
            int j = i;
            while (j < memory.size && memory.mem[j] == -1) {
                j++;
                currentSize++;
            }

            if (currentSize > worstSize && currentSize >= processSize) {
                base = i;
                worstSize = currentSize;
            }
            if (j != i) {
                i = j - 1;
            }

        }
        return base;
    }

    /*
    * policy = PAG, parameter is page size
    * returns true if the number of frames that is needed for the process is found
    * returns false if the number of frames that is needed are not available at the moment
    * calls findFreeFrames method
    * */
    private boolean findFrames(Process process) {
        int processSize = processSize(process);
        int numOfPages = (int) Math.ceil((double) processSize / (double) parameter);//parameter = page size
        ArrayList<Integer> frames = findFreeFrames(numOfPages);
        if (!frames.isEmpty()) {//MM finds proper pages
            for (int i = 0; i < frames.size(); i++) {
                int base = frames.get(i) * parameter;
                for (int j = 0; j < parameter; j++) {
                    memory.mem[base + j] = process.getId();
                }
            }
            System.out.println("          " + "MM moves Process " + process.getId() + " to memory");
            inputQueue.remove(process);
//            map.put(process.getId(), base);
            return true;
        }
        return false;
    }

    /*
    * return array list that contains free frame numbers for example if memory has six frames
    * and frames 1, 2, 3 are free then the array list would have integers 1, 2, 3 as its elements
    * numOfPages = number of pages of the process
    * clears the array list and returns an empty array list if number of free frames is less than numOfPages
    * */
    private ArrayList<Integer> findFreeFrames(int numOfPages) {
        //numOfPages needed for process
        ArrayList<Integer> result = new ArrayList<>();
        int numOfFrames = memory.size / parameter;
        for (int i = 0; i < numOfFrames; i++) {
            if (memory.mem[(i) * parameter] == -1) {//which means frame is empty
                result.add(i);//number of page
            }
            if (result.size() == numOfPages) {
                break;
            }
        }
        if (result.size() != numOfPages) {
            result.clear();
        }
        return result;
    }

    /*
    * policy = SEG, parameter = first-fit
    * like firstFit method, uses findFreeSegments and findContiguousMemoryV2 instead of findContiguousMemory method
    * calls findFreeSegment method
    * */
    private boolean findSegments(Process process) {
        int[] segments = process.getSegments();
        ArrayList<Integer> baseSegments = findFreeSegments(segments);
        if (!baseSegments.isEmpty()) {//yani peyda shode
            for (int i = 0; i < baseSegments.size(); i++) {
                for (int j = 0; j < segments[i]; j++) {
                    memory.mem[baseSegments.get(i) + j] = Integer.parseInt(process.getId() + "123" + i);
                }

            }
            System.out.println("          " + "MM moves Process " + process.getId() + " to memory");
            inputQueue.remove(process);
//            map.put(process.getId(), base);
            return true;
        }

        return false;
    }

    /*
    * returns array list containing the base address for each segment of the process
    * calls findContiguousMemoryV2 method
    * */
    private ArrayList<Integer> findFreeSegments(int[] segments) {
        ArrayList<Integer> result = new ArrayList<>();
        int[] temp = new int[memory.size];
        for (int i = 0; i < memory.size; i++) {
            temp[i] = memory.mem[i];
        }
        for (int i = 0; i < segments.length; i++) {
            int base = findContiguousMemoryV2(segments[i], temp);
            if (base == -1) {
                result.clear();
                return result;
            }
            result.add(base);
            for (int j = 0; j < segments[i]; j++) {
                temp[base + j] = 1000;
            }
        }
        return result;
    }

    /*
    * like findContiguousMemory
    * also gets tMemory[] as input
    * tMemory[] = copy of memory, first make the changes on this fake memory and if for each segment of the process
    * memory was available then changes the main memory(in findFreeSegments method)
    * int segment = segment size
    * */
    private int findContiguousMemoryV2(int segment, int[] tMemory) {

        int counter = 0;
        if (segment <= tMemory.length) {
            for (int i = 0; i < tMemory.length; i++) {
                int j = i;
                while (j < tMemory.length && tMemory[j] == -1) {
                    counter++;
                    j++;
                    if (counter == segment) {
                        return i;
                    }
                }
                counter = 0;
            }
        }
        return -1;
    }

    /*
    * policy = SEG, parameter = best-fit
    * like bestFit method, uses findBestSegments and findBestFreeSegments instead of findBestHole method
    * calls findBestFreeSegments method
    * */
    private boolean findBestSegments(Process process) {
        int[] segments = process.getSegments();
        ArrayList<Integer> baseSegments = findBestFreeSegments(segments);
        if (!baseSegments.isEmpty()) {//yani peyda shode
            for (int i = 0; i < baseSegments.size(); i++) {
                for (int j = 0; j < segments[i]; j++) {
                    memory.mem[baseSegments.get(i) + j] = Integer.parseInt(process.getId() + "123" + i);
                }

            }
            System.out.println("          " + "MM moves Process " + process.getId() + " to memory");
            inputQueue.remove(process);
//            map.put(process.getId(), base);
            return true;
        }

        return false;
    }

    /*
    * returns array list containing the base address for each segment of the process
    * calls findBestHoleV2
    * */
    private ArrayList<Integer> findBestFreeSegments(int[] segments) {
        ArrayList<Integer> result = new ArrayList<>();
        int[] temp = new int[memory.size];
        for (int i = 0; i < memory.size; i++) {
            temp[i] = memory.mem[i];
        }
        for (int i = 0; i < segments.length; i++) {
            int base = findBestHoleV2(segments[i], temp);
            if (base == -1) {
                result.clear();
                return result;
            }
            result.add(base);
            for (int j = 0; j < segments[i]; j++) {
                temp[base + j] = 1000;
            }
        }
        return result;
    }

    /*
    * like findContiguousMemoryV2 method
    * find the smallest hole that is bigger that segment size
    * int segment = segment size
    * */
    private int findBestHoleV2(int segment, int[] temp) {
        int base = -1;
        int bestSize = Integer.MAX_VALUE;
        for (int i = 0; i < temp.length; i++) {
            int currentSize = 0;
            int j = i;
            while (j < temp.length && temp[j] == -1) {
                j++;
                currentSize++;
            }

            if (currentSize < bestSize && currentSize >= segment) {
                base = i;
                bestSize = currentSize;
            }
            if (j != i) {
                i = j - 1;
            }

        }
        return base;
    }

    /*
    * policy = SEG, parameter = worst-fit
    * like worstFit method, uses findWorstSegments and findWorstFreeSegments instead of findWorstHole method
    * calls findWorstSegments method
    * */
    private boolean findWorstSegments(Process process) {
        int[] segments = process.getSegments();
        ArrayList<Integer> baseSegments = findWorstFreeSegments(segments);
        if (!baseSegments.isEmpty()) {//yani peyda shode
            for (int i = 0; i < baseSegments.size(); i++) {
                for (int j = 0; j < segments[i]; j++) {
                    memory.mem[baseSegments.get(i) + j] = Integer.parseInt(process.getId() + "123" + i);
                }

            }
            System.out.println("          " + "MM moves Process " + process.getId() + " to memory");
            inputQueue.remove(process);
//            map.put(process.getId(), base);
            return true;
        }

        return false;
    }

    /*
    * returns array list containing the base address for each segment of the process
    * calls findWorstFreeSegments method
    * */
    private ArrayList<Integer> findWorstFreeSegments(int[] segments) {
        ArrayList<Integer> result = new ArrayList<>();
        int[] temp = new int[memory.size];
        for (int i = 0; i < memory.size; i++) {
            temp[i] = memory.mem[i];
        }
        for (int i = 0; i < segments.length; i++) {
            int base = findWorstHoleV2(segments[i], temp);
            if (base == -1) {
                result.clear();
                return result;
            }
            result.add(base);
            for (int j = 0; j < segments[i]; j++) {
                temp[base + j] = 1000;
            }
        }
        return result;
    }

    /*
    * like findContiguousMemoryV2 mehtod
    * find the biggest hole that is bigger that segment size
    * int segment = segment size
    * */
    private int findWorstHoleV2(int segment, int[] temp) {
        int base = -1;
        int worstSize = Integer.MIN_VALUE;
        for (int i = 0; i < temp.length; i++) {
            int currentSize = 0;
            int j = i;
            while (j < temp.length && temp[j] == -1) {
                j++;
                currentSize++;
            }

            if (currentSize > worstSize && currentSize >= segment) {
                base = i;
                worstSize = currentSize;
            }
            if (j != i) {
                i = j - 1;
            }

        }
        return base;
    }

    /*
    * prints out memory map
    * */
    private void printMemoryMap() {
        System.out.println("          Memory Map: ");
        if (policy == 1) {
            for (int i = 0; i < memory.mem.length; i++) {
                int first = i;
                int last = i;
                while (last < memory.mem.length && memory.mem[first] == memory.mem[last]) {
                    last++;
                }
                last--;
                if (memory.mem[last] == -1) {
                    System.out.println("               " + first + "-" + last + ": " + "Hole");
                } else {
                    System.out.println("               " + first + "-" + last + ": Process " + memory.mem[last]);
                }
                i = last;

            }
        } else if (policy == 2) {
            int numOfFrames = memory.size / parameter;
            int[] p = new int[25];
            for (int i = 0; i < 25; i++) {
                p[i] = 1;
            }
            for (int i = 0; i < numOfFrames; i++) {
                int first = i;
                int last = i;
                while (last * parameter < memory.mem.length && memory.mem[first * parameter] == memory.mem[last * parameter] && memory.mem[first * parameter] == -1) {
                    last++;
                }
                last--;
                if (last != first - 1) {
                    System.out.println("               " + first * parameter + "-" + (last * parameter + parameter - 1) + ": Free Frame(s)");
                    i = last;
                } else {
                    System.out.println("               " + i * parameter + "-" + (i * parameter + parameter - 1) + ": Process"
                            + memory.mem[i * parameter] + ", Page " + p[memory.mem[i * parameter]]);
                    p[memory.mem[i * parameter]]++;
                }
            }
        } else {//policy = 3, Segmentation
            for (int i = 0; i < memory.size; i++) {
                int first = i;
                int last = i;
                while (last < memory.mem.length && memory.mem[first] == memory.mem[last]) {
                    last++;
                }
                last--;
                if (memory.mem[last] == -1) {
                    System.out.println("               " + first + "-" + last + ": " + "Hole");
                } else {
                    String temp = memory.mem[first] + "";
                    int pid = Integer.parseInt(temp.split("123")[0]);
                    int segment = Integer.parseInt(temp.split("123")[1]);
                    System.out.println("               " + first + "-" + last + ": Process " + pid +
                            ", Segment " + segment);
                }
                i = last;
            }
        }

    }

    /*
    * calls removeFromMemory method
    * print a message containing the process id, show to user that which is process is comlpleted
    * */
    void processCompletes(Process process) {
        removeFromMemory(process);
        System.out.println("          " + "Process " + process.getId() + " completes");
        printMemoryMap();
    }

    /*
    * changes the elements of memory array that are equal to process id to -1
    * */
    private void removeFromMemory(Process process) {
        if (policy == 3) {
            String temp = process.getId() + "123";
            ArrayList<Integer> possible = new ArrayList<>();
            for (int i = 0; i < process.getSegments().length; i++) {
                possible.add(Integer.parseInt(temp + "" + i));
            }
            for (int i = 0; i < memory.size; i++) {
                if (possible.contains(memory.mem[i])) {
                    memory.mem[i] = -1;
                }
            }
        } else {
            int id = process.getId();
            for (int i = 0; i < memory.size; i++) {
                if (memory.mem[i] == id) {
                    memory.mem[i] = -1;
                }
            }
        }

    }

    /*
    * adds up size of segments of process and return the process size
    * */
    private int processSize(Process process) {
        int processSize = 0;
        for (int i = 0; i < process.getSegments().length; i++) {
            processSize += process.getSegments()[i];
        }
        return processSize;
    }
}
