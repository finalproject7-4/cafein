package com.cafein.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

/**
 *  로그인 성공 시 권한별로 페이지 이동
 */
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	private static final Logger logger = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);
	
	// method overriding
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		logger.debug(" @@@ : CustomLoginSuccessHandler-onAuthenticationSuccess() 호출 ");
		
		logger.debug(" @@@ : 사용자 로그인 성공! ");
		
		// 사용자의 권한 정보를 저장
		List<String> roleNames = new ArrayList<String>();
		
		auth.getAuthorities().forEach(authority -> { // authority -> {} : 람다식
			roleNames.add(authority.getAuthority());
		});
		
		logger.debug(" roleNames : " + roleNames);
		
		// 각 권한별로 페이지 이동
		// ex) roleNames : [ROLE_MEMBER,ROLE_ADMIN]
		// ex) roleNames : [ROLE_MEMBER]
		if(roleNames.contains("ROLE_ADMIN")) {
			logger.debug(" 관리자 로그인 성공! ");
			// 페이지 이동
			response.sendRedirect("/main/main");
			return;
		}
		
		if(roleNames.contains("ROLE_MEMBER")) {
			logger.debug(" 일반 유저 로그인 성공! ");
			// 페이지 이동
			response.sendRedirect("/main/main");
			return;
		}
		
		// 그외 나머지
		response.sendRedirect("/main/main");
		
		// 코드를 보다보면 if else를 잘 안보실 거에요. 보통은 잘 안씁니다.
		// 상위 레벨로 갈 수록 if문이 많이 보일 것. 대부분의 if문에는 return이 들어있을 것
		// if문의 return을 통해 빠져나가고 그 외 나머지를 ... 하는 것 많이 보일 것
		// 오픈소스들이 이런 경우 많을 것. 조금씩 인지하면서 하시길...
	}

	
}































