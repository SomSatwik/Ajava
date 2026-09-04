import java.sql.*;
import java.util.Scanner;
public class JdbcTest {
    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3300/college";
        String user = "root";
        String password = "Aniket123";

        String query = "insert into student(id,name,marks) values(?,?, ?);";




        try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("Driver Loaded");
        }catch(Exception e){
            e.printStackTrace();
        }

        try{
            Connection connection = DriverManager.getConnection(url, user, password);
            System.out.println("Connection Established");
            Scanner sc = new Scanner(System.in);
            
            String response = "Y";
            while(response.equals("Y")){
                System.out.println("Enter id:");
                int id = sc.nextInt();
                System.out.println("Enter name:");
                String name = sc.next();
                
                // Convert name to uppercase using for loop
                char[] nameArray = name.toCharArray();
                for(int i = 0; i < nameArray.length; i++){
                    nameArray[i] = Character.toUpperCase(nameArray[i]);
                }
                String upperName = new String(nameArray);
                
                System.out.println("Enter marks:");
                int marks = sc.nextInt();
                
                PreparedStatement statement = connection.prepareStatement(query);
                
                statement.setInt(1, id);
                statement.setString(2, upperName);
                statement.setInt(3, marks);

                int row = statement.executeUpdate();
                if (row>0){
                    System.out.println(" success : "+ row +" rows affected");
                }else{
                    System.out.println("failed");
                }
                
                statement.close();
                
                System.out.println("Do you want to continue? (Y/N):");
                response = sc.next().toUpperCase();
            }

            connection.close();
            System.out.println("Connection Closed");


        }catch(Exception e){
            e.printStackTrace();
        }
    }
}