package com.cafein.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.cafein.domain.QualityVO;
import com.cafein.service.StockService;

@org.springframework.web.bind.annotation.RestController
public class RestController {
	
	@Inject
	private StockService sService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(RestController.class);
	
	@GetMapping(value = "roastedBeanInfo")
	public QualityVO roastedBeanInfo(@ModelAttribute("lotnumber") String lotnumber) throws Exception{
		logger.debug(" roastedBeanInfo() 호출 ");		
		return sService.roastedBeanInfo(lotnumber);
	}
}
