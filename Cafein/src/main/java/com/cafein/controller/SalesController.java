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
//	@RequestMapping(value = "/registPO", method = RequestMethod.GET)
//	public String registGET(Model model) throws Exception {
//		logger.debug("/sales/registPO -> registGET() 호출 ");
//		logger.debug("/sales/registPO.jsp 뷰페이지로 이동");
//		
//		model.addAttribute("cliList", sService.registCli());
//		logger.debug("cliList",sService.registCli());
//
//		model.addAttribute("iList", sService.registItem());
//		logger.debug("iList",sService.registItem());
//		
//		return "sales/registPO";
//	}
//	
//	@RequestMapping(value = "/registPO", method = RequestMethod.POST)
//	public String registPOST(SalesVO svo, RedirectAttributes rttr) throws Exception {
//		logger.debug("폼submit -> registPOST() 호출 ");
//		logger.debug(" svo : " + svo);
//
//		sService.registPO(svo);
//		logger.debug(" 글작성 완료! ");
//		
//		rttr.addFlashAttribute("result", "CREATEOK");
//
//		logger.debug("/sales/registPO 이동");
//		return "redirect:/sales/POList";
//	}
	
	
	// 수주조회 - GET
	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/POList", method = RequestMethod.GET)
	public String AllPOListGET(Model model, @ModelAttribute("result") String result) throws Exception{
		logger.debug("AllPOListGET() 실행");
		
		List<SalesVO> POList = sService.AllPOList();
		logger.debug(" @@@ " + POList);

		model.addAttribute("cliList", sService.registCli()); 
		logger.debug("cliList",sService.registCli());        
		        
		model.addAttribute("iList", sService.registItem());  
		logger.debug("iList",sService.registItem());         
		
		model.addAttribute("POList", POList);
		model.addAttribute("result", result);
		return "/sales/POList";
	}
	
	// 수주조회 - POST
	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/registPO", method = RequestMethod.POST)
	public String registPOST(SalesVO svo, RedirectAttributes rttr) throws Exception {
		logger.debug("폼submit -> registPOST() 호출 ");                                 
		logger.debug(" svo : " + svo);                                               
	                                                                                 
		sService.registPO(svo);                                                      
		logger.debug(" 글작성 완료! ");                                                   
		                                           
		rttr.addFlashAttribute("result", "CREATEOK");                                
	                                                                                 
		logger.debug("/sales/registPO 이동");                                          
		return "redirect:/sales/POList";                                             
	}                                                                                
	
}
