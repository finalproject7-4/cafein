package com.cafein.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.ClientVO;
import com.cafein.service.CleintService;

@Controller
@RequestMapping(value = "information/clients/*")
public class ClientController {
	
	private static final Logger logger = LoggerFactory.getLogger(ClientController.class);
	
	@Inject
	private CleintService cService;
	
	// http://localhost:8088/information/clients/join
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void clientJoinGET() throws Exception {
		logger.debug(" /clients/join -> clientJoinGET() 호출 ");
		logger.debug(" /views/information/clientJoin.jsp 페이지로 이동 ");
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String clientJoinPOST(ClientVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug(" form submit -> clientJoinPOST() 호출 ");
		logger.debug(" vo : " + vo);
		
		cService.clientJoin(vo);
		logger.debug(" 거래처 등록 완료! ");
		
		rttr.addFlashAttribute("result","CREATEOK");
		logger.debug(" /clients/listAll 이동 ");
		
		return "redirect:/clients/listAll";
	}
	
	// http://localhost:8088/information/clients/listAll
	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
	public String listAllGET(Model model) throws Exception {
		logger.debug(" /clients/listAll -> listAllGET() 호출 ");
		
		List<ClientVO> clientList = cService.clientListAll();
		logger.debug(" ");
		return "/clients/listAll";
	}
	

	// http://localhost:8088/information/clients/update
	@RequestMapping(value = "/update")
	public void clientUpdateGET() throws Exception {
		logger.debug(" /clients/update -> clientUpdateGET() 호출 ");
	}
	
}































