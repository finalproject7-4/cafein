package com.cafein.controller;



import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.BomVO;
import com.cafein.domain.Criteria;
import com.cafein.domain.PageVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.RoastedbeanVO;
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
				HttpSession session, Criteria cri, ProduceVO vo
				) throws Exception {

			logger.debug("컨트롤러 - AJAX produceList3() 호출");
			

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
		/* model.addAttribute("temperList", pService.getRoastingTemper(vo)); */
		
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
			
			// 포장 공정이 아닐 때는 packagevol 용량 0으로 설정
			if(!process.equals("포장")) {
				vo.setPackagevol(0);
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
		@ResponseBody
		@PostMapping(value="/AJAXupdateProduceState")
		public void AJAXupdateProduceState(ProduceVO vo) throws Exception{
			logger.debug("/producetion/updateProduceState() 호출!");
			
			
			logger.debug("생산 상태 업데이트! 업데이트할 값은? "+vo.getState());
			logger.debug("@@@@ 생산 id 는? "+vo.getProduceid());
						
			pService.updateProduceState(vo); 

			
		}
		

		// 포장 완료시 roastedbean에 로스팅완료 제품 insert
		@PostMapping(value="/updateRoastedbeanList")
		public String updateProduceState(RoastedbeanVO vo, ProduceVO pvo, 
				@RequestParam(value="producedate") String producedate) throws Exception{
			logger.debug("/producetion/updateRoastedbeanList() 호출!");
			
			String[] pdateArr = producedate.split("-");
			
		/*
		 * pvo.setProducedate(Date.valueOf(producedate));
		 * pService.updateProduceState(pvo);
		 */
			
			vo.setRoasteddate(pvo.getProducedate());

			int year = Integer.parseInt(pdateArr[0]) ;
			int month = Integer.parseInt(pdateArr[1]);
			int day = Integer.parseInt(pdateArr[2]);
	/*		int year = pvo.getProducedate().getYear();
			int month = pvo.getProducedate().getMonth();
			int day = pvo.getProducedate().getDay();*/
			int line = pvo.getProduceline();
			int time = pvo.getProducetime();
			int i;
		/* int count = pvo.getAmount()/pvo.getPackagevol(); */
			
			for(i=0; i<=9; i++) {
				String lot = generateLotNumber(year, month, day, line, time, i);
				vo.setLotnumber(lot);
				pService.insertRoastedbean(vo);
			}
			return "redirect:/production/produceList";
		}
		
		
		// LOT 번호 생성 메서드
		public static String generateLotNumber(int year, int month, int day, int line, int time, int productNumber) {
	        String[] months = {"AZ", "BY", "CX", "DW", "EV", "FU", "GT", "HS", "IR", "JQ", "KP", "LO"};
	        char[] days = {'A', 'B', 'C', 'D'};
	        
	        // Month code
	        String monthCode = months[month];
	        
	        // Day code
	        int dayCodeIndex = (day) / 10; // Dividing days into ranges (1~9, 10~19, 20~29, 30~31)
	        char dayCode = days[dayCodeIndex];
	        
	        // Line code
	        String lineCode = String.valueOf(line);
	        
	        // Time code
	        String timeCode;
	        if (time == 1) {
	            timeCode = "A1";
	        } else if (time == 2) {
	            timeCode = "A2";
	        } else if (time == 3) {
	            timeCode = "P1";
	        } else {
	            timeCode = "P2";
	        }
	        
	        // Product number code
	        String productNumberCode = String.format("%02d", productNumber);
	        
	        // Creating the lot number
	        return String.format("%d%s%d%s%s", year % 100, monthCode, dayCode, lineCode, timeCode) + productNumberCode;
	    }

	/*
	 * public static void main(String[] args) { // Example usage int year = 2023;
	 * int month = 12; int day = 6; int line = 1; int time = 2; int productNumber =
	 * 10;
	 * 
	 * String lotNumber = generateLotNumber(year, month, day, line, time,
	 * productNumber); System.out.println("Lot Number: " + lotNumber); }
	 */
		
		
		// 생산지시리스트 엑셀파일로 출력
		@RequestMapping(value="/excelPrint", method = RequestMethod.POST)
		public void excelPrint(@ModelAttribute ProduceVO vo,
								HttpServletResponse response,
								HttpServletRequest request) throws Exception{
			logger.debug("엑셀파일 다운로드 시작!!!");
			pService.excelPrint(vo, response);
		}
		
		// 생산공정 업데이트 (블렌딩 -> 로스팅)
		@ResponseBody
		@RequestMapping(value = "/processUpdateRoasting", method = RequestMethod.POST)
		public String updateProcessRoasting(ProduceVO vo) throws Exception{
			logger.debug("생산 공정 업데이트!");

			pService.updateProduceProcessRoasting(vo);

			return "redirect:/production/produceList";
		}
		
		// 생산공정 업데이트 (로스팅 -> 포장)
		@RequestMapping(value = "/processUpdatePackage", method = RequestMethod.POST)
		public String updateProcessPackage(ProduceVO vo) throws Exception{
			logger.debug("생산 공정 업데이트!");
			
			pService.updateProduceProcess(vo);
			
			return "redirect:/production/produceList";
		}
	

}





