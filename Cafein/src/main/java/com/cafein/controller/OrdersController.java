package com.cafein.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafein.domain.Criteria;
import com.cafein.domain.ItemVO;
import com.cafein.domain.OrdersVO;
import com.cafein.domain.PageVO;
import com.cafein.service.ClientService;
import com.cafein.service.ItemService;
import com.cafein.service.OrdersService;

@Controller
@RequestMapping(value = "/material/*")
public class OrdersController {

	private static final Logger logger = LoggerFactory.getLogger(OrdersController.class);

	@Inject
	private OrdersService oService;
	
	@Inject
	private ClientService cService;
	
	@Inject
	private ItemService iService;
	
	// http://localhost:8088/material/orders
	@RequestMapping(value = "/orders", method = RequestMethod.GET)
	public void ordersList(Model model, OrdersVO vo, Criteria cri) throws Exception {
		logger.debug("orderList() 호출");
		
		// OrdersVO의 Criteria 설정
		vo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(oService.ordersCount(vo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("ordersList", oService.ordersList(vo));
		model.addAttribute("clientList", cService.clientList());
		model.addAttribute("itemList", iService.itemList());
		model.addAttribute("pageVO", pageVO);
		
		// 연결된 뷰페이지로 이동
		logger.debug("/views/material/orders.jsp 페이지로 이동");
	}
	
	// 발주 등록 - POST
	@RequestMapping(value = "/orderRegist", method = RequestMethod.POST)
	public String orderRegist(OrdersVO vo) throws Exception {
		logger.debug("orderRegist() 호출");
			
		// 생성한 발주코드 저장
//		vo.setOrderscode(generateOrdersCode());
		
		// 서비스
		oService.orderRegist(vo);
		
		return "redirect:/material/orders";
	} // orderRegist() 끝	
	
	// 발주코드 생성 메서드
//	public String generateOrdersCode() {
		
		// 발주코드 개수 계산
//		int counter = oService.ordersCodeCount;

		String prefix = "OR";
		String datePart = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
//		String formattedCounter = String.format("%02d", counter);
//		return prefix + datePart + formattedCounter;
//	}
	
	
}
