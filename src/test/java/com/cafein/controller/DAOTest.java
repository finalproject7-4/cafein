package com.cafein.controller;


import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cafein.persistence.TestDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
public class DAOTest {
	// 테스트 전용 클래스

	// 로거 객체 생성(출력전용 객체)
	private static final Logger logger = LoggerFactory.getLogger(DAOTest.class);

	// MemberDAO 객체가 필요 => memberDAOImpl 객체가 주입(DI)
	@Inject
	private TestDAO mdao;

	 @Test
	public void mybatis_테스트() {
		logger.info("@@@@@@@@@@@@@@@@@@@@@@");
		logger.debug("$$$$$$$$$$$$$$$$$$$$$$$$$"); 

	}
}
