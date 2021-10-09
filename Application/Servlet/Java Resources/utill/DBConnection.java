package util;

import java.sql.*;

public class DBConnection {

	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/daejeondb?serverTimezone=UTC&useUniCode=yes&characterEncoding=UTF-8";
	private static final String DB_ID = "ssafy";
	private static final String DB_PASS = "ssafy";
	
	static {
		try {
			Class.forName(DRIVER);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, DB_ID, DB_PASS);
	}
}
























