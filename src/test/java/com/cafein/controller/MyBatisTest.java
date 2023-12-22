package com.cafein.controller;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"}
		)
public class MyBatisTest {
	
	@Inject
	private SqlSessionFactory sqlFactory;
	
	@Inject
	private SqlSession sqlSession;
	
	
	@Test
	public void mybatis연결테스트() {
		System.out.println("sqlFactory: "+sqlFactory);
		System.out.println("sqlSession: "+sqlSession);
	}
	
	
	
	
	

}
