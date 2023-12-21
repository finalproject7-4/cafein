package com.cafein.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	public void AllPOListGET(Model model) throws Exception{
		logger.debug("AllSHListGET() 실행");
		model.addAttribute("AllSHList", shService.AllSHList());
		logger.debug("출하 리스트 출력!");
	}
	
	
}