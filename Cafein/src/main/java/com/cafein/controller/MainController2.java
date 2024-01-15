package com.cafein.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafein.domain.MemberVO;
import com.cafein.domain.ProduceVO;
import com.cafein.service.MainService;
import com.cafein.service.ProductionService;

@Controller
@RequestMapping(value = "")
public class MainController2 {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController2.class);
	
	@Inject
	private MainService mainService;
	
	@Inject
	private ProductionService proService;
	
	// 로그인 - GET
	// http://localhost:8088/login
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGET() throws Exception {
		logger.debug(" loginGET() 호출 ");
		logger.debug(" /views/login.jsp 페이지로 이동 ");
	}
	
	// 로그인 - POST
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPOST(MemberVO vo, HttpSession session) throws Exception {
		logger.debug(" loginPOST() 호출 ");
		
		MemberVO resultVO = mainService.memberLogin(vo);
		
		// 사원번호와 비밀번호가 일치할 때 동작
		if(resultVO != null) {
			logger.debug(" /views/main.jsp 페이지로 이동 ");
			
			// 로그인 할 때 세션에 필요한 정보 담아가기
			session.setAttribute("membercode", resultVO.getMembercode()); // 직원번호(사원번호)
			session.setAttribute("membername", resultVO.getMembername()); // 직원이름
			session.setAttribute("departmentname", resultVO.getDepartmentname()); // 직원의 부서
			session.setAttribute("memberposition", resultVO.getMemberposition()); // 직원의 직급
			
			return "redirect:/";
		}
		
		// 사원번호와 비밀번호가 일치하지 않을 때 alert을 띄우고자 페이지 이동
		return "/msg";
	}
	
	// 메인페이지 - GET
	// http://localhost:8088/
	@RequestMapping(value="", method=RequestMethod.GET)
	public String cafeinMain(Model model, ProduceVO vo) throws Exception {
		logger.debug(" mainGET() 호출 ");
		logger.debug("/views/main.jsp 페이지로 이동 ");
			
		model.addAttribute("today", proService.getProduceAmountToday());
		model.addAttribute("thisMonth", proService.getProduceAmountThisMonth());
		model.addAttribute("thisYear", proService.getProduceAmountThisYear());
		model.addAttribute("todayGoal", proService.getProduceAmountTodayGoal());
		model.addAttribute("produceList", proService.getProduceList());
		
		return "/main";
		
	}
	
	// 로그아웃 - GET
	// http://localhost:8088/logout
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutGET(HttpSession session) throws Exception {
		logger.debug(" logoutGET() 호출 ");
		
		// 세션 정보 초기화
		session.invalidate();
		
		return "redirect:/login";
	}
	
	
}
