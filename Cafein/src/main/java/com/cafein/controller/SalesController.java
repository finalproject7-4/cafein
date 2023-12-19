package com.cafein.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafein.domain.SalesVO;
import com.cafein.service.SalesService;

@Controller
@RequestMapping(value = "/sales/*")
public class SalesController {

	private static final Logger logger = LoggerFactory.getLogger(SalesController.class);

	@Inject
	private SalesService sService;
	
	// 수주조회
	// http://localhost:8080/sales/POList
	@RequestMapping(value = "/POList", method = RequestMethod.GET)
	public void AllPOListGET(Model model) {
		logger.debug("AllPOListGET() 실행");
		model.addAttribute("AllPOList", sService.AllPOList());
	}
	/********************************************************************/
	// 수주등록
	// http://localhost:8080/sales/regist
	@RequestMapping(value = "/regist", method = RequestMethod.GET)
	public void registPOListGET() {
		logger.debug("registPOListGET() 실행");

	}

	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	public String registPOListPOST(/* @ModelAttribute */ SalesVO svo) {
		logger.debug("  registPOListPOST() 호출 ");
		logger.debug(" svo :" + svo);

		// DB에 정보를 저장 => 서비스 객체 사용
		logger.debug(" 서비스 회원가입 동작을 호출 - 시작");
		sService.registPO(svo);

		return "redirect:/sales/POList2";
	}
	/********************************************************************/
	
	
}
