package com.cafein.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

/**
 *	접근권한이 없을때 발생하는 오류 처리하는 클래스
 *  
 *  주소와 뷰페이지가 일치 (특정 쿠키,세션접근 처리가능)
 *
 */
public class CustomAccessDeniedHandler implements AccessDeniedHandler{
	
	private static final Logger logger = LoggerFactory.getLogger(CustomAccessDeniedHandler.class);
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		logger.debug(" CustomAccessDeniedHandler-handle() 호출 ");
		// 권한정보 체크 가능
				
		// 특정 페이지로 이동
		response.sendRedirect("/main/accessErr");
		
	}
	
}
