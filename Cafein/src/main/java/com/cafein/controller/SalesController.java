package com.cafein.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	public void AllPOListGET(Model model) throws Exception{
		logger.debug("AllPOListGET() 실행");
		model.addAttribute("AllPOList", sService.AllPOList());
	}
	
	
	
}
