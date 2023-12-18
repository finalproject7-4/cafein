package com.cafein.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafein.domain.TestVO;
import com.cafein.service.TestService;

@Controller
@RequestMapping(value = "/test/*")
public class TestController {

	private static final Logger logger = LoggerFactory.getLogger(TestController.class);

	@Inject
	private TestService tService;

	// http://localhost:8088/test/test1
	@RequestMapping(value = "/test1", method = RequestMethod.GET)
	public void memberJoinGET() {
		logger.debug("test() 실행");

	}

	@RequestMapping(value = "/test1", method = RequestMethod.POST)
	public String memberJoinPOST(/* @ModelAttribute */ TestVO vo) {
		logger.debug("  memberJoinPOST() 호출 ");
		// MemberVO vo = new MemberVO();
		// vo.setUserid(request.getParamater("userid"));
		// 한글처리(인코딩 설정) => 필터
		// 전달정보 저장
		logger.debug(" vo :" + vo);

		// DB에 정보를 저장 => 서비스 객체 사용
		// new MemberDAO().method() 호출;
		logger.debug(" 서비스 회원가입 동작을 호출 - 시작");
		tService.memberJoin(vo);
		logger.debug(" 서비스 회원가입 동작을 호출 - 끝");

		// 페이지 이동 (로그인페이지-/members/login)
		return "redirect:/test/test2";
	}
	
	// http://localhost:8088/test/test2
	// 로그인 - 정보 입력 (GET)
	@RequestMapping(value="/test2", method = RequestMethod.GET)
	public void memberLoginGET() {
		logger.debug(" /test/test2 호출 -> memberLoginGET 실행 ");
		logger.debug(" 연결된 뷰 페이지(/views/members/login.jsp) 이동 ");
		
	}
	
	// 로그인 - 정보 처리 (POST)
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String memberLoginPOST(TestVO vo, HttpSession session) {
		logger.debug(" /members/login.jsp post방식 호출 -> memberLoginPOST() 실행 ");
		
		// 전달 정보 저장(파라메터-userid, userpw)
		logger.debug("전달정보: "+vo);
		// 디비 접근 -> 서비스 접근 - 로그인 처리 
		TestVO resultVO = tService.memberLogin(vo);
		
		// 로그인 결과에 따른 페이지 이동
		if(resultVO != null) {
			// O -> /members/main 페이지 호출(리다이렉트), 세션 아이디 정보 저장
			return "redirect:/test/main";
		} else {
			// X -> /members/login 페이지 호출(리다이렉트)
			return "redirect:/test/test2";			
		}
	}
	
	
	
}
