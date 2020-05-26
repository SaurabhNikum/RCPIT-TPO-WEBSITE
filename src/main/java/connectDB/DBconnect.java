package connectDB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import launch.Main;
import services.DynamicPropertyResolver;

public class DBconnect {
	private static Connection con = null;
	final private static Logger log = LoggerFactory.getLogger(DBconnect.class);
	public static Connection getConnect(){	

		if(con==null)
		{
			try
			{
		        Properties prop = DynamicPropertyResolver.getProperty();
		        String dbHost = prop.getProperty("db.host");
		        String dbPort = prop.getProperty("db.port");
		        String dbName = prop.getProperty("db.name");
		        String dbUser = prop.getProperty("db.user");
		        String password = prop.getProperty("db.password");
    
				Class.forName("com.mysql.jdbc.Driver");  
				con = DriverManager.getConnection("jdbc:mysql://"+dbHost+":"+dbPort
						+"/"+dbName, dbUser, password);
				log.info("Connected");
				return con;
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return con;
	}
}
