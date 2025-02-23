/** Name: James Hazelwood, Eliska Jelinek */

import java.util.Scanner;

public class zeros {
    public static void main(String[] args){
        System.out.println("Welcome to the Zeros program.");
        System.out.println();

        // makes a scanner object to get user input
        Scanner s = new Scanner(System.in);
        
        while(true)
        {
            System.out.print("Please enter a number: ");

            // getting the users number
            int n1 = s.nextInt();
            System.out.println("The number of leading zeroes is: " + Zeroes(n1));
            System.out.print("Would you like to continue (y/n): ");

            // getting the users y or n 
            String s1 = s.next();
            System.out.println();

            // if the user typed "n", exits the program
            if(s1.equals("n")){
                s.close();
                System.out.println("Exiting");
                return;
            }
        }
    }

    public static int Zeroes(int n1){
        int n2 = 1073741824; // 01 with 30 0's in binary
        int count = 1;

        // checking if the number is negative with 1 with 31 0's in binary 
        if((n1 | -2147483648) == n1){
            return 0;
        }

        // loops until either a one is encountered or n2 goes down to 0
        while(n2 != 0){
            if((n1 | n2) == n1)
            {
                return count;
            } else {
                count += 1;
                n2 = n2 >> 1;
            }
        }
        return count;
    } 
}