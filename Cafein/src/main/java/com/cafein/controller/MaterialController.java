package com.cafein.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Random;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafein.domain.Criteria;
import com.cafein.domain.OrdersVO;
import com.cafein.domain.PageVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;
import com.cafein.service.ClientService;
import com.cafein.service.ItemService;
import com.cafein.service.MaterialService;

@Controller
@RequestMapping(value = "/material/*")
public class MaterialController {

	private static final Logger logger = LoggerFactory.getLogger(MaterialController.class);

	@Inject
	private MaterialService materService;
	
	@Inject
	private ClientService cService;
	
	@Inject
	private ItemService iService;
	
	// http://localhost:8088/material/orders
	// 발주 목록 - GET
	@RequestMapping(value = "/orders", method = RequestMethod.GET)
	public void ordersList(Model model, OrdersVO vo, Criteria cri) throws Exception {
		logger.debug("ordersList() 호출");
		logger.debug("OrdersVO: " + vo);
		
		// OrdersVO의 Criteria 설정
		vo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(materService.ordersCount(vo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("ordersList", materService.ordersList(vo));
		model.addAttribute("clientList", cService.clientList()); // 공급처 모달
		model.addAttribute("itemList", iService.itemList()); // 품목 모달
		model.addAttribute("pageVO", pageVO);
		
		// 연결된 뷰페이지로 이동
		logger.debug("/views/material/orders.jsp 페이지로 이동");
	}
	
	// 발주 등록 - POST
	@RequestMapping(value = "/orderRegist", method = RequestMethod.POST)
	public String orderRegist(OrdersVO vo) throws Exception {
		logger.debug("orderRegist() 호출");
			
		// 생성한 발주코드 저장
		vo.setOrderscode(generateOrdersCode());
		
		// 서비스
		materService.orderRegist(vo);
		
		return "redirect:/material/orders";
	} // orderRegist() 끝	
	
	// 발주코드 생성 메서드
	public String generateOrdersCode() throws Exception {
		
		String prefix = "OR";
		String datePart = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

		// 발주코드 개수 계산
		int counter = materService.orderscodeCount(datePart) + 1;

		String formattedCounter = String.format("%02d", counter);
		return prefix + datePart + formattedCounter;
	}
	
	// 발주 수정 - POST
	@RequestMapping(value = "/orderModify", method = RequestMethod.POST)
	public String orderModify(OrdersVO vo) throws Exception {
		logger.debug("orderModify() 호출");
		
		// 서비스
		materService.orderModify(vo);
		
		return "redirect:/material/orders";
	}
	
	// 발주 삭제
	@RequestMapping(value = "/orderDelete", method = RequestMethod.POST)
	public String orderDelete(OrdersVO vo) throws Exception {
		logger.debug("orderDelete() 호출");
		
		// 서비스
		materService.orderDelete(vo);
		
		return "redirect:/material/orders";
	}
	
	// http://localhost:8088/material/receive
	// 입고 목록 - GET
	@RequestMapping(value = "/receive", method = RequestMethod.GET)
	public void receiveList(Model model, ReceiveVO vo, Criteria cri) throws Exception {
		logger.debug("receiveList() 호출");

		// ReceiveVO의 Criteria 설정
		vo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(materService.receiveCount(vo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("receiveList", materService.receiveList(vo));
		model.addAttribute("ordersList", materService.ordersList());
		model.addAttribute("storageList", materService.storageList());
		model.addAttribute("pageVO", pageVO);
				
		// 연결된 뷰페이지로 이동
		logger.debug("/views/material/receive.jsp 페이지로 이동");
	}
	
	// 입고 등록 - POST
	@RequestMapping(value = "/receiveRegist", method = RequestMethod.POST)
	public String receiveRegist(ReceiveVO vo) throws Exception {
		logger.debug("receiveRegist() 호출");
		
		// 생성한 입고코드 저장
		vo.setReceivecode(generateReceiveCode());
		
		// 생성한 LOT번호 저장
		vo.setLotnumber(generateLotNumber());
		
		// 서비스
		materService.receiveRegist(vo); // 입고 등록
		
		return "redirect:/material/receive";
	}

	// 입고코드 생성 메서드
	public String generateReceiveCode() throws Exception {
		
		String prefix = "RC";
		String datePart = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

		// 입고코드 개수 계산
		int counter = materService.receivecodeCount(datePart) + 1;

		String formattedCounter = String.format("%02d", counter);
		return prefix + datePart + formattedCounter;
	}
	
	// LOT 번호 생성 메서드
	public String generateLotNumber() throws Exception {
		
        Random random = new Random();

        // 0부터 9999999999까지의 랜덤한 숫자 생성
        long randomNumber = (long) (random.nextDouble() * 10000000000L);

        // 생성된 숫자를 12자리 문자열로 변환
        String formattedNumber = String.format("%012d", randomNumber);

        // 문자열을 원하는 형태로 포맷팅
        String formattedPhoneNumber = formattedNumber.replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");

        return formattedPhoneNumber;
        
	}
	
	// 입고 수정 - POST
	@RequestMapping(value = "/receiveModify", method = RequestMethod.POST)
	public String receiveModify(ReceiveVO vo) throws Exception {
		logger.debug("receiveModify() 호출");
		logger.debug("입고 상태: " + vo.getReceivestate());
		
		// 서비스
		// 입고상태가 대기일 경우 수정만 처리
		if(!vo.getReceivestate().equals("완료")) {
			materService.receiveModify(vo);
		}
		
		// 입고상태가 완료일 경우 수정 후 품질관리로 이동
		if(vo.getReceivestate().equals("완료")) {
			materService.receiveModify(vo);
			materService.moveQuality(vo);
		}
		
		return "redirect:/material/receive";
	}
	
	// 입고 삭제 - POST
	@RequestMapping(value = "/receiveDelete", method = RequestMethod.POST)
	public String receiveDelete(ReceiveVO vo) throws Exception {
		logger.debug("receiveDelete() 호출");
		
		// 서비스
		materService.receiveDelete(vo);
		
		return "redirect:/material/receive";
	}
	
	// 출고 목록 - GET
	@RequestMapping(value = "/releases", method = RequestMethod.GET)
	public void releasesList(Model model, ReleasesVO vo, Criteria cri) throws Exception {
		logger.debug("releasesList() 호출");

		// ReleasesVO의 Criteria 설정
		vo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(materService.releasesCount(vo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("releasesList", materService.releasesList(vo));
		model.addAttribute("pageVO", pageVO);
				
		// 연결된 뷰페이지로 이동
		logger.debug("/views/material/releases.jsp 페이지로 이동");
	}
	
	
}
