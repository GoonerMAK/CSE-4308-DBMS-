import java.sql.*;

public class Task3
{
    static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
    static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    static final String USER = "System";
    static final String PASS = "DemonSlayer123";

    public static void main(String args[]) {
        Connection conn = null;
        Statement statement = null;
        try {
            Class.forName(JDBC_DRIVER);
            System.out.println("Connecting to database");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            System.out.println("Creating statement");
            statement = conn.createStatement();

            String sql = "SELECT COUNT(T_ID) TOTAL \n" +
                    "FROM TRANSACTIONS\n" +
                    "WHERE EXTRACT(YEAR FROM TRANSACTIONS.DTM) = 2020";

            System.out.println("Executing the query: " + sql);

            ResultSet rs = statement.executeQuery(sql);

            while (rs.next())
            {
                int total = rs.getInt("TOTAL");

                System.out.println( "Total transactions: " + total );
            }

            rs.close();
            statement.close();
            conn.close();
            System.out.println("Thank you for banking with us!");
        } catch (Exception se) {
            se.printStackTrace();
        }
    }
}


