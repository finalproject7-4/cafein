package com.cafein.controller;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
    public void returnsGET(Model model,
    		@RequestParam(value="startDate", defaultValue = "1999-01-01") String startDate,
			@RequestParam(value= "endDate", defaultValue = "2033-12-31") String endDate,
			ReturnVO returnVO) throws Exception{
    	
    		logger.debug("returnsGET() 호출");
    		
    		returnVO.setStartDate(Date.valueOf(startDate));
    		returnVO.setEndDate(Date.valueOf(endDate));
			
    	if(returnVO.getReturncode() != null || returnVO.getReturndate() != null || returnVO.getReturntype() != null){
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
    
    
    
    
}