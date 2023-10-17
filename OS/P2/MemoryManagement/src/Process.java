/*
* process class that contains id, arrival time, life time, and segments of a process as attributes
* */
class Process {
    private int id;//unique process id
    private int arrivalTime;//time that process arrives
    private int lifeTime;//amount of time that process needs to complete its job
    private int segments[];//segments of a process

    /*
    * process constructor
    * gets id, arrival time, life time, segments[] as parameter and set attributes of object to these parameters
    * */
    Process(int id, int arrivalTime, int lifeTime, int[] segments) {
        this.id = id;
        this.arrivalTime = arrivalTime;
        this.lifeTime = lifeTime;
        this.segments = segments;
    }


    //returns id of the process
    int getId() {
        return id;
    }

    //returns arrival time of the process
    int getArrivalTime() {
        return arrivalTime;
    }

    //returns life time of the process
    int getLifeTime() {
        return lifeTime;
    }

    //return segments of the process
    int[] getSegments() {
        return segments;
    }
}
