import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.Semaphore;

public class Scheduler {
    private static Semaphore semaphore = new Semaphore(1);//arrive semaphore, with permit = 1, which is similar to mutex lock
    //    private static Semaphore facilities = new Semaphore(3);
    private static Semaphore departSemaphore = new Semaphore(1);//depart semaphore, with permit = 1, which is similar to mutex lock
    final static Object lock1 = new Object();//for men, every time that a man is entering the queue he should acquire this key(to run the arrive method)
    final static Object lock2 = new Object();//for women, every time that a woman is entering the queue he should acquire this key(to run the arrive method)
    static int mInR = 0;//number of men in restroom
    static int wInR = 0;//number of women in restroom
    static ArrayList<Thread> male = new ArrayList<>();//male's queue
    static ArrayList<Thread> female = new ArrayList<>();//female's queue


    public static void main(String[] args) {
        ArrayList<OnePerson> threads = new ArrayList<>();
        Random r = new Random();
        /*
         * generating random number
         * creating thread
         * adding the thread to threads array list
         * adding the thread to appropriate queue
         * */
        for (int i = 0; i < 5; i++) {
            if (r.nextDouble() <= 0.6) {
                System.out.println("female");
                OnePerson temp = new OnePerson(i, 1, 5000);
                female.add(temp);
                threads.add(temp);
            } else {
                System.out.println("male");
                OnePerson temp = new OnePerson(i, 0, 5000);
                male.add(temp);
                threads.add(temp);
            }
        }
        //starting the threads that we generated
        for (int i = 0; i < threads.size(); i++) {
            threads.get(i).start();
        }
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
//        threads.clear();
        for (int i = 0; i < 5; i++) {
            if (r.nextDouble() <= 0.6) {
                System.out.println("female");
                OnePerson temp = new OnePerson(i + 5, 1, 5000);
                female.add(temp);
                threads.add(temp);
            } else {
                System.out.println("male");
                OnePerson temp = new OnePerson(i + 5, 0, 5000);
                male.add(temp);
                threads.add(temp);
            }
        }
        for (int i = 5; i < threads.size(); i++) {
            threads.get(i).start();
        }
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
//        threads.clear();
        for (int i = 0; i < 5; i++) {
            if (r.nextDouble() <= 0.6) {
                System.out.println("female");
                OnePerson temp = new OnePerson(i + 10, 1, 5000);
                female.add(temp);
                threads.add(temp);
            } else {
                System.out.println("male");
                OnePerson temp = new OnePerson(i + 10, 0, 5000);
                male.add(temp);
                threads.add(temp);
            }
        }
        for (int i = 10; i < threads.size(); i++) {
            threads.get(i).start();
        }
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
//        threads.clear();
        for (int i = 0; i < 5; i++) {
            if (r.nextDouble() <= 0.6) {
                System.out.println("female");
                OnePerson temp = new OnePerson(i + 15, 1, 5000);
                female.add(temp);
                threads.add(temp);
            } else {
                System.out.println("male");
                OnePerson temp = new OnePerson(i + 15, 0, 5000);
                male.add(temp);
                threads.add(temp);
            }
        }
        for (int i = 15; i < threads.size(); i++) {
            threads.get(i).start();
        }
        for (int i = 0; i < threads.size(); i++) {
            try {
                threads.get(i).join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("-------------------- end of schedule 1 ------------------------------");
        threads.clear();
        male.clear();
        female.clear();
        for (int i = 0; i < 10; i++) {
            if (r.nextDouble() <= 0.6) {
                System.out.println("female");
                OnePerson temp = new OnePerson(i, 1, 5000);
                female.add(temp);
                threads.add(temp);
            } else {
                System.out.println("male");
                OnePerson temp = new OnePerson(i, 0, 5000);
                male.add(temp);
                threads.add(temp);
            }
        }
        for (int i = 0; i < threads.size(); i++) {
            threads.get(i).start();
        }
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
//        threads.clear();
        for (int i = 0; i < 10; i++) {
            if (r.nextDouble() <= 0.6) {
                System.out.println("female");
                OnePerson temp = new OnePerson(i + 10, 1, 5000);
                female.add(temp);
                threads.add(temp);
            } else {
                System.out.println("male");
                OnePerson temp = new OnePerson(i + 10, 0, 5000);
                male.add(temp);
                threads.add(temp);
            }
        }
        for (int i = 10; i < threads.size(); i++) {
            threads.get(i).start();
        }
        for (int i = 0; i < threads.size(); i++) {
            try {
                threads.get(i).join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("-------------------- end of schedule 2 ------------------------------");
        threads.clear();
        male.clear();
        female.clear();
        for (int i = 0; i < 20; i++) {
            if (r.nextDouble() <= 0.6) {
                System.out.println("female");
                OnePerson temp = new OnePerson(i, 1, 5000);
                female.add(temp);
                threads.add(temp);
            } else {
                System.out.println("male");
                OnePerson temp = new OnePerson(i, 0, 5000);
                male.add(temp);
                threads.add(temp);
            }
        }
        for (int i = 0; i < threads.size(); i++) {
            threads.get(i).start();
        }
        for (int i = 0; i < threads.size(); i++) {
            try {
                threads.get(i).join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("-------------------- end of schedule 3 ------------------------------");


    }

    private static class OnePerson extends Thread {
        int id;
        int gender;// 0 = male, 1 = female
        int time;

        public OnePerson(int id, int gender, int time) {
            this.id = id;
            this.gender = gender;
            this.time = time;
        }

        @Override
        public void run() {
            if (gender == 0) {//if person is a male
                synchronized (lock1) {
                    try {
                        while (!arrive()) {//if he can't enter the restroom, then wait
                            lock1.wait();
                        }
                    } catch (InterruptedException e) {
                        System.err.println("Interrupted Exception");
                    }
                }
            } else {
                synchronized (lock2) {
                    try {
                        while (!arrive()) {//if she can't enter the restroom, then wait
                            lock2.wait();
                        }
                    } catch (InterruptedException e) {
                        System.err.println("Interrupted Exception");
                    }

                }
            }
            /*
              if he/she is gonna enter the restroom, then remove him/her from queue
            */
            if (male.contains(this)) {
                male.remove(this);
            } else if (female.contains(this)) {
                female.remove(this);
            }
            useFacilities();
        }

        /*
         * this method checks if he/she can enter the restroom :
         *   if he/she can ----> return true
         *   else ----> return false
         * */
        private boolean arrive() throws InterruptedException {
            semaphore.acquire();
            if (gender == 0) {//person is a male
                /*
                 * if no one is in the restroom then he can enter
                 * if only one man is in the restroom he can enter
                 * if two men are in the restroom and no woman is waiting then he can enter the restroom
                 * */
                if ((wInR == 0 && mInR == 0) || (wInR == 0 && mInR == 1) || (wInR == 0 && mInR == 2 && thereIsNoWomanWaiting())) {
                    if (male.contains(this)) {
                        male.remove(this);
                    }
                    mInR++;
                    semaphore.release();
                    return true;
                }
                /*
                 * if women are in the restroom, he should wait
                 * if 2 men are in the restroom and women are waiting to get into the restroom then he can't enter and should wait
                 * */
                if ((wInR != 0) || (wInR == 0 && mInR == 2 && !thereIsNoWomanWaiting())) {
                    System.out.println(id + " is waiting, male");
//                    male.add(this);
                    semaphore.release();
                    return false;
                }
            } else {//person is a female
                if ((mInR == 0 && wInR == 0) || (mInR == 0 && wInR == 1) || (mInR == 0 && wInR == 2 && thereIsNoManWaiting())) {
                    if (female.contains(this)) {
                        female.remove(this);
                    }
                    wInR++;
                    semaphore.release();
                    return true;
                }
                if ((mInR != 0) || (mInR == 0 && wInR == 2 && !thereIsNoManWaiting())) {
                    System.out.println(id + " is waiting, female");
//                    female.add(this);
                    semaphore.release();
                    return false;
                }
            }
            semaphore.release();
            return false;
        }

        private boolean thereIsNoManWaiting() {
            return male.size() == 0;
        }

        private boolean thereIsNoWomanWaiting() {
            return female.size() == 0;
        }

        private void useFacilities() {

            if (gender == 0) {
                System.out.println(id + " is using restroom. male");

            } else {
                System.out.println(id + " is using restroom. female");
            }

            System.out.println("men in restroom : " + mInR);
            System.out.println("women in restroom : " + wInR);
            try {
                sleep(5000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            try {
                departSemaphore.acquire();
                depart();
            } catch (InterruptedException e) {
                e.printStackTrace();
            } finally {
                departSemaphore.release();
            }


        }

        private void depart() {

            System.out.println("male size : " + male.size());
            System.out.println("female size : " + female.size());

            if (gender == 0) {
                System.out.println(id + " is leaving restroom, male");
                mInR--;
                /*
                 * after leaving the restroom, number of men in the restroom is 0 and women are waiting
                 * then notify some women threads
                 * */
                if (mInR == 0 && !thereIsNoWomanWaiting()) {
                    synchronized (lock2) {
                        lock2.notify();
                        lock2.notify();
                        lock2.notify();
                    }
                }
                /*
                 * after leaving the restroom, number of men in restroom is 0, no woman is waiting, men are waiting
                 * then notify some men threads
                 * */
                else if (mInR == 0 && thereIsNoWomanWaiting() && !thereIsNoManWaiting()) {
                    synchronized (lock1) {
                        lock1.notify();
                        lock1.notify();
                        lock1.notify();
                    }
                }
                /*
                 * after leaving the restroom, there is one man in the restroom, no woman is waiting, men are waiting
                 * then notify some men threads
                 * */
                else if (mInR == 1 && thereIsNoWomanWaiting() && !thereIsNoManWaiting()) {
                    synchronized (lock1) {
                        lock1.notify();
                        lock1.notify();
                        lock1.notify();
                    }
                }
                /*
                 * after leaving the restroom, 2 men are in the restroom, no woman is waiting
                 * notify some men threads
                 * */
                else if (mInR == 2 && thereIsNoWomanWaiting()) {
                    synchronized (lock1) {
                        lock1.notify();
                        lock1.notify();
                        lock1.notify();
                    }
                }
            } else {
                System.out.println(id + " is leaving restroom, female");
                wInR--;
                if (wInR == 0 && !thereIsNoManWaiting()) {
                    synchronized (lock1) {
                        lock1.notify();
                        lock1.notify();
                        lock1.notify();
                    }
                } else if (wInR == 0 && !thereIsNoWomanWaiting() && thereIsNoManWaiting()) {
                    synchronized (lock2) {
                        lock2.notify();
                        lock2.notify();
                        lock2.notify();
                    }
                } else if (wInR == 1 && !thereIsNoWomanWaiting() && thereIsNoManWaiting()) {
                    synchronized (lock2) {
                        lock2.notify();
                        lock2.notify();
                        lock2.notify();
                    }
                } else if (wInR == 2 && thereIsNoManWaiting()) {
                    synchronized (lock2) {
                        lock2.notify();
                        lock2.notify();
                        lock2.notify();
                    }
                }
            }
        }
    }
}
