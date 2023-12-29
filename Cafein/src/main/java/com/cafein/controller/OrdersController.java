package com.cafein.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafein.domain.ClientVO;
import com.cafein.domain.ItemVO;
import com.cafein.domain.OrdersVO;
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
	public String ordersGET(Model model) throws Exception {
		logger.debug("/material/orders 호출 -> ordersGET() 호출");
		// 연결된 뷰페이지로 이동
		logger.debug("/views/material/orders.jsp 페이지로 이동");
		
		// 서비스
		logger.debug("(●'◡'●)" + oService.ordersList());
		logger.debug("(●'◡'●)" + cService.clientList());
//		logger.debug("(●'◡'●)" + iService.itemList());
				
		// 데이터를 연결된 뷰페이지로 전달 (Model 객체 필요)
		model.addAttribute("ordersList", oService.ordersList());
		model.addAttribute("clientList", cService.clientList());
//		model.addAttribute("itemList", iService.itemList());
		
		return "/material/orders";
	}
	
	
}
