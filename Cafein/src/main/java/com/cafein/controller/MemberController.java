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

import com.cafein.domain.MemberVO;
import com.cafein.service.MemberService;

@Controller
@RequestMapping(value = "/information/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService mService;
	
	// http://localhost:8088/information/memberJoin
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public void memberJoinGET() throws Exception {
		logger.debug(" /members/join -> memberJoinGET() 호출 ");
		logger.debug(" /views/information/memberJoin.jsp 페이지로 이동 ");
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPOST(MemberVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug(" form submit -> memberJoinPOST() 호출 ");
		logger.debug(" vo : " + vo);
		
		mService.memberJoin(vo);
		logger.debug(" 직원 등록 완료! ");
		
		rttr.addFlashAttribute("result","JOINOK");
		logger.debug(" /information/members 이동 ");
		
		return "redirect:/information/members";
	}
	
	// http://localhost:8088/information/members
	@RequestMapping(value = "/members", method = RequestMethod.GET)
	public String memberListGET(Model model) throws Exception {
		logger.debug(" /information/members -> memberListGET() 호출 ");
		
		List<MemberVO> memberList = mService.memberList();
		model.addAttribute("memberList", mService.memberList());
		
		return "/information/members";
	}
	
	// http://localhost:8088/information/memberUpdate
	@RequestMapping(value = "/memberUpdate")
	public void memberUpdateGET() throws Exception {
		logger.debug(" /information/update -> memberUpdateGET() 호출 ");
	}
	
	
	
}































