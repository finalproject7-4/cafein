package com.cafein.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.Criteria;
import com.cafein.domain.MemberVO;
import com.cafein.domain.PageVO;
import com.cafein.service.MemberService;

@Controller
@RequestMapping(value = "/information/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService mService;
	
	// 직원 등록 - GET
	// http://localhost:8088/information/memberJoin
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public void memberJoinGET() throws Exception {
		logger.debug(" /members/memberJoin -> memberJoinGET() 호출 ");
		logger.debug(" /views/information/memberJoin.jsp 페이지로 이동 ");
	}
	
	// 직원 등록 - POST
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPOST(MemberVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug(" form submit -> memberJoinPOST() 호출 ");
		
		// 생성한 직원 코드 저장
		vo.setMembercode(generateMembercode(vo));
		logger.debug(" vo : " + vo);
		
		mService.memberJoin(vo);
		logger.debug(" 직원 등록 완료! ");
		
		rttr.addFlashAttribute("result","JOINOK");
		logger.debug(" /information/members 이동 ");
		
		return "redirect:/information/members";
	}
	
	// 직원 코드 생성 메서드
	public Integer generateMembercode(MemberVO vo) throws Exception {
		// 최대 직원 코드 조회
	    int maxMemberCode = mService.maxMemberCode(vo);

	    // 직원 코드가 존재하지 않을 경우 1000부터 시작
	    if (maxMemberCode == 0) {
	        return 1000;
	    }

	    // 직원 코드가 존재할 경우 최대 직원 코드에 +1
	    return maxMemberCode + 1;
	}
	
	// 직원 목록 조회 (페이징) - GET
	// http://localhost:8088/information/members
	@RequestMapping(value = "/members", method = RequestMethod.GET)
	public void memberList(Model model, MemberVO vo, Criteria cri, HttpSession session) throws Exception {
		logger.debug(" memberList() 호출 ");
		logger.debug(" MemberVO : " + vo);
		
		// MemberVO의 Criteria 설정
		vo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(mService.totalMemberCount(vo));
		logger.debug(" 총 개수 : " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("memberList", mService.memberPageList(vo));
		model.addAttribute("pageVO", pageVO);
				
		// 연결된 뷰페이지로 이동
		logger.debug(" /views/information/members.jsp 페이지로 이동 ");
	}
	
	// 직원 수정 - GET
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
	
	// 직원 수정 - POST
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String memberUpdatePOST(MemberVO vo,
								  RedirectAttributes rttr) throws Exception {
		logger.debug(" /information/memberUpdate -> memberUpdatePOST() 호출 ");
		logger.debug(" 수정할 정보 : " + vo);
		
		int result = mService.memberUpdate(vo);
		rttr.addFlashAttribute("result", "UPDATEOK");
		
		return "redirect:/information/members";
	}
	
	// 직원 비활성화 - GET
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
	
	// 직원 비활성화 - POST
	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String memberDeletePOST(MemberVO vo,
								  RedirectAttributes rttr) throws Exception {
		logger.debug(" /information/memberDelete -> memberDeletePOST() 호출 ");
		logger.debug(" 비활성화할 정보 : " + vo);
		
		int result = mService.memberDelete(vo);
		rttr.addFlashAttribute("result", "DELETEOK");
		
		return "redirect:/information/members";
	}
	
}
