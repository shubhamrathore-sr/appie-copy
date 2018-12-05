/**
 * 
 */
package ai.talentify.db.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @author Vaibhav Verma
 *
 */
public class DBUtils {
	private static final Logger logger = LogManager.getLogger(DBProperties.class);
	public int insertIntoDB(String sqlQuery) {
		int retrunIndex = 0;
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName(DBProperties.getProperty("JDBC_DRIVER"));
			conn = DriverManager.getConnection(DBProperties.getProperty("DB_URL"), DBProperties.getProperty("USER"),
					DBProperties.getProperty("PASS"));
			stmt = conn.createStatement();
			stmt.executeUpdate(sqlQuery);
		} catch (SQLException se) {
			logger.error(sqlQuery);
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					conn.close();
			} catch (SQLException se) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		return retrunIndex;
	}

	public int insertIntoDBWithGeneratedKey(String sqlQuery) {
		int retrunIndex = 0;
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName(DBProperties.getProperty("JDBC_DRIVER"));
			conn = DriverManager.getConnection(DBProperties.getProperty("DB_URL"), DBProperties.getProperty("USER"),
					DBProperties.getProperty("PASS"));
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sqlQuery);
			rs.next();
			retrunIndex = rs.getInt(1);
		} catch (SQLException se) {
			logger.error(sqlQuery);
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					conn.close();
			} catch (SQLException se) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		return retrunIndex;
	}

	public ArrayList<HashMap<String, String>> executeQuery(String sqlQuery) {
		long now = System.currentTimeMillis();
		ArrayList<HashMap<String, String>> table = new ArrayList<HashMap<String, String>>();
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName(DBProperties.getProperty("JDBC_DRIVER"));
			conn = DriverManager.getConnection(DBProperties.getProperty("DB_URL"), DBProperties.getProperty("USER"),
					DBProperties.getProperty("PASS"));
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sqlQuery);

			// get column names

			ResultSetMetaData rsmd = rs.getMetaData();

			ArrayList<String> columnnames = new ArrayList<String>();
			for (int i = 1; i <= rsmd.getColumnCount(); i++) {

				columnnames.add(rsmd.getColumnName(i));
			}

			while (rs.next()) {
				HashMap<String, String> row = new HashMap<String, String>();
				for (String columnName : columnnames) {
					String first = rs.getString(columnName);
					row.put(columnName, first);
				}
				table.add(row);
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					conn.close();
			} catch (SQLException se) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		logger.info("Time Taken for query ->"+ sqlQuery+ " took time "+ (System.currentTimeMillis()-now));
		return table;
	}

}
