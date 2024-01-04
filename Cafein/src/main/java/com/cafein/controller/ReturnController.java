package com.cafein.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.ReturnVO;
import com.cafein.service.ItemService;
import com.cafein.service.ReturnService;

@Controller
@RequestMapping(value = "/quality/*")
public class ReturnController {

	private static final Logger logger = LoggerFactory.getLogger(ReturnController.class);

	@Inject
	private ReturnService rService;
	
	@Inject
	private ItemService iService;
	
	// 반품 목록
	// http://localhost:8088/quality/returns
	@RequestMapping(value = "/returns", method = RequestMethod.GET)
	public void returnsGET(Model model, ReturnVO rvo, ProduceVO pro, ItemVO ivo) throws Exception {

		logger.debug("returnsGET() 호출");
		
		// 완제품 목록
		model.addAttribute("prList", rService.prList());
		
		// 원자재,부자재 목록
		model.addAttribute("itList", rService.itList());

		
		if (rvo.getReturncode() != null || rvo.getReturndate() != null || rvo.getReturntype() != null) {
			// 검색결과

			List<ReturnVO> returnList = rService.searchReturnsByCondition(rvo);
			model.addAttribute("returnList", returnList);
		}

		else {
			// 전체결과
			List<ReturnVO> returnList = rService.searchReturns();
			model.addAttribute("returnList", returnList);
		}
	}

	
	
	  // 반품 등록
	  @PostMapping(value = "/returnRegist") 
	  public String returnRegistPOST(ReturnVO rvo,  Model model) throws Exception{
	  
		  logger.debug("returnRegistPOST() 호출"); 
		  logger.debug("returnVO : "+rvo);
		  
		  // 반품 코드 저장
		  rvo.setReturncode(generateReturnCode(rvo));
		  
		  // 등록시 기본 설정
		  rvo.setReturnstatus("대기중");
		  rvo.setReprocessmethod("검수중");
		  
		 rService.returnRegist(rvo); 
		  
		  
		  return "redirect:/quality/returns"; 
	  }
	  
	  

	// 반품코드 생성 메서드
	private String generateReturnCode(ReturnVO rvo) throws Exception {

		// 반품 유형에 따른 코드
		String typeCode = "";

		switch (rvo.getReturntype()) {
		case "원자재":
			typeCode = "MOT";
			break;
		case "부자재":
			typeCode = "SAT";
			break;
		case "완제품":
			typeCode = "PRO";
			break;
		// 다른 품목이 추가될 경우에도 처리 가능
		}

		// 반품 사유에 따른 코드
		String reasonCode = "";
		switch (rvo.getReturnReason()) {
		case "제품불량":
			reasonCode = "01";
			break;
		case "주문오류":
			reasonCode = "02";
			break;
		// 다른 사유가 추가될 경우에도 처리 가능
		}

		// 품목별 개수 + 100
		int num = 100 + rService.returnCount(rvo);

		// 3개를 합친 코드
		return typeCode + reasonCode + num;
	}

	
	
	//반품 수정
	@PostMapping(value = "/returnModify")
	public String returnModify(ReturnVO rvo) throws Exception{
		
		logger.debug("returnModify(ReturnVO rvo) 호출"); 
		logger.debug("returnVO : "+rvo);
		
		
		// 수정 서비스
	     rService.returnModify(rvo);
		logger.debug("result",rvo);
		
		
		return "redirect:/quality/returns"; 
	}
	
	
}