package com.cafein.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
		logger.debug(" /members/memberJoin -> memberJoinGET() 호출 ");
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
	
	// http://localhost:8088/information/memberUpdate?memberid=7
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public void memberUpdateGET(@ModelAttribute("memberid") int memberid, Model model) throws Exception {
		logger.debug(" /information/memberUpdate -> memberUpdateGET() 호출 ");
		logger.debug(" 수정할 직원 번호 : " + memberid);
		
		// 기존의 직원 정보를 가져와서 화면에 출력
		MemberVO resultVO = mService.memberInfo(memberid);
		// 직원 정보를 Model 객체에 저장해서 전달
		model.addAttribute("resultVO", resultVO);
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String memberUpdatePOST(MemberVO vo,
								  RedirectAttributes rttr) throws Exception {
		logger.debug(" /information/memberUpdate -> memberUpdatePOST() 호출 ");
		logger.debug(" 수정할 정보 : " + vo);
		
		int result = mService.memberUpdate(vo);
		rttr.addFlashAttribute("result", "updateOK");
		
		return "redirect:/information/members";
	}
	
	// http://localhost:8088/information/memberDelete?memberid=7
	@RequestMapping(value = "/memberDelete", method = RequestMethod.GET)
	public void memberDeleteGET(@ModelAttribute("memberid") int memberid, Model model) throws Exception {
		logger.debug(" /information/memberDelete -> memberDeleteGET() 호출 ");
		logger.debug(" 비활성화할 직원 번호 : " + memberid);
		
		// 기존의 직원 정보를 가져와서 화면에 출력
		MemberVO resultVO = mService.memberInfo(memberid);
		// 직원 정보를 Model 객체에 저장해서 전달
		model.addAttribute("resultVO", resultVO);
	}
	
	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String memberDeletePOST(MemberVO vo,
								  RedirectAttributes rttr) throws Exception {
		logger.debug(" /information/memberDelete -> memberDeletePOST() 호출 ");
		logger.debug(" 비활성화할 정보 : " + vo);
		
		int result = mService.memberDelete(vo);
		rttr.addFlashAttribute("result", "deleteOK");
		
		return "redirect:/information/members";
	}
	
	
	
}































