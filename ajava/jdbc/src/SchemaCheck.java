import java.sql.*;

public class SchemaCheck {
    static final String URL = "jdbc:mysql://localhost:3300/college";
    static final String USER = "root";
    static final String PASS = "8511s766o395m";

    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS)) {
                System.out.println("CONNECTED");
                DatabaseMetaData meta = conn.getMetaData();
                ResultSet columns = meta.getColumns("college", null, "accounts", null);

                while (columns.next()) {
                    String colName = columns.getString("COLUMN_NAME");
                    System.out.println("COL:" + colName);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
