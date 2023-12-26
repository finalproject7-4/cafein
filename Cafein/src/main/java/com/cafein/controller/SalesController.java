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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.ClientVO;
import com.cafein.domain.SalesVO;
import com.cafein.service.SalesService;

@Controller
@RequestMapping(value = "/sales/*")
public class SalesController {

	private static final Logger logger = LoggerFactory.getLogger(SalesController.class);

	@Inject
	private SalesService sService;
	
	//수주등록 -  GET
	// http://localhost:8088/sales/registPO
	@RequestMapping(value = "/registPO", method = RequestMethod.GET)
	public void registGET() throws Exception {
		logger.debug("/sales/registPO -> registGET() 호출 ");
		logger.debug("/sales/registPO.jsp 뷰페이지로 이동");
	}
	
	@RequestMapping(value = "/registPO", method = RequestMethod.POST)
	public String registPOST(Model model, SalesVO svo, RedirectAttributes rttr) throws Exception {
		logger.debug("폼submit -> registPOST() 호출 ");
		logger.debug(" svo : " + svo);

		sService.registPO(svo);
		logger.debug(" 글작성 완료! ");
		model.addAttribute("POList", sService.AllPOList());
		logger.debug("POList",sService.AllPOList());
		rttr.addFlashAttribute("result", "CREATEOK");

		logger.debug("/sales/registPO 이동");
		return "redirect:/sales/POList";
	}
	
	
	// 수주조회 - GET
	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/POList", method = RequestMethod.GET)
	public String AllPOListGET(Model model, @ModelAttribute("result") String result) throws Exception{
		logger.debug("AllPOListGET() 실행");
		
		List<SalesVO> POList = sService.AllPOList();
		logger.debug(" @@@ " + POList);

		List<ClientVO> cliPick = sService.getAddCliList();
		logger.debug(" @@@ " + cliPick);
		
		model.addAttribute("POList", POList);
		model.addAttribute("result", result);
		return "/sales/POList";
	}
	
}
