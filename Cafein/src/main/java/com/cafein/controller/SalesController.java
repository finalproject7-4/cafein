package com.cafein.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
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

	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/POList", method = RequestMethod.GET)
	public void purordersGET() {
		logger.debug("purordersGET() 실행");

	}

	@RequestMapping(value = "/POList", method = RequestMethod.POST)
	public String purordersPOST(/* @ModelAttribute */ SalesVO svo) {
		logger.debug("  purordersPOST() 호출 ");
		logger.debug(" svo :" + svo);

		// DB에 정보를 저장 => 서비스 객체 사용
		logger.debug(" 서비스 회원가입 동작을 호출 - 시작");
		sService.purorders(svo);
		logger.debug(" 서비스 회원가입 동작을 호출 - 끝");

		return "redirect:/sales/POList2";
	}
	
	
}
