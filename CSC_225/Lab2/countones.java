// Eliska Jelinek and James Hazelwood


import java.util.Scanner;
public class countones {
    public static void main(String[] args) {
        // Intro/setup
        System.out.println("Welcome to the CountOnes program.\n");
        Scanner in = new Scanner(System.in);

        // Keep asking user for input while they want to continue
        boolean cont = true;
        while (cont) {
            // Read the number from the user
            System.out.print("Please enter a number: ");
            int num = in.nextInt();

            // Count the number of 1s using bit shifting
            int ones = countOnes(num);

            // Display the result
            System.out.println("The number of bits set is: " + ones);

            // Ask to continue
            System.out.print("Continue (y/n)?: ");
            String user_cont = in.next();

            // Proceed to exit if user wants to stop
            if (user_cont.equals("n")) {
                cont = false;
            }
            System.out.println();
        }

        // Exit
        System.out.println("Exiting");
        in.close();

    }

    private static int countOnes(int num) {
        // Initialize count at 0
        int count = 0;

        // If -1, return 32 (my code returns 0 otherwise)
        if (num == -1) {
            return 32;
        }

        // While there are still potential 1-bits to count
        while (num != 0 & num != -1) {
            // If the number is odd
            if (num %2 == 1 || num%2 == -1) {
                // Add one to count
                count ++;
            }
            // Shift a bit digit to the right, adding a copy of sign bit on left
            num = num >>> 1;
        }
        // Return final 1 count
        return count;
    }
}
