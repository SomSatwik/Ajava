package bankingsystem;

import java.io.InputStream;
import java.math.BigDecimal;
import java.util.Scanner;

public class ConsoleHelper {
    private final Scanner scanner;

    public ConsoleHelper(InputStream in) {
        this.scanner = new Scanner(in);
    }

    public void printHeader(String title) {
        System.out.println("\n========================================");
        System.out.println("   " + title.toUpperCase());
        System.out.println("========================================");
    }

    public void printSuccess(String message) {
        System.out.println(">> SUCCESS: " + message);
    }

    public void printError(String message) {
        System.out.println(">> ERROR: " + message);
    }

    public void printInfo(String message) {
        System.out.println(">> " + message);
    }

    public String readString(String prompt) {
        System.out.print(prompt + ": ");
        return scanner.nextLine().trim();
    }

    public int readInt(String prompt) {
        while (true) {
            System.out.print(prompt + ": ");
            String input = scanner.nextLine().trim();
            try {
                return Integer.parseInt(input);
            } catch (NumberFormatException e) {
                printError("Invalid input. Please enter a number.");
            }
        }
    }
    
    public long readLong(String prompt) {
        while (true) {
            System.out.print(prompt + ": ");
            String input = scanner.nextLine().trim();
            try {
                return Long.parseLong(input);
            } catch (NumberFormatException e) {
                printError("Invalid input. Please enter a valid number.");
            }
        }
    }

    public BigDecimal readBigDecimal(String prompt) {
        while (true) {
            System.out.print(prompt + ": ");
            String input = scanner.nextLine().trim();
            try {
                BigDecimal value = new BigDecimal(input);
                if (value.compareTo(BigDecimal.ZERO) < 0) {
                     printError("Amount cannot be negative.");
                     continue;
                }
                return value;
            } catch (NumberFormatException e) {
                printError("Invalid amount. Please enter a valid decimal number (e.g., 100.00).");
            }
        }
    }
    
    public void pause() {
        System.out.println("\nPress Enter to continue...");
        scanner.nextLine();
    }
}
