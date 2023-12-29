package com.cafein.controller;

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
//		pageVO.setTotalCount(iService.itemCount(vo));
//		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("ordersList", oService.ordersList());
		model.addAttribute("clientList", cService.clientList());
		model.addAttribute("itemList", iService.itemList());
		model.addAttribute("pageVO", pageVO);
		
		// 연결된 뷰페이지로 이동
		logger.debug("/views/material/orders.jsp 페이지로 이동");
	}
	
	
}
