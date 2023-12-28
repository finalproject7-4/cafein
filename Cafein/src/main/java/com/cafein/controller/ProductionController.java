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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
				@RequestParam(value="produceline", defaultValue = "0") String produceline,
				@RequestParam(value="process", defaultValue = "*") String process
				) throws Exception {

			logger.debug("컨트롤러 - produceList() 호출");
			
			ProduceVO vo = new ProduceVO();
			logger.debug("시작일자는? "+Date.valueOf(startDate));
			logger.debug("마감일자는? "+Date.valueOf(endDate));
			logger.debug("클릭한 state 상태는? "+state);
			logger.debug("아이템명은? ? "+itemname);
			vo.setStartDate(Date.valueOf(startDate));
			vo.setEndDate(Date.valueOf(endDate));
			if(!itemname.equals("*")) {
			vo.setItemname(itemname);
			}
			if (!qualitycheck.equals("*")) {
		        vo.setQualitycheck(qualitycheck);
		    }
			if (!state.equals("*")) {
				vo.setState(state);
			}
			if(!produceline.equals("0")) {
				int produceNo = Integer.parseInt(produceline);
				vo.setProduceline(produceNo);
			}
			if(!process.equals("*")) {
				vo.setProcess(process);
			}
			
			model.addAttribute("produceList", pService.getProduceList(vo));
			model.addAttribute("itemList", iService.itemList());
			model.addAttribute("bomList", pService.getBomList());
		
			logger.debug("생산지시 목록 출력!");

		}
		
		// 생산지시 등록
		@RequestMapping(value="/produceReg", method=RequestMethod.POST)
		public String produceRegist(ProduceVO vo, RedirectAttributes rttr) throws Exception{
			logger.debug("/production/produceReg -> produceRegist() 호출!");
			
			logger.debug("지시 정보는? "+vo);
			
			pService.regProduce(vo);
			
			return "redirect:/production/produceList";
		}

		
	
	

}
