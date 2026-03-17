# 🏦 College Banking System

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![JDBC](https://img.shields.io/badge/JDBC-4479A1?style=for-the-badge&logo=java&logoColor=white)

A robust, console-based banking application built with Java and JDBC. This system simulates core banking operations, allowing users to manage accounts, perform transactions, and maintain financial records securely using a MySQL database.

---

## 🚀 Features

- **User Authentication**: Secure registration and login system.
- **Account Management**: Open new accounts with initial deposits and unique account numbers.
- **Transactions**:
  - **Credit**: Deposit money into an account.
  - **Debit**: Withdraw money securely with PIN verification.
  - **Transfer**: Send money between accounts with atomic transaction integrity (rollback support).
- **Balance Inquiry**: Check current account balance.
- **Account Security**: PIN-based authorization for all sensitive operations.
- **Administration**: Option to delete accounts.

---

## 🛠️ Tech Stack

- **Language**: Java
- **Database**: MySQL
- **Connectivity**: JDBC (Java Database Connectivity)
- **Driver**: MySQL Connector/J

---

## 📋 Prerequisites

Before running the application, ensure you have the following installed:

1.  **Java Development Kit (JDK 8 or higher)**
2.  **MySQL Server**
3.  **MySQL Connector/J** (JDBC Driver)

---

## ⚙️ Database Setup

1.  Open your MySQL Workbench or Command Line.
2.  Execute the following SQL commands to set up the database and tables:

```sql
-- Create the database
CREATE DATABASE college;
USE college;

-- Create Users table
CREATE TABLE user (
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255) NOT NULL
);

-- Create Accounts table
CREATE TABLE accounts (
    account_number BIGINT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    balance DECIMAL(10,2) NOT NULL,
    security_pin VARCHAR(4) NOT NULL,
    FOREIGN KEY (email) REFERENCES user(email) ON DELETE CASCADE
);
```

> **Note**: The application defaults to using `root` as the username and password for the database connection. You can update these credentials in `src/bankingsystem/DBConnection.java`:
>
> ```java
> private static final String USER = "your_username";
> private static final String PASS = "your_password";
> ```

---

## 🏃‍♂️ How to Run

1.  **Clone the Repository** (or download usage files).
2.  **Compile the Code**:
    Navigate to the `src` directory (or where the `bankingsystem` package is located) and run:
    ```sh
    javac bankingsystem/*.java
    ```
3.  **Run the Application**:
    Ensure the MySQL JDBC driver is in your classpath.
    ```sh
    java -cp ".;path/to/mysql-connector-j-8.x.x.jar" bankingsystem.BankingApp
    ```
    *(Replace `path/to/mysql-connector-j-8.x.x.jar` with the actual path to your connector jar file. On Linux/Mac use `:` instead of `;` as the separator)*

---

## 📸 Usage Example

```text
Welcome to College Banking System
1. Register
2. Login
3. Exit
Enter choice: 1
...
Login successful!
1. Open New Account
2. Credit Money
3. Debit Money
4. Transfer Money
...
```

---

## 🔒 Security Features

- **SQL Injection Prevention**: Uses `PreparedStatement` for all database queries.
- **ACID Compliance**: Ensuring data integrity during fund transfers using transaction management (`commit` / `rollback`).

---

Made with ❤️ by [Your Name]
