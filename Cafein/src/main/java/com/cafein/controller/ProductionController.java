package com.cafein.controller;



import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

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
import com.cafein.domain.QualityVO;
import com.cafein.domain.ReleasesVO;
import com.cafein.domain.RoastedbeanVO;
import com.cafein.service.MaterialService;
import com.cafein.service.ProductionService;

@Controller
@RequestMapping(value = "/production/*")
public class ProductionController {

	private static final Logger logger = LoggerFactory.getLogger(ProductionController.class);

	@Inject
	private ProductionService pService;
	
	@Inject
	private MaterialService mateService;

	// 생산지시 관리 입장 페이지 (AJAX용)
	// http://localhost:8088/production/produceList
	@GetMapping(value = "/produceList")
	public void produceListAllGET(HttpSession session, Model model) throws Exception {
		session.setAttribute("membercode", "admin"); // 정상 처리 시 세션에 저장된 값 사용 (get으로 변경)

		model.addAttribute("itemList", pService.getBomList());

	}

	// 생산지시 출력용 리스트 (AJAX용)
	// http://localhost:8088/production/produceList3
	@RequestMapping(value = "/produceList3", method = RequestMethod.GET)
	public void produceListAJAX(Model model, HttpSession session, Criteria cri, ProduceVO vo) throws Exception {

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

		logger.debug("생산지시 목록 출력!");

	}
	

	// 생산지시 등록
	@ResponseBody
	@RequestMapping(value = "/produceReg", method = RequestMethod.POST)
	public String produceRegist(ProduceVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug("/production/produceReg -> produceRegist() 호출!");

		logger.debug("지시 정보는? " + vo);
		String process = vo.getProcess();
		
		logger.debug("검색 아이템명은? "+vo.getItemname());
			// 로스팅 공정이 아닐때는 온도 0으로 설정
		if (!process.equals("로스팅")) {
			vo.setTemper(0);
		}

		// 포장 공정이 아닐 때는 packagevol 용량 0으로 설정
		if (!process.equals("포장")) {
			vo.setPackagevol(0);
		}
		vo.setProducecode(generateProduceCode());
		pService.regProduce(vo);
		
		logger.debug("생산 아이디 만들어졌나요?!"+ vo.getProducecode()); 
		
		// 총 생산량 / 비율로 실제 재고에서 차감할 수량 계산
		String[] rrate = vo.getRate().split(":");
		ReleasesVO rvo = new ReleasesVO();
		
	
		int rate1;
		int rate2;
		int rate3;
				logger.debug("생산일은?! "+vo.getProducedate());
		if(vo.getStockid1() !=null) {
			rvo.setProducecode(vo.getProducecode());
			rvo.setMembercode(vo.getMembercode());
			rvo.setReleasedate(vo.getProducedate());
			rvo.setItemid(vo.getItemid1());
			rate1 = Integer.parseInt(rrate[0]);
			int usingAmount = (vo.getAmount()/10000)*rate1;
			rvo.setReleasecode(generateReceiveCode());
			rvo.setReleasequantity(usingAmount);
			rvo.setStockid(vo.getStockid1());
			pService.insertReleasesList(rvo);			
		}
		
		if(vo.getStockid2() != null) {
			rvo.setProducecode(vo.getProducecode());
			rvo.setMembercode(vo.getMembercode());
			rvo.setReleasedate(vo.getProducedate());
			rvo.setItemid(vo.getItemid2());
			rate2 = Integer.parseInt(rrate[1]);
			int usingAmount2 = (vo.getAmount()/10000)*rate2;
			rvo.setReleasequantity(usingAmount2);
			rvo.setReleasecode(generateReceiveCode());
			rvo.setStockid(vo.getStockid2());
			pService.insertReleasesList(rvo);			
	
		}
			
		
		if(vo.getStockid3() != null) {
			rvo.setProducecode(vo.getProducecode());
			rvo.setMembercode(vo.getMembercode());
			rvo.setReleasedate(vo.getProducedate());
			rvo.setItemid(vo.getItemid3());
			rate3 = Integer.parseInt(rrate[2]);
			int usingAmount3 = (vo.getAmount()/10000)*rate3;
			rvo.setReleasequantity(usingAmount3);
			rvo.setReleasecode(generateReceiveCode());
			rvo.setStockid(vo.getStockid3());
			pService.insertReleasesList(rvo);			
		}
		
		return "redirect:/production/produceList";
	}
	
	
	 
	 // 생산코드 생성 메서드
	   public String generateProduceCode() throws Exception {
		   
		   String prefix = "PRO";
		   LocalDateTime now = LocalDateTime.now();
	        String datePart = now.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
		   
		   return prefix + datePart ;
	   }
	
