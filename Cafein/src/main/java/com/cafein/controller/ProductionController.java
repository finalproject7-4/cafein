package com.cafein.controller;

import java.sql.Date;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.BomVO;
import com.cafein.domain.Criteria;
import com.cafein.domain.PageVO;
import com.cafein.domain.ProduceVO;
import com.cafein.service.ProductionService;



@Controller
@RequestMapping(value="/production/*")
public class ProductionController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductionController.class);
	
	@Inject
	private ProductionService pService;
	
	
	// 생산지시 관리 입장 페이지 (AJAX용)
		// http://localhost:8088/production/produceList
		@GetMapping(value = "/produceList")
		public void produceListAllGET(HttpSession session, Model model) throws Exception {
			session.setAttribute("membercode", "admin"); // 정상 처리 시 세션에 저장된 값 사용 (get으로 변경)
			
			
			model.addAttribute("itemList", pService.getBomList());
		}

		// 생산지시 출력용 리스트 (AJAX용)
		//http://localhost:8088/production/produceList3
		@RequestMapping(value="/produceList3", method=RequestMethod.GET)
		public void produceListAJAX(Model model,
				HttpSession session, Criteria cri, ProduceVO vo,
				@RequestParam(value="startDate", defaultValue = "1999-01-01") String startDate,
				@RequestParam(value= "endDate", defaultValue = "2033-12-31") String endDate,
				@RequestParam(value="produceline", defaultValue = "0") String produceline,
				@RequestParam(value="process", defaultValue = "*") String process,
				@RequestParam(value="itemname", defaultValue ="*") String itemname
				) throws Exception {

			logger.debug("컨트롤러 - AJAX produceList3() 호출");
			
			vo.setStartDate(Date.valueOf(startDate));
			vo.setEndDate(Date.valueOf(endDate));
			
			if(!itemname.equals("*")) {
				vo.setItemname(itemname);
			}
			if(!produceline.equals("0")) {
				int produceNo = Integer.parseInt(produceline);
				vo.setProduceline(produceNo);
			}
			if(!process.equals("*")) {
				vo.setProcess(process);
			}

			// 페이징 처리
			vo.setCri(cri);
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(pService.AJAXcountProduceList(vo));
			
			session.setAttribute("viewcntCheck", true);

			model.addAttribute("pageVO", pageVO);
			model.addAttribute("produceList", pService.getProduceListAJAX(vo));
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
		public String bomRegist(BomVO vo, RedirectAttributes rttr) throws Exception{
			logger.debug("/production/bomReg -> bomRegist() 호출!");
			logger.debug("등록 정보는? "+vo);
			
			pService.regBom(vo);
			
			
			return "redirect:/production/produceList";
		}

		
		// 생산 상태 변경 (state) 생산중 or 완료
		@PostMapping(value="/AJAXupdateProduceState")
		public void AJAXupdateProduceState(ProduceVO vo) throws Exception{
			logger.debug("/producetion/updateProduceState() 호출!");
			
			
			logger.debug("생산 상태 업데이트! 업데이트할 값은? "+vo.getState());
			logger.debug("@@@@ 생산 id 는? "+vo.getProduceid());
			
		
			pService.updateProduceState(vo);
		}
		

		// 생산 상태 변경 (state) 생산중 or 완료
		@PostMapping(value="/updateProduceState")
		public String updateProduceState(ProduceVO vo) throws Exception{
			logger.debug("/producetion/updateProduceState() 호출!");
			logger.debug("생산 상태 업데이트! 업데이트할 값은? "+vo);
			logger.debug("@@@@ 생산 id 는? "+vo.getProduceid());
			
			pService.updateProduceState(vo);
			return "redirect:/production/produceList";
		}

}





