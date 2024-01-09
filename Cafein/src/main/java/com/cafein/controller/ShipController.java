package com.cafein.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.Criteria;
import com.cafein.domain.MemberVO;
import com.cafein.domain.PageVO;
import com.cafein.domain.SalesVO;
import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;
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
	public String AllSHListGET(Model model,ShipVO svo, HttpSession session, Criteria cri) throws Exception {
		logger.debug("AllSHListGET() 실행");
		
		// ShoipVO의 Criteria 설정
		svo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(shService.countSH(svo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		model.addAttribute("countSH",shService.countSH(svo));
		model.addAttribute("AllSHList", shService.AllSHList(svo));
		model.addAttribute("wcList", shService.registWC());
		model.addAttribute("mcList", shService.registMC());
		model.addAttribute("pageVO", pageVO);
		
		logger.debug("@@@"+shService.registMC());
		logger.debug("출하 리스트 출력!");
		
		return "/sales/SHList";
	}
	
	// 출하 등록 - POST
	// http://localhost:8088/sales/SHList
	@RequestMapping(value = "/registSH", method = RequestMethod.POST)
	public String registSH(ShipVO svo,
							@RequestParam(value = "shipdate1") String shipdate1,
							RedirectAttributes rttr
							) throws Exception {
		
		logger.debug("regist() 호출 ");                                 
		logger.debug(" svo : " + svo);                                               

		svo.setShipcode(makeSHcode(svo));
		svo.setShipdate1(Date.valueOf(shipdate1));	                                         
		
		shService.registSH(svo);                                                      
		logger.debug(" 출하 등록 완료! ");                              
	                                                                                 
		logger.debug("/sales/registSH 이동");                                          
		return "redirect:/sales/SHList";                                             
	}
	
	// 출하 검색
	@RequestMapping(value = "/SHList", method = RequestMethod.POST)
	@ResponseBody
	public List<ShipVO> searchSHListPOST(@RequestBody Map<String, Object> searchParams) throws Exception {
	    logger.debug("SearchSHListPOST() 실행. 검색 조건: {}", searchParams);
	    List<ShipVO> result = shService.searchSHList(searchParams);
	    logger.debug("출하 검색 결과 출력!");
	    return result;
	}

	// 출하 코드 생성 메서드
	public String makeSHcode(ShipVO svo) throws Exception {
	    // DB에서 전체 작업 수 조회
	    int count = shService.shCount(svo);

	    String codePrefix = "SH";
	    DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyMMdd");
	    String datePart = LocalDate.now().format(dateFormat);
	    String countPart = String.format("%04d", count + 1); // 4자리 숫자로 포맷팅

	    // 최종 코드 생성
	    return codePrefix + datePart + countPart;
	}
	
	// 출하 수정 - POST
		// http://localhost:8088/sales/SHList
		@RequestMapping(value = "/modifySH", method = RequestMethod.POST)
		public String modifyPOST(ShipVO svo) throws Exception {
			logger.debug(" /modify form -> modifyPOST()");
			logger.debug(" 수정할 정보 " + svo);

			// 서비스 - 정보수정 동작
			int result = shService.SHModify(svo);
			logger.debug("result", result);
			return "redirect:/sales/SHList";
		}

		
	//출하상태 완료 변경
		// http://localhost:8088/sales/SHList
		@RequestMapping(value = "/ingUpdate1", method = RequestMethod.POST)
		public String ingUpdate(ShipVO svo, WorkVO wvo, @RequestParam("shipid") int shipid,
				@RequestParam("workcode") String workcode) throws Exception {

			logger.debug("/sales/ingUpdate1() 호출!");
			svo.setShipid(shipid);
			wvo.setWorkcode(workcode);
				
			// 출하 완료 시간 설정
			Date shipDate2 = new Date(System.currentTimeMillis());
		        svo.setShipdate2(shipDate2);
				
			logger.debug("출하상태 변경" + svo.getShipsts());
			logger.debug("@@@@ 출하id " + svo.getShipid());
			shService.ingUpdate(svo);
			logger.debug("출하상태 업데이트 성공!");
				
				

			logger.debug("작업지시상태 업데이트 성공!");

			// 작업지시상태 업데이트
			wvo.setWorkdate1(svo.getShipdate1());
			wvo.setWorkcode(svo.getWorkcode());
			wvo.setClientname(svo.getClientname());
			wvo.setItemname(svo.getItemname());
			wvo.setWorksts(svo.getShipsts());
			wvo.setPocnt(svo.getPocnt());
			wvo.setWorkdate2(svo.getShipdate2());
			wvo.setMembercode(svo.getMembercode());
			
			// 작업지시 완료 시간 설정
			Date workDate2 = new Date(System.currentTimeMillis());
			wvo.setShipdate2(workDate2);
			
			logger.debug("updateCompletWork 메서드 호출 - 작업상태: " + wvo.getWorksts() + ", 작업코드: " + wvo.getWorkcode());
			shService.updateCompletWork(wvo);
			logger.debug("updateCompletWork 메서드 호출 완료!");
			
			
			return "redirect:/sales/SHList";                                             
		}
		
		

		
	// 실적 조회
	// http://localhost:8088/sales/PFList
	@RequestMapping(value = "/PFList", method = RequestMethod.GET)
	public void AllPFListGET(Model model, WorkVO wvo, HttpSession session, Criteria cri) throws Exception {
		logger.debug("AllPFListGET() 실행");
		
		// SalesVO의 Criteria 설정
		wvo.setCri(cri);
				
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(shService.countPF(wvo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		model.addAttribute("AllPFList", shService.AllPFList(wvo));
		model.addAttribute("mcList", shService.registMC());
		model.addAttribute("countPF",shService.countPF(wvo));
		model.addAttribute("pageVO", pageVO);
		logger.debug("실적 리스트 출력!");
	}
	
	// 실적 수정 - POST
	// http://localhost:8088/sales/SHList
	@RequestMapping(value = "/modifyPF", method = RequestMethod.POST)
	public String modifyPFPOST(WorkVO wvo) throws Exception {
		logger.debug(" /modify form -> modifyPOST()");
		logger.debug(" 수정할 정보 " + wvo);

		// 서비스 - 정보수정 동작
		int result = shService.PFModify(wvo);
		logger.debug("result", result);
		return "redirect:/sales/PFList";
	}

}