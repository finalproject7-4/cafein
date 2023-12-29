package com.cafein.controller;

import java.sql.Date;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.SalesVO;
import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;
import com.cafein.service.ShipService;

@Controller
@RequestMapping(value = "/sales/*")
public class ShipController {

	private static final Logger logger = LoggerFactory.getLogger(ShipController.class);

	@Inject
	private ShipService shService;

	// 출하 조회
	// http://localhost:8088/sales/SHList
	@RequestMapping(value = "/SHList", method = RequestMethod.GET)
	public void AllSHListGET(Model model) throws Exception {
		logger.debug("AllSHListGET() 실행");
		
		model.addAttribute("AllSHList", shService.AllSHList());
		model.addAttribute("wcList", shService.registWC()); 
		logger.debug("출하 리스트 출력!");
	}
	
	// 출하 등록 - POST
	// http://localhost:8088/sales/SHList
	@RequestMapping(value = "/registSH", method = RequestMethod.POST)
	public String registSH(ShipVO svo, 
							@RequestParam(value = "shipdate") String shipdate,
							@RequestParam(value = "stockid", defaultValue = "1") int stockid,
							RedirectAttributes rttr) throws Exception {
		
		logger.debug("regist() 호출 ");                                 
		logger.debug(" svo : " + svo);                                               

		svo.setShipdate(Date.valueOf(shipdate));
		svo.setStockid(stockid);	                                         
		
		shService.registSH(svo);                                                      
		logger.debug(" 출하 등록 완료! ");     
         
		rttr.addFlashAttribute("result", "CREATEOK");                                
	                                                                                 
		logger.debug("/sales/registSH 이동");                                          
		return "redirect:/sales/SHList";                                             
	}

	// 작업지시 조회
	// http://localhost:8088/sales/WKList
	@RequestMapping(value = "/WKList", method = RequestMethod.GET)
	public void AllWKListGET(Model model) throws Exception {
		logger.debug("AllWKListGET() 실행");
		model.addAttribute("AllWKList", shService.AllWKList());
		model.addAttribute("pcList", shService.registPC()); 
		logger.debug("작업지시 리스트 출력!");
	}
	
	// 작업지시 등록 - POST
	// http://localhost:8088/sales/WKList
	@RequestMapping(value = "/registWK", method = RequestMethod.POST)
	public String registWK(WorkVO wvo, 
							@RequestParam(value = "pocode") String pocode,
							@RequestParam(value = "itemcode") String itemcode,
							@RequestParam(value = "clientcode") String clientcode,
							
							RedirectAttributes rttr) throws Exception {
		
		logger.debug("registWK() 호출 ");                                 
		logger.debug(" svo : " + wvo);                                               

		wvo.setPocode(pocode);
		wvo.setItemcode(itemcode);
		wvo.setItemcode(clientcode);	                                         
		
		shService.registWK(wvo);                                                      
		logger.debug(" 작업지시 등록 완료! ");     
         
		rttr.addFlashAttribute("result", "CREATEOK");                                
	                                                                                 
		logger.debug("/sales/registWK 이동");                                          
		return "redirect:/sales/WKList";                                             
	}
	
	// 작업 지시 코드 생성 메서드
	public String makeWKcode(WorkVO wvo) throws Exception {
		
		String code = "";
		int num = 1001 + shService.wkCount(wvo);
		
		switch(wvo.getPostate()) {
			case "대기": code = "ST"; break;
			case "진행": code = "PR"; break;
			case "완료": code = "CP"; break;
			case "취소": code = "CC"; break;
		}
		
		return code + num;
	}

	// 실적 조회
	// http://localhost:8088/sales/PFList
	@RequestMapping(value = "/PFList", method = RequestMethod.GET)
	public void AllPFListGET(Model model) throws Exception {
		logger.debug("AllPFListGET() 실행");
		model.addAttribute("AllPFList", shService.AllPFList());
		logger.debug("실적 리스트 출력!");
	}

}