public class Point {
    double x;
    double y;
    double z;

    public Point(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }
    public double getZ() {return z;}
    public double getX() {return x;}
    public double getY() {return y;}

    @Override
    public String toString() {
        return x+", "+y+", "+z;
    }
}
