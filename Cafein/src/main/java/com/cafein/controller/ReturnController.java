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

import com.cafein.domain.ReturnVO;
import com.cafein.service.ReturnService;

@Controller
@RequestMapping(value = "/quality/*")
public class ReturnController {

	private static final Logger logger = LoggerFactory.getLogger(ReturnController.class);

	@Inject
	private ReturnService rService;

	// http://localhost:8088/quality/returns
	@RequestMapping(value = "/returns", method = RequestMethod.GET)
	public void returnsGET(Model model, ReturnVO returnVO) throws Exception {

		logger.debug("returnsGET() 호출");

		if (returnVO.getReturncode() != null || returnVO.getReturndate() != null || returnVO.getReturntype() != null) {
			// 검색결과

			List<ReturnVO> returnList = rService.searchReturnsByCondition(returnVO);
			model.addAttribute("returnList", returnList);
		}

		else {
			// 전체결과

			List<ReturnVO> returnList = rService.searchReturns();
			model.addAttribute("returnList", returnList);
		}
	}

	
	
	  @PostMapping(value = "/returnRegist") 
	  public String returnRegistPOST(ReturnVO vo) throws Exception{
	  
		  logger.debug("returnRegistPOST() 호출"); 
		  logger.debug("returnVO : "+vo);
		  
		  // 반품 코드 저장
		  vo.setReturncode(generateReturnCode(vo));
		  
		 rService.returnRegist(vo); 
		  
		  
		  return "redirect:/quality/returns"; 
	  }
		 
	 

	// 반품코드 생성 메서드
	private String generateReturnCode(ReturnVO vo) throws Exception {

		// 반품 유형에 따른 코드
		String typeCode = "";

		switch (vo.getReturntype()) {
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
		switch (vo.getReturnReason()) {
		case "제품불량":
			reasonCode = "01";
			break;
		case "주문오류":
			reasonCode = "02";
			break;
		// 다른 사유가 추가될 경우에도 처리 가능
		}

		// 품목별 개수 + 100
		int num = 100 + rService.returnCount(vo);

		// 3개를 합친 코드
		return typeCode + reasonCode + num;
	}

}