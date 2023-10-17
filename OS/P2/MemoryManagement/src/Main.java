import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {


    public static void main(String[] args) throws IOException {
        int counter = 0;

        Scanner input = new Scanner(System.in);
        System.out.println("memory size > ");
        int memorySize = Integer.parseInt(input.nextLine());
        Memory memory = new Memory(memorySize);
        MM memoryManager;
        System.out.println("memory management policy (1 VSP, 2 PAG, 3 SEG) > ");
        int policy = Integer.parseInt(input.nextLine());
        int pageSize = 0;
        int fitAlgorithm = -1;
        if (policy == 1) {
            System.out.println("Fit algorithm (1 first-fit, 2 best-fit, 3 worst-fit) > ");
            fitAlgorithm = Integer.parseInt(input.nextLine());
            memoryManager = new MM(memory, 1, fitAlgorithm);
        } else if (policy == 2) {
            System.out.println("page size > ");
            pageSize = Integer.parseInt(input.nextLine());
            memoryManager = new MM(memory, 2, pageSize);
        } else {
            System.out.println("Fit algorithm (1 first-fit, 2 best-fit, 3 worst-fit) > ");
            fitAlgorithm = Integer.parseInt(input.nextLine());
            memoryManager = new MM(memory, 3, fitAlgorithm);
        }


        System.out.println("enter the file name > ");
        String fileName = "src/" + input.nextLine();
        File workload = new File(fileName);

        TextReader reader = new TextReader(workload);

        ArrayList<Process> processes = reader.getProcesses();

        Time[] time = new Time[100000];
        for (int i = 0; i < 100000; i++) {
            time[i] = new Time();
        }
        ArrayList<Integer> turnaround = new ArrayList<>();


        for (int i = 0; i < time.length; i++) {
            boolean flag = false;

            if (!time[i].isEmpty()) {//there is at least one process that finishes its work on this time
                System.out.println("t = " + i + ":");
                for (int j = 0; j < time[i].size(); j++) {
                    memoryManager.processCompletes(processes.get(time[i].get(j) - 1));
                    turnaround.add(i - processes.get(time[i].get(j) - 1).getArrivalTime());
                }
                flag = true;
            }

            if (counter < processes.size() && processes.get(counter).getArrivalTime() == i) {
                System.out.println("t = " + i + ":");
                while (counter < processes.size() && processes.get(counter).getArrivalTime() == i) {
                    System.out.println("          " + "Process " + processes.get(counter).getId() + " arrives ");
                    memoryManager.newProcess(processes.get(counter));
                    counter++;
                    flag = true;
                }
            }

            if (flag) {
                ArrayList<Integer> test = memoryManager.checkInputQueue();
                if (!test.isEmpty()) {
                    for (int j = 0; j < test.size(); j++) {
                        time[processes.get(test.get(j) - 1).getLifeTime() + i].add(test.get(j));
                    }
                }
            }

        }

        System.out.println("Average Turnaround Time : " + mean(turnaround));


    }

    private static double mean(ArrayList<Integer> turnaround) {
        double m = 0.0;
        for (int i = 0; i < turnaround.size(); i++) {
            m += (double) turnaround.get(i);
        }
        return m / turnaround.size();
    }
}
