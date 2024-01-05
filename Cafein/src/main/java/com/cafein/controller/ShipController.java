package com.cafein.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.ItemVO;
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
		model.addAttribute("stList", shService.registST()); 
		logger.debug("출하 리스트 출력!");
	}
	
	// 출하 등록 - POST
	// http://localhost:8088/sales/SHList
	@RequestMapping(value = "/registSH", method = RequestMethod.POST)
	public String registSH(ShipVO svo,
							@RequestParam(value = "shipdate1") String shipdate1
							) throws Exception {
		
		logger.debug("regist() 호출 ");                                 
		logger.debug(" svo : " + svo);                                               

		svo.setShipcode(makeSHcode(svo));
		svo.setShipdate1(Date.valueOf(shipdate1));	                                         
		
		shService.registSH(svo);                                                      
		logger.debug(" 출하 등록 완료! ");                              
	                                                                                 
		logger.debug("/sales/registSH 이동");                                          
		return "redirect:/sales/SHList";                                             
	}

	// 작업 지시 코드 생성 메서드
	public String makeSHcode(ShipVO svo) throws Exception {
	    // DB에서 전체 작업 수 조회
	    int count = shService.shCount(svo);

	    // 작업 코드 형식 설정
	    String codePrefix = "SH";
	    DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyMMdd");
	    String datePart = LocalDate.now().format(dateFormat);
	    String countPart = String.format("%04d", count + 1); // 4자리 숫자로 포맷팅

	    // 최종 코드 생성
	    return codePrefix + datePart + countPart;
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