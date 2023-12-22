package com.cafein.controller;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class TestControllerTest {

	private static final Logger logger = LoggerFactory.getLogger(TestControllerTest.class);

	@Inject
	private WebApplicationContext wac;
	
	// MockMvc : 요청,응답을 처리하는 테스트용객체
	private MockMvc mockMvc;
	
	// @Before : @Test 실행전에 반드시 처리해야하는 메서드
	@Before 
	public void setUp() {
		// MockMvc 객체를 생성(준비)
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
		logger.debug(" MockMvc 객체를 생성 완료! (테스트 준비) ");		
	}
	
	@Test
	public void controllerTest() {
		// 서버없이 컨트롤러를 테스트 
		try {
			mockMvc.perform(MockMvcRequestBuilders.get("/doA"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	
	
}
