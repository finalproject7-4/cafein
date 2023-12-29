package com.cafein.controller;

import java.sql.Date;
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

import com.cafein.domain.SalesVO;
import com.cafein.service.SalesService;

@Controller
@RequestMapping(value = "/sales/*")
public class SalesController {

	private static final Logger logger = LoggerFactory.getLogger(SalesController.class);

	@Inject
	private SalesService sService;

	// 수주조회 - GET
	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/POList", method = RequestMethod.GET)
	public String AllPOListGET(Model model, @ModelAttribute("result") String result) throws Exception{
		logger.debug("AllPOListGET() 실행");
		
		List<SalesVO> POList = sService.AllPOList();
		logger.debug(" @@@ " + POList);

		model.addAttribute("POList", POList);
		model.addAttribute("result", result);
		model.addAttribute("cliList", sService.registCli()); 
		model.addAttribute("iList", sService.registItem());  

		logger.debug("cliList",sService.registCli());        
		logger.debug("iList",sService.registItem());         
		
		return "/sales/POList";
	}
		
	// 수주등록 - POST
	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/registPO", method = RequestMethod.POST)
	public String registPOST(SalesVO svo, 
							@RequestParam(value = "ordersdate") String ordersdate,
							@RequestParam(value = "ordersduedate") String ordersduedate,
							@RequestParam(value = "clientid", defaultValue = "1") int clientid,
							@RequestParam(value = "itemid", defaultValue = "1") int itemid,
							RedirectAttributes rttr) throws Exception {
		
		logger.debug("폼submit -> registPOST() 호출 ");                                 
		logger.debug(" svo : " + svo);                                               

		svo.setOrdersdate(Date.valueOf(ordersdate));
		svo.setOrdersduedate(Date.valueOf(ordersduedate));
		svo.setClientid(clientid);	                                         
		svo.setItemid(itemid);
		svo.setPocode(makePOcode(svo));
		
		sService.registPO(svo);                                                      
		logger.debug(" 글작성 완료! ");     
         
		rttr.addFlashAttribute("result", "CREATEOK");                                
	                                                                                 
		logger.debug("/sales/registPO 이동");                                          
		return "redirect:/sales/POList";                                             
	}        
	
	// 품목코드 생성 메서드
	public String makePOcode(SalesVO svo) throws Exception {
		
		String code = "";
		int num = 1001 + sService.poCount(svo);
		
		switch(svo.getPostate()) {
			case "대기": code = "AL"; break;
			case "진행": code = "SK"; break;
			case "완료": code = "FJ"; break;
			case "취소": code = "GH"; break;
		}
		
		return code + num;
	}
	
	// 수주 수정 - POST
	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/modifyPO", method = RequestMethod.POST)
	public String modifyPOST(SalesVO svo, RedirectAttributes rttr,
			@RequestParam(value = "updatedate") String updatedate,
			@RequestParam(value = "poid", defaultValue = "1") int poid,
			@RequestParam(value = "itemid", defaultValue = "1") int itemid
			) throws Exception {
		logger.debug(" /modify form -> modifyPOST()");
		logger.debug(" 수정할 정보 " + svo);
		
		svo.setItemid(itemid);
		svo.setPoid(poid);
		svo.setUpdatedate(Date.valueOf(updatedate));


		// 서비스 - 정보수정 동작
		int result = sService.POModify(svo);
		rttr.addFlashAttribute("result", "modifyOK");
		logger.debug("result", result);
		return "redirect:/sales/POList";
	}
	
}
