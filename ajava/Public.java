import java.sql.*;

public class Public {
    
    static final String DB_URL = "jdbc:mysql://localhost:3306/your_database";
    static final String DB_USER = "root";
    static final String DB_PASSWORD = "your_password";
    
    public static void main(String[] args) {
    
        displayProductsWithPriceGreaterThan1000();
    }
    
    public static void displayProductsWithPriceGreaterThan1000() {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            
            String query = "SELECT product_id, product_name, price FROM products WHERE price > ?";
            
            
statement = connection.prepareStatement(query);
            statement.setDouble(1, 1000);
            
            resultSet = statement.executeQuery();

            System.out.println("========================================");
            System.out.println("Products with Price > 1000");
            System.out.println("========================================");
            System.out.printf("%-15s %-30s %-15s%n", "Product ID", "Product Name", "Price");
            System.out.println("----------------------------------------");
            
            boolean hasRecords = false;
            while (resultSet.next()) {
                hasRecords = true;
                int productId = resultSet.getInt("product_id");
                String productName = resultSet.getString("product_name");
                double price = resultSet.getDouble("price");
                
                System.out.printf("%-15d %-30s %-15.2f%n", productId, productName, price);
            }
            
            if (!hasRecords) {
                System.out.println("No products found with price > 1000");
            }
            
            System.out.println("========================================");
            
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        } finally {

            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
    }
}
