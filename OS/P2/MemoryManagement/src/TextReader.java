import java.io.*;
import java.util.ArrayList;

/*
 * TextReader class
 * simply reads a file that is its attribute
 * */
class TextReader {
    private File text;

    //TextReader constructor, take as its input some file
    TextReader(File text) {
        this.text = text;
    }

    /*
    * read the file and returns an array list containing
    * of processes that were in the file
    * */
    ArrayList<Process> getProcesses() throws IOException {
        ArrayList<Process> processes = new ArrayList<>();
        BufferedReader br = new BufferedReader(new FileReader(text));

        int numOfProcesses = Integer.parseInt(br.readLine());

        for (int i = 0; i < numOfProcesses; i++) {
            if (i != 0) {
                br.readLine();
            }
            int id = Integer.parseInt(br.readLine());
            String temp = br.readLine();
            int arrivalTime = Integer.parseInt(temp.split(" ")[0]);
            int lifeTime = Integer.parseInt(temp.split(" ")[1]);
            temp = br.readLine();
            int numOfSegments = Integer.parseInt(temp.split(" ")[0]);
            int[] segments = new int[numOfSegments];
            for (int r = 0; r < numOfSegments; r++) {
                segments[r] = Integer.parseInt(temp.split(" ")[r + 1]);
            }
            processes.add(new Process(id, arrivalTime, lifeTime, segments));
        }
        return processes;
    }
}
