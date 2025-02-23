import java.io.File;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class decodeImage {
    private static List<Point> readFromFile(String filename) {
        List<Point> fileLines = new ArrayList<>();
        try {
            Scanner sc = new Scanner(new File(filename));
            while (sc.hasNext()) {
                String[] pointData = sc.nextLine().split(", ");
                double x = Double.parseDouble(pointData[0]);
                double y = Double.parseDouble(pointData[1]);
                double z = Double.parseDouble(pointData[2]);
                fileLines.add(new Point(x, y, z));
                //sc.nextLine();
            }
        } catch (Exception e) {
            System.out.println("Issue with opening and reading from input file.");
        }
        return fileLines;
    }

    private static void writeToFile(List<String> fileLines, String filename) {
        if (filename.isEmpty()) {
            filename = "drawMe1.txt"; // TODO: Update file name
        }
        try {
            PrintStream ps = new PrintStream(filename);
            for (String line : fileLines) {
                ps.println(line);//.toString());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    private static List<String> decodeImageStream(List<Point> coded) {
        List<String> decoded = coded.stream()
                .filter(p -> p.getZ() <= 2)
                .map(p -> new Point(p.getX()*0.5, p.getY()*0.5, p.getZ()*0.5))
                .map(p -> new Point(p.getX()-150.0, p.getY()-37.0, p.getZ()))
                .map(Point::toString)
                .collect(Collectors.toList());
        return decoded;
    }


    public static void main(String[] args) {
        List<Point> data = readFromFile("positions.txt");
        for (Point p : data) {System.out.println(p);}
        List<String> decodedData = decodeImageStream(data);
        writeToFile(decodedData, "attempt1.txt");
    }
}