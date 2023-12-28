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

import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.service.ItemService;
import com.cafein.service.ProductionService;


@Controller
@RequestMapping(value="/production/*")
public class ProductionController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductionController.class);
	
	@Inject
	private ProductionService pService;
	
	@Inject
	private ItemService iService;
	
		// 생산지시 리스트
		//http://localhost:8088/production/produceList
		@RequestMapping(value="/produceList", method=RequestMethod.GET)
		public void produceList(Model model,
				@RequestParam(value="startDate", defaultValue = "1999-01-01") String startDate,
				@RequestParam(value= "endDate", defaultValue = "2033-12-31") String endDate,
				@RequestParam(value="itemname", defaultValue ="*") String itemname,
				@RequestParam(value = "state", defaultValue = "*") String state,
				@RequestParam(value="qualitycheck", defaultValue = "*") String qualitycheck,
				ProduceVO vo, ItemVO Ivo) throws Exception {

			logger.debug("컨트롤러 - produceList() 호출");

			logger.debug("시작일자는? "+Date.valueOf(startDate));
			logger.debug("마감일자는? "+Date.valueOf(endDate));
			logger.debug("클릭한 state 상태는? "+state);
			vo.setStartDate(Date.valueOf(startDate));
			vo.setEndDate(Date.valueOf(endDate));
			
			model.addAttribute("produceList", pService.getProduceList(vo));
			model.addAttribute("itemList", iService.itemList());
			logger.debug("생산지시 목록 출력!");

		}
		

		
	
	

}
