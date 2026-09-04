import java.sql.*;

public class CheckDB {
    static final String URL = "jdbc:mysql://localhost:3300/college";
    static final String USER = "root";
    static final String PASS = "8511s766o395m";

    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM accounts")) {

                System.out.println("=== ACCOUNTS TABLE ===");
                while (rs.next()) {
                    System.out.println(
                            rs.getInt("acc_no") + " | " +
                                    rs.getString("name") + " | " +
                                    rs.getDouble("balance"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
