package com.cafein.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;

/**
 *	mysql데이터베이스 연결을 테스트하기위한 클래스
 */
public class MysqlConnectTest {
	
	// 디비연결 정보
	private static final String DRIVER ="com.mysql.cj.jdbc.Driver";
	private static final String DBURL ="jdbc:mysql://itwillbs.com:3306/c7d2307t4_2";
	private static final String DBID ="c7d2307t4";
	private static final String DBPW ="1234";
	
	@Test
	public void testConnection() {
		try {
			// 1. 드라이버 로드
			Class.forName(DRIVER);
			System.out.println(" 드라이버 로드 성공! ");
			// 2. 디비 연결
			Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
			System.out.println(" 디비연결 성공! ");
			System.out.println(" con : "+con);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			System.out.println(" 자원해제 코드 작성 ");
		}
		
		try(Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);) {
			System.out.println(" 디비연결 성공2! ");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
		
	}

}
