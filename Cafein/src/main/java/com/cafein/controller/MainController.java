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
@RequestMapping(value = "/main/*")
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Inject
	private MainService mainService;
	
	@Inject
	private ProductionService proService;
	
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
	
	// 메인페이지
		// http://localhost:8088/main/main
		@RequestMapping(value="/main", method=RequestMethod.GET)
		public void cafeinMain(Model model, ProduceVO vo) throws Exception {
			logger.debug("컨트롤러 - 메인페이지 호출!");
				
			model.addAttribute("today", proService.getProduceAmountToday());
			model.addAttribute("thisMonth", proService.getProduceAmountThisMonth());
			model.addAttribute("thisYear", proService.getProduceAmountThisYear());
			model.addAttribute("thisWeek", proService.getProduceAmountThisWeek());
			model.addAttribute("produceList", proService.getProduceList());
			
			
		}
	
	
}