	  // 출고코드 생성 메서드
	   public String generateReceiveCode() throws Exception {
	      
	      String prefix = "RL";
	      String datePart = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

	      // 출고코드 개수 계산
	      int counter = mateService.releasecodeCount(datePart) + 1;

	      String formattedCounter = String.format("%02d", counter);
	      return prefix + datePart + formattedCounter;
	   }
	

	// BOM 등록
	@RequestMapping(value = "/bomReg", method = RequestMethod.POST)
	public String bomRegist(BomVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug("/production/bomReg -> bomRegist() 호출!");
		logger.debug("등록 정보는? " + vo);

		pService.regBom(vo);

		return "redirect:/production/produceList";
	}

	// 블렌딩+대기+검사전인 생산 상태를 (state) 생산중으로 변경! 블렌딩일때만 실행!(품질 테이블에 데이터 삽입됨)
	@ResponseBody
	@PostMapping(value = "/BupdateProduceState")
	public void BupdateProduceState(ProduceVO vo, QualityVO qvo) throws Exception {
		logger.debug("/producetion/updateProduceState() 호출!");

		logger.debug("생산 상태 업데이트! 업데이트할 값은? " + vo.getState());
		logger.debug("@@@@ 생산 id 는? " + vo.getProduceid());
		logger.debug("생산코드는? "+vo.getProducecode());
		
		// 생산 상태 업데이트
		pService.updateProduceState(vo);
		
		
		// 품질리스트 insert
		qvo.setProduceid(vo.getProduceid());
		qvo.setItemid(vo.getItemid());
		qvo.setProductquantity(vo.getAmount());
		pService.regQualityList(qvo);
				
				
		// 출고리스트 상태 업데이트
		pService.updateCompletRelease(vo);
		
		// 재고리스트 업데이트
		if (vo.getStockid1() != null) {
		    vo.setStockid(vo.getStockid1());
		    pService.updateStockList(vo);
			}
			
		if(vo.getStockid2() != null) {
			vo.setStockid(vo.getStockid2());
			pService.updateStockList(vo);
			}
		if(vo.getStockid3() != null) {
			vo.setStockid(vo.getStockid3());
			pService.updateStockList(vo);
			}
		
		
		
		
	}
	
	// 품질 데이터 추가 삽입 필요없는 생산 상태 변경 (state) 생산중 or 완료
	@ResponseBody
	@PostMapping(value = "/AJAXupdateProduceState")
	public void AJAXupdateProduceState(ProduceVO vo) throws Exception {
		logger.debug("/producetion/updateProduceState() 호출!");
		
		logger.debug("생산 상태 업데이트! 업데이트할 값은? " + vo.getState());
		logger.debug("@@@@ 생산 id 는? " + vo.getProduceid());
		
		pService.updateProduceState(vo);
	}

	// 포장 완료시 roastedbean에 로스팅완료 제품 insert
	@ResponseBody
	@PostMapping(value = "/updateRoastedbeanList")
	public String updateProduceState(/* @RequestBody */ RoastedbeanVO vo, ProduceVO pvo, 
			@RequestParam("roasteddate") String roastedate
			) throws Exception {
		logger.debug("/producetion/updateRoastedbeanList() 호출!");

		pService.updateProduceState(pvo);
		
		String[] rdate = roastedate.split("-");

		
		System.out.println("받은 날짜는? "+roastedate);
		int year = Integer.parseInt(rdate[0]);
		int month = Integer.parseInt(rdate[1]);
		int day = Integer.parseInt(rdate[2]);
		System.out.println("쪼갠 날짜 값은? "+year+", "+month+", "+day);
		int line = pvo.getProduceline();
		int time = pvo.getProducetime();
		int weight = vo.getWeight();
		int amount = pvo.getAmount();
		int count = amount / weight;
		System.out.println("포장무게?"+ weight);
		System.out.println("총 지시?"+ amount);
		

		
		int i;

		
		for (i = 1; i <= count; i++) {
			String lot = generateLotNumber(year, month, day, line, time, i);
			vo.setLotnumber(lot);
			System.out.println("로뜨번호는? "+lot);
			pService.insertRoastedbean(vo);
		}
		return "production/produceList";
	}

