import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class YourMainClass {
    public static void main(String[] args) {
        // Use environment variables to store sensitive information
        String url = System.getenv("DB_URL"); // Database URL
        String user = System.getenv("DB_USERNAME"); // Database username
        String password = System.getenv("DB_PASSWORD"); // Database password

        try (Connection connection = DriverManager.getConnection(url, user, password)) {
            System.out.println("Connection successful!");
            // Your database operations here

        } catch (SQLException e) {
            System.err.println("Connection failed!");
            e.printStackTrace();
        }
    }
}
