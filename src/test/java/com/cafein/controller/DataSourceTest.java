package com.cafein.controller;

import java.sql.Connection;
import java.sql.SQLException;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 *	디비연결 테스트 (Spring - DataSource 사용) * 
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"}
		)
public class DataSourceTest {
	
	//@Inject
	@Autowired
	private DataSource ds;
	
	@Test
	public void dataSourceTest() {
		System.out.println(" 의존객체 주입 성공 여부 확인! ");
		System.out.println(ds);		
	}
	
	@Test
	public void 디비연결테스트() {
		try {
			Connection con = ds.getConnection();
			System.out.println(" 디비연결 성공! ");
			System.out.println( con );
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
