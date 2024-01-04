package com.cafein.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.SalesVO;
import com.cafein.domain.WorkVO;
import com.cafein.service.ShipService;

@Controller
@RequestMapping(value = "/production/*")
public class WorkController {

	private static final Logger logger = LoggerFactory.getLogger(ShipController.class);

	@Inject
	private ShipService shService;
	
	// 작업지시 조회
	// http://localhost:8088/production/WKList
	@RequestMapping(value = "/WKList", method = RequestMethod.GET)
	public String AllWKListGET(Model model, WorkVO wvo) throws Exception {
		logger.debug("AllWKListGET() 실행");
		
		List<WorkVO> WKList = shService.AllWKList();
		
		model.addAttribute("WKList", WKList );
		
		model.addAttribute("pcList", shService.registPC()); 
		
		logger.debug("작업지시 리스트 출력!");
		
		return "/production/WKList";
	}
	
	
	// 작업지시 등록 - POST
	// http://localhost:8088/production/WKList
	@RequestMapping(value = "/registWK", method = RequestMethod.POST)
	public String registWK(WorkVO wvo,@RequestParam(value = "workdate1") String workdate1) throws Exception {
		
		logger.debug("registWK() 호출 ");                                 
		logger.debug(" wvo : " + wvo);  
		
		wvo.setWorkcode(makeWKcode(wvo));
		wvo.setWorkdate1(Date.valueOf(workdate1));
		
		shService.registWK(wvo);                                                      
		logger.debug(" 작업지시 등록 완료! ");     
                                       
	                                                                                 
		logger.debug("/production/registWK 이동");                                          
		return "redirect:/production/WKList";                                             
	}

	// 작업 지시 코드 생성 메서드
	public String makeWKcode(WorkVO wvo) throws Exception {
	    // DB에서 전체 작업 수 조회
	    int count = shService.wkCount(wvo);

	    // 작업 코드 형식 설정
	    String codePrefix = "WK";
	    DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyMMdd");
	    String datePart = LocalDate.now().format(dateFormat);
	    String countPart = String.format("%04d", count + 1); // 4자리 숫자로 포맷팅

	    // 최종 코드 생성
	    return codePrefix + datePart + countPart;
	}
	
	// 작업지시 수정 - POST
	// http://localhost:8088/production/WKList
	@RequestMapping(value = "/modifyWK", method = RequestMethod.POST)
	public String modifyPOST(WorkVO wvo) throws Exception {
		logger.debug(" /modify form -> modifyPOST()");
		logger.debug(" 수정할 정보 " + wvo);

		// 서비스 - 정보수정 동작
		int result = shService.WKModify(wvo);
		logger.debug("result", result);
		return "redirect:/production/WKList";
	}
	
}