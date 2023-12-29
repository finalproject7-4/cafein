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
	public String regist(ShipVO svo, 
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
		logger.debug("작업지시 리스트 출력!");
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