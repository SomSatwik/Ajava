package bankingsystem;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;

public class BankingApp {

    public static void main(String[] args) {
        ConsoleHelper console = new ConsoleHelper(System.in);
        console.printHeader("Welcome to College Banking System");

        try (Connection conn = DBConnection.getConnection()) {
            Users users = new Users(conn);
            Accounts accounts = new Accounts(conn);
            AccountManager manager = new AccountManager(conn);

            String currentUserEmail = null;

            while (true) {
                if (currentUserEmail == null) {
                    console.printHeader("Main Menu");
                    System.out.println("1. Register");
                    System.out.println("2. Login");
                    System.out.println("3. Exit");
                    int choice = console.readInt("Enter choice");

                    switch (choice) {
                        case 1:
                            String name = console.readString("Enter full name");
                            String email = console.readString("Enter email");
                            String pwd = console.readString("Enter password");
                            try {
                                if (users.register(name, email, pwd)) {
                                    console.printSuccess("Registration successful! Please login.");
                                } else {
                                    console.printError("Registration failed. Email might already exist.");
                                }
                            } catch (SQLException e) {
                                console.printError("Database error during registration: " + e.getMessage());
                            }
                            break;
                        case 2:
                            String loginEmail = console.readString("Enter email");
                            String loginPwd = console.readString("Enter password");
                            try {
                                if (users.login(loginEmail, loginPwd)) {
                                    currentUserEmail = loginEmail;
                                    console.printSuccess(
                                            "Login successful! Welcome " + users.getFullName(currentUserEmail));
                                } else {
                                    console.printError("Invalid email or password.");
                                }
                            } catch (SQLException e) {
                                console.printError("Login error: " + e.getMessage());
                            }
                            break;
                        case 3:
                            console.printInfo("Goodbye!");
                            return;
                        default:
                            console.printError("Invalid choice.");
                    }
                } else {
                    console.printHeader("User Menu (" + currentUserEmail + ")");
                    System.out.println("1. Open New Account");
                    System.out.println("2. Credit Money");
                    System.out.println("3. Debit Money");
                    System.out.println("4. Transfer Money");
                    System.out.println("5. Check Balance");
                    System.out.println("6. View Details");
                    System.out.println("7. Delete Account");
                    System.out.println("8. Logout");
                    int choice = console.readInt("Enter choice");

                    try {
                        switch (choice) {
                            case 1:
                                if (accounts.accountExistsByEmail(currentUserEmail)) {
                                    console.printError("You already have an account.");
                                } else {
                                    BigDecimal initialBalance = console.readBigDecimal("Enter initial deposit");
                                    String pin = console.readString("Set 4-digit security PIN");
                                    if (!pin.matches("\\d{4}")) {
                                        console.printError("PIN must be exactly 4 digits.");
                                        break;
                                    }
                                    long newAccNo = accounts.generateAccountNumber();
                                    String fullName = users.getFullName(currentUserEmail);
                                    if (accounts.openAccount(newAccNo, fullName, currentUserEmail, initialBalance,
                                            pin)) {
                                        console.printSuccess("Account opened successfully!");
                                        console.printInfo("Your Account Number is: " + newAccNo);
                                        console.printInfo("Please keep your PIN safe.");
                                    } else {
                                        console.printError("Failed to open account.");
                                    }
                                }
                                break;
                            case 2:
                                long cAcc = console.readLong("Enter account number");
                                BigDecimal cAmt = console.readBigDecimal("Enter amount to credit");
                                String cPin = console.readString("Enter security PIN");
                                manager.creditMoney(cAcc, cAmt, cPin);
                                console.printSuccess("Amount credited successfully.");
                                break;
                            case 3:
                                long dAcc = console.readLong("Enter account number");
                                BigDecimal dAmt = console.readBigDecimal("Enter amount to debit");
                                String dPin = console.readString("Enter security PIN");
                                manager.debitMoney(dAcc, dAmt, dPin);
                                console.printSuccess("Amount debited successfully.");
                                break;
                            case 4:
                                long sAcc = console.readLong("Sender account number");
                                long rAcc = console.readLong("Receiver account number");
                                BigDecimal tAmt = console.readBigDecimal("Enter amount to transfer");
                                String tPin = console.readString("Sender security PIN");
                                manager.transferMoney(sAcc, rAcc, tAmt, tPin);
                                console.printSuccess("Transfer successful.");
                                break;
                            case 5:
                                long bAcc = console.readLong("Enter account number");
                                String bPin = console.readString("Enter security PIN");
                                BigDecimal balance = manager.checkBalance(bAcc, bPin);
                                if (balance != null) {
                                    console.printInfo("Available Balance: $" + balance);
                                }
                                break;
                            case 6:
                                Accounts.Account myAcc = accounts.getAccountByEmail(currentUserEmail);
                                if (myAcc != null) {
                                    console.printInfo("--- Account Details ---");
                                    System.out.println("Account Number: " + myAcc.accountNumber);
                                    System.out.println("Holder Name:    " + myAcc.fullName);
                                    System.out.println("Email:          " + myAcc.email);
                                    System.out.println("Balance:        $" + myAcc.balance);
                                } else {
                                    console.printError("No account found.");
                                }
                                break;
                            case 7:
                                console.printInfo("WARNING: This will permanently delete your account.");
                                String confirm = console.readString("Type 'YES' to confirm");
                                if ("YES".equals(confirm)) {
                                    long delAcc = console.readLong("Enter account number to delete");
                                    String delPin = console.readString("Enter security PIN");
                                    manager.deleteAccount(delAcc, delPin);
                                    console.printSuccess("Account deleted successfully.");
                                } else {
                                    console.printInfo("Deletion cancelled.");
                                }
                                break;
                            case 8:
                                currentUserEmail = null;
                                console.printSuccess("Logged out.");
                                break;
                            default:
                                console.printError("Invalid option.");
                        }
                    } catch (BankingException be) {
                        console.printError(be.getMessage());
                    } catch (SQLException ex) {
                        console.printError("System error: " + ex.getMessage());
                    }
                    console.pause();
                }
            }
        } catch (SQLException e) {
            console.printError("Failed to connect to the database: " + e.getMessage());
        }
    }
}