	// LOT 번호 생성 메서드
	public static String generateLotNumber(int year, int month, int day, int line, int time, int productNumber) {
		String[] months = { "AZ", "BY", "CX", "DW", "EV", "FU", "GT", "HS", "IR", "JQ", "KP", "LO" };
		char[] days = { 'A', 'B', 'C', 'D' };

		// 생산월 code
		String monthCode = months[month-1];

		// 생산일 code
		int dayCodeIndex = ((day) / 10); // 날짜 나누기 (1~9, 10~19, 20~29, 30~31)
		int dayDate = (day)%10; // 생산일의 1단위 구하기
		String dayNum = String.valueOf(dayDate); // 문자열로 변환
		String dayCode = days[dayCodeIndex]+dayNum;

		// 생산라인 code
		String lineCode = String.valueOf(line);

		// 생산타임 code
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

		// 제품번호 code
		 String productNumberCode = String.format("%02d", productNumber);
		
		// lot번호 조합 생성
		return String.format("%s%s%s%d%s",lineCode, dayCode, monthCode, year % 100, timeCode)+productNumberCode;
	}
	

	// 생산지시리스트 엑셀파일로 출력
	@RequestMapping(value = "/excelPrint", method = RequestMethod.POST)
	public void excelPrint(@ModelAttribute ProduceVO vo, HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		logger.debug("엑셀파일 다운로드 시작!!!");
		pService.excelPrint(vo, response);
	}

	// 생산공정 업데이트 (블렌딩 -> 로스팅)
	@ResponseBody
	@RequestMapping(value = "/processUpdateRoasting", method = RequestMethod.POST)
	public String updateProcessRoasting(ProduceVO vo, QualityVO qvo) throws Exception {
		logger.debug("생산 공정 로스팅으로 업데이트!");

		int temper = pService.getRoastingTemper(vo);
		vo.setTemper(temper);
		pService.updateProduceProcessRoasting(vo);
		
		// 품질테이블에 로스팅공정 추가
		qvo.setProduceid(vo.getProduceid());
		qvo.setItemid(vo.getItemid());
		qvo.setProductquantity(vo.getAmount());
		pService.regRoastingQualityList(qvo);

		return "redirect:/production/produceList";
	}

	// 생산공정 업데이트 (로스팅 -> 포장)
	@RequestMapping(value = "/processUpdatePackage", method = RequestMethod.POST)
	public String updateProcessPackage(ProduceVO vo, QualityVO qvo) throws Exception {
		logger.debug("생산 공정 포장으로 업데이트!");

		pService.updateProduceProcess(vo);
		
		// 품질테이블에 포장공정 추가
		qvo.setProduceid(vo.getProduceid());
		qvo.setItemid(vo.getItemid());
		qvo.setProductquantity(vo.getAmount());
		pService.regPackingQualityList(qvo);

		return "redirect:/production/produceList";
	}
	
	// 생산지시 삭제(블렌딩, 대기중, 검사전 일때만)
	@RequestMapping(value = "/deletePlan", method = RequestMethod.POST)
	public String deleteProducePlan(ProduceVO vo) throws Exception{
		logger.debug("블렌딩 작업 지시 삭제!");
		
		pService.deleteProducePlan(vo);
		
		return "redirect: /production/produceList";
	}
	
	
	
	// 완제품 관리 리스트 Lot 리스트 출력 입장 컨트롤러
	// http://localhost:8088/production/roastedList
	@GetMapping(value = "/roastedList")
	public void roastedBeanList(HttpSession session, Model model) throws Exception {
		session.setAttribute("membercode", "admin"); // 정상 처리 시 세션에 저장된 값 사용 (get으로 변경)

		

	}

	
	// 완제품 리스트 목록 출력(AJAX로 호출)
	@RequestMapping(value="/roastedDetail", method =RequestMethod.GET )
	public void roastedBeanDetail(Model model, RoastedbeanVO vo, Criteria cri, HttpSession session) throws Exception{
		
		logger.debug("로스팅 제품 목록 조회!");
		logger.debug("cri : "+cri);
		logger.debug("RoastedbeanVO : "+vo);
			
		
				// 페이징 처리
				vo.setCri(cri);
				PageVO pageVO = new PageVO();
				pageVO.setCri(cri);
				pageVO.setTotalCount(pService.countRoastedbean(vo));
				session.setAttribute("viewcntCheck", true);
				model.addAttribute("pageVO", pageVO);
				
		
				// 로스팅 완제품 목록 전달
				model.addAttribute("roastedList", pService.getRoastedList(vo));
				
				
	}
	
	
	
	// 메인페이지
	// http://localhost:8088/production/main
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public void cafeinMain(Model model, ProduceVO vo) throws Exception {
		logger.debug("컨트롤러 - 메인페이지 호출!");
			
		model.addAttribute("today", pService.getProduceAmountToday());
		model.addAttribute("thisMonth", pService.getProduceAmountThisMonth());
		model.addAttribute("thisYear", pService.getProduceAmountThisYear());
		model.addAttribute("produceList", pService.getProduceList());
		
		
	}
	
	

}
