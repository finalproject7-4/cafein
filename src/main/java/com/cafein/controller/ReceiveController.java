package com.cafein.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafein.domain.ItemVO;
import com.cafein.domain.OrdersVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.service.ItemService;
import com.cafein.service.OrdersService;
import com.cafein.service.ReceiveService;

@Controller
@RequestMapping(value = "/material/*")
public class ReceiveController {

	private static final Logger logger = LoggerFactory.getLogger(ReceiveController.class);

	@Inject
	private ReceiveService rvService;
	
	// http://localhost:8088/material/receive
	@RequestMapping(value = "/receive", method = RequestMethod.GET)
	public String receiveGET(Model model) throws Exception {
		logger.debug("/material/receive 호출 -> receiveGET() 호출");
		// 연결된 뷰페이지로 이동
		logger.debug("/views/material/receive.jsp 페이지로 이동");
		
		// 서비스 - DB에 저장된 글을 가져오기
		List<ReceiveVO> receiveList = rvService.receiveList();
		logger.debug("(●'◡'●)" + receiveList);
				
		// 데이터를 연결된 뷰페이지로 전달 (Model 객체 필요)
		model.addAttribute("receiveList", receiveList);
		
		return "/material/receive";
	}
	
	
}
