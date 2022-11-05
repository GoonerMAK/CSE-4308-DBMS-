import java.sql.*;
import java.util.Arrays;

public class Task4
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

            String sql = "SELECT A_ID, AMOUNT, TYPE FROM TRANSACTIONS";
            System.out.println("Executing the query: " + sql);

            ResultSet rs = statement.executeQuery(sql);

            long[] transactions = new long[233];
            Arrays.fill(transactions, 0);

            long[] account_balance = new long[233];
            Arrays.fill(account_balance, 0);

            while (rs.next())
            {
                int account = rs.getInt("a_id");
                int amount = rs.getInt("amount");
                String type = rs.getString("type");

                int i = account-1;
                transactions[i] = transactions[i] + amount;

                if(type.equals("0"))          // credit
                {
                    account_balance[i] = account_balance[i] - amount;
                }

                else if(type.equals("1"))     // debit
                {
                    account_balance[i] = account_balance[i] + amount;
                }

            }

            int CIP=0, VIP=0, OP=0, others=0;

            for(int i=0 ; i<233 ; i++)
            {
                if( account_balance[i] > 1000000 && transactions[i] > 5000000 )
                {
                    CIP++;
                }

                else if( account_balance[i] >500000 && account_balance[i] < 900000 &&
                            transactions[i] > 2500000 && transactions[i] < 4500000 )
                {
                    VIP++;
                }

                else if( account_balance[i] < 100000 && transactions[i] < 1000000 )
                {
                    OP++;
                }

                else
                {
                    others++;
                }
            }


            System.out.printf("CIP: " + CIP + ", VIP: " + VIP + " , OP: " + OP + " Other: " + others + "\n");

            rs.close();
            statement.close();
            conn.close();
            System.out.println("Thank you for banking with us!");
        } catch (Exception se) {
            se.printStackTrace();
        }
    }
}

