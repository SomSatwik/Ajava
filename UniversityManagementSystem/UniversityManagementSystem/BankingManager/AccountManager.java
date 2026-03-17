package bankingsystem;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AccountManager {
    private final Connection conn;
    private final Accounts accounts;

    public AccountManager(Connection conn) {
        this.conn = conn;
        this.accounts = new Accounts(conn);
    }

    private void validatePin(Accounts.Account acc, String pin) {
        if (acc == null) {
            throw new BankingException("Account does not exist.");
        }
        if (acc.securityPin == null || !acc.securityPin.equals(pin)) {
            throw new BankingException("Invalid security PIN.");
        }
    }

    public void creditMoney(long accountNumber, BigDecimal amount, String pin) throws SQLException {
        Accounts.Account acc = accounts.getAccountByNumber(accountNumber);
        validatePin(acc, pin);

        String sql = "UPDATE accounts SET balance = balance + ? WHERE account_number = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBigDecimal(1, amount);
            ps.setLong(2, accountNumber);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new BankingException("Failed to credit money. Account may have been deleted.");
            }
        }
    }

    public void debitMoney(long accountNumber, BigDecimal amount, String pin) throws SQLException {
        Accounts.Account acc = accounts.getAccountByNumber(accountNumber);
        validatePin(acc, pin);

        if (acc.balance.compareTo(amount) < 0) {
            throw new BankingException("Insufficient funds. Available: " + acc.balance);
        }

        String sql = "UPDATE accounts SET balance = balance - ? WHERE account_number = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBigDecimal(1, amount);
            ps.setLong(2, accountNumber);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new BankingException("Failed to debit money.");
            }
        }
    }

    public void transferMoney(long senderAcc, long receiverAcc, BigDecimal amount, String pin) throws SQLException {
        if (senderAcc == receiverAcc) {
            throw new BankingException("Cannot transfer money to the same account.");
        }

        try {
            conn.setAutoCommit(false);

            Accounts.Account sender = accounts.getAccountByNumber(senderAcc);
            Accounts.Account receiver = accounts.getAccountByNumber(receiverAcc);

            if (sender == null)
                throw new BankingException("Sender account not found.");
            if (receiver == null)
                throw new BankingException("Receiver account not found.");

            validatePin(sender, pin);

            if (sender.balance.compareTo(amount) < 0) {
                throw new BankingException("Insufficient funds in sender account.");
            }

            String withdrawSQL = "UPDATE accounts SET balance = balance - ? WHERE account_number = ?";
            String depositSQL = "UPDATE accounts SET balance = balance + ? WHERE account_number = ?";

            try (PreparedStatement w = conn.prepareStatement(withdrawSQL);
                    PreparedStatement d = conn.prepareStatement(depositSQL)) {

                w.setBigDecimal(1, amount);
                w.setLong(2, senderAcc);
                int rowsAffectedSender = w.executeUpdate();

                d.setBigDecimal(1, amount);
                d.setLong(2, receiverAcc);
                int rowsAffectedReceiver = d.executeUpdate();

                if (rowsAffectedSender > 0 && rowsAffectedReceiver > 0) {
                    conn.commit();
                } else {
                    conn.rollback();
                    throw new BankingException("Transaction failed during update.");
                }
            } catch (SQLException ex) {
                conn.rollback();
                throw ex;
            }
        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException rollbackEx) {
                /* ignore */ }
            throw e;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                /* ignore */ }
        }
    }

    public BigDecimal checkBalance(long accountNumber, String pin) throws SQLException {
        Accounts.Account acc = accounts.getAccountByNumber(accountNumber);
        validatePin(acc, pin);
        return acc.balance;
    }

    public Accounts.Account getAccountByEmail(String email) throws SQLException {
        return accounts.getAccountByEmail(email);
    }

    // Feature moved from TransactionFixed.java
    public void deleteAccount(long accountNumber, String pin) throws SQLException {
        Accounts.Account acc = accounts.getAccountByNumber(accountNumber);
        validatePin(acc, pin);

        String sql = "DELETE FROM accounts WHERE account_number = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, accountNumber);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new BankingException("Failed to delete account. It may not exist.");
            }
        }
    }
}
