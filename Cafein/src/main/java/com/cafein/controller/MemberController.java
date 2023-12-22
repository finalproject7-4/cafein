package com.cafein.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.ClientVO;
import com.cafein.domain.MemberVO;
import com.cafein.service.CleintService;
import com.cafein.service.MemberService;

@Controller
@RequestMapping(value = "/members/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService mService;
	
	// http://localhost:8088/members/join
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void memberJoinGET() throws Exception {
		logger.debug(" /members/join -> memberJoinGET() 호출 ");
		logger.debug(" /views/information/memberJoin.jsp 페이지로 이동 ");
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String memberJoinPOST(MemberVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug(" form submit -> memberJoinPOST() 호출 ");
		logger.debug(" vo : " + vo);
		
		mService.memberJoin(vo);
		logger.debug(" 직원 등록 완료! ");
		
		rttr.addFlashAttribute("result","JOINOK");
		logger.debug(" /members/listAll 이동 ");
		
		return "redirect:/members/listAll";
	}
	
	// http://localhost:8088/members/listAll
	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
	public String listAllGET(Model model) throws Exception {
		logger.debug(" /members/listAll -> listAllGET() 호출 ");
		
		List<MemberVO> memberList = mService.memberListAll();
		model.addAttribute("memberList",mService.memberListAll());
		
		return "/members/listAll";
	}
	
	// http://localhost:8088/members/update
	@RequestMapping(value = "/update")
	public void memberUpdateGET() throws Exception {
		logger.debug(" /members/update -> memberUpdateGET() 호출 ");
	}
	
	
	
}































