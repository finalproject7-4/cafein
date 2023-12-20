package com.cafein.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.cafein.service.ProductionService;

@Controller
@RequestMapping(value="/production/*")
public class ProductionController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductionController.class);
	
	@Inject
	private ProductionService pService;
	
	//http://localhost:8088/production/produceList
	@RequestMapping(value="/produceList", method=RequestMethod.GET)
	public void produceListGET(Model model) {
		logger.debug("컨트롤러 - produceListGET() 호출");
				
		model.addAttribute("produceList", pService.getList());
		logger.debug("생산지시 목록 출력!");
	}
	
	

}
