package connection;
/**
 *
 * @author Angelo
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connexion {
     public static Connection connect() throws Exception {
        Connection connection = null;
        try {
            Class.forName("org.postgresql.Driver");

             connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/poketra", "postgres", "postgres");
             connection.setAutoCommit(false);

            System.out.println("Connected to the PostgreSQL database successfully!");

        } catch (ClassNotFoundException e) {
            System.err.println("postgres JDBC Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Connection failed!");
            e.printStackTrace();
        }
        return connection;
    }
}
