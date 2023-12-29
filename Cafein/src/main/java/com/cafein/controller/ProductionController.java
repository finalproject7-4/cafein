package com.cafein.controller;

import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.BomVO;
import com.cafein.domain.Criteria;
import com.cafein.domain.ItemVO;
import com.cafein.domain.PageVO;
import com.cafein.domain.ProduceVO;
import com.cafein.service.ItemService;
import com.cafein.service.ProductionService;

import jdk.nashorn.api.scripting.ScriptUtils;


@Controller
@RequestMapping(value="/production/*")
public class ProductionController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductionController.class);
	
	@Inject
	private ProductionService pService;
	
	
	// 생산지시 관리 페이지 (보류 AJAX용)
		// http://localhost:8088/production/produceListAll
		@GetMapping(value = "/produceListAll")
		public void produceListAllGET(HttpSession session) {
			session.setAttribute("membercode", "admin"); // 정상 처리 시 세션에 저장된 값 사용 (get으로 변경)
			
		}

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
				@RequestParam(value="process", defaultValue = "*") String process,
				HttpSession session, Criteria cri
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
			
			// 페이징 처리
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(pService.getProdueCount());
			
			session.setAttribute("viewcntCheck", true);
			
			vo.setStartPage(cri.getStartPage());
			vo.setPageSize(cri.getPageSize());
			
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("produceList", pService.getProduceList(vo));
			model.addAttribute("itemList", pService.getItemList());
			model.addAttribute("bomList", pService.getBomList());
			model.addAttribute("newItemList", pService.getNewItem());
		
			logger.debug("생산지시 목록 출력!");

		}
		
		
		// 생산지시 등록
		@RequestMapping(value="/produceReg", method=RequestMethod.POST)
		public String produceRegist(ProduceVO vo, RedirectAttributes rttr) throws Exception{
			logger.debug("/production/produceReg -> produceRegist() 호출!");
			
			logger.debug("지시 정보는? "+vo);
			String process = vo.getProcess();
			
			// 로스팅 공정이 아닐때는 온도 0으로 설정
			if(!process.equals("로스팅")) {
				vo.setTemper(0);
			}
	
			pService.regProduce(vo);
			
			return "redirect:/production/produceList";
		}
		
		// BOM 등록
		@RequestMapping(value="/bomReg", method = RequestMethod.POST)
		public String bomRegist(BomVO vo, RedirectAttributes rttr,
				HttpServletResponse response) throws Exception{
			logger.debug("/production/bomReg -> bomRegist() 호출!");
			logger.debug("등록 정보는? "+vo);
			
			pService.regBom(vo);
			
			return "redirect:/production/produceList";
		}



}





