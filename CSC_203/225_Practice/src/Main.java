public class Main {
    public static double main(String[] args) {
        System.out.println("Hello world!");


        double c = 2;
        double r = 3;
        double p = 1;

        if (c > r && c > p) {
            return c;
        } else if (r > p) {
            return r;
        } else {return p;}
    }
}