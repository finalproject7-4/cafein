package com.cafein.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.SalesVO;
import com.cafein.service.SalesService;

@Controller
@RequestMapping(value = "/sales/*")
public class SalesController {

	private static final Logger logger = LoggerFactory.getLogger(SalesController.class);

	@Inject
	private SalesService sService;
	
	// 수주조회
	// http://localhost:8088/sales/POList 학원
	@RequestMapping(value = "/POList", method = RequestMethod.GET)
	public void AllPOListGET(Model model) throws Exception{
		logger.debug("AllPOListGET() 실행");
		model.addAttribute("AllPOList", sService.AllPOList());
	}
	/********************************************************************/
	// 수주등록
	// http://localhost:8088/sales/registPO
	@RequestMapping(value = "/registPO", method = RequestMethod.GET)
	public void registPOGET() throws Exception{
		logger.debug("registPOGET() 실행");
		logger.debug("/sales/registPO.jsp 뷰페이지로 이동");
	}
	
	@RequestMapping(value = "/registPO", method = RequestMethod.POST)
	public String registPOPOST(SalesVO svo,RedirectAttributes rttr) throws Exception{
		logger.debug("  registPOPOST() 호출 ");
		logger.debug(" svo :" + svo);
		
		sService.registPO(svo);
		logger.debug("수주 등록 완료");
		rttr.addFlashAttribute("result", "CREATEOK");
		logger.debug("/sales/POList 이동");
		return "redirect:/sales/POList";
	}
	/********************************************************************/
	
	
}
