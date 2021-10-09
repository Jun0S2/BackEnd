package util;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SqlSession {
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private static Connection getConnection() throws Exception {
		return DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1:3306/daejeondb?useUniCode=yes&characterEncoding=UTF-8",
				"ID", "PASSWORD"
		);
	}
	
	private static int executeUpdate(String sql, Object... args) throws SQLException {
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			int index = 1;
			for (Object arg : args) {
				pstmt.setObject(index++, arg);
			}
			return pstmt.executeUpdate();
		} catch (Exception e) {
			throw new SQLException(e);
		}
	}
	
	public static int insert(String sql, Object... args) throws SQLException {
		return executeUpdate(sql, args);
	}

	public static int update(String sql, Object... args) throws SQLException {
		return executeUpdate(sql, args);
	}

	public static int delete(String sql, Object... args) throws SQLException {
		return executeUpdate(sql, args);
	}

	public static <T> List<T> selectList(Class<T> clz, String sql, Object... args) throws SQLException {
		
		List<T> list = new ArrayList<>();
		try (
				Connection con = getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);
		) {
			int index = 1;
			for (Object arg : args) pstmt.setObject(index++, arg);
			
			ResultSet rs = pstmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			
			Map<String, Method> mappings = new HashMap<>();
			Method[] arr = clz.getDeclaredMethods();
			for (Method m : arr) {
				mappings.put(m.getName(), m);
			}

			while (rs.next()) {
				T target = clz.getConstructor().newInstance();
				list.add(target);
				int count = rsmd.getColumnCount();
				for (int i = 1; i <= count; i++) {
					String columnName = rsmd.getColumnName(i);
					String columnType = rsmd.getColumnTypeName(i);
					Method m = mappings.get("set" + Character.toUpperCase(columnName.charAt(0)) + columnName.substring(1));
					if (m == null) continue;
					String typeName = m.getParameters()[0].getType().getSimpleName();
					switch (typeName) {
					case "String": m.invoke(target, rs.getString(columnName)); break;
					case "int": m.invoke(target, rs.getInt(columnName)); break;
					case "double": m.invoke(target, rs.getDouble(columnName)); break;
					case "Date": 
						if (columnType.equalsIgnoreCase("timestamp")) {
							m.invoke(target, rs.getTimestamp(columnName)); 
						} else {
							m.invoke(target, rs.getDate(columnName)); 
						}
						break;
					}
				}
			}
		} catch (Exception e) {
			throw new SQLException(e);
		}
		return list;
	}
	
	public static <T> T selectOne(Class<T> clz, String sql, Object... args) throws SQLException {
		List<T> list = selectList(clz, sql, args);
		return list.isEmpty() ? null : list.get(0);
	}

}
