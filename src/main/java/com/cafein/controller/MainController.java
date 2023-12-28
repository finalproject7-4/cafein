package com.cafein.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafein.domain.MemberVO;
import com.cafein.service.MainService;

@Controller
@RequestMapping(value = "/main/*")
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Inject
	private MainService mainService;
	
	// http://localhost:8088/main/login
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGET() throws Exception {
		logger.debug("loginGET() 호출");
		logger.debug("/views/main/login.jsp 페이지로 이동");
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPOST(MemberVO vo, HttpSession session) throws Exception {
		logger.debug("loginPOST() 호출");
		
		MemberVO resultVO = mainService.memberLogin(vo);
		
		if(resultVO != null) {
			logger.debug("/views/main/main.jsp 페이지로 이동");
			
			session.setAttribute("membercode", resultVO.getMembercode());
			logger.debug("membercode: " + resultVO.getMembercode());
			logger.debug("memberpw: " + resultVO.getMemberpw());
			return "redirect:/main/main";
		}
		
		return "redirect:/main/login";
	}
	
	// http://localhost:8088/main/main
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void mainGET() throws Exception {
		logger.debug("mainGET() 호출");
		logger.debug("/views/main/main.jsp 페이지로 이동");
	}
	
	
}
