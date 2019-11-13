package com.exam.repository;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class DBManager {

	public static Connection getConnection() throws Exception {
		Connection con = null;
//		// DB접속정보
//		String url = "jdbc:oracle:thin:@localhost:1521:xe";
//		String user = "scott";
//		String password = "tiger";
//		
//		Connection con = null;
//		// 1단계: DB 드라이버 로딩
//		Class.forName("oracle.jdbc.OracleDriver");
//		// 2단계: DB연결
//		con = DriverManager.getConnection(url, user, password);
		//DBCP적용한코드
		// dataSource는 커넥션을 미리 일정개수 보유
		Context context = new InitialContext();
		DataSource ds = (DataSource) context.lookup("java:/comp/env/jdbc/mysqldb");
		con = ds.getConnection(); // 커넥션 한개 빌려오기
		return con;
	}
	
	// SELECT문을 수행한 후 리소스 해제를 위한 메소드
	public static void close(Connection con, Statement stmt, ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	} // close method
	
	// INSERT, UPDATE, DELETE문을 수행한 후 리소스 해제를 위한 메소드
	public static void close(Connection con, Statement stmt) {
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	} // close method
	
}



