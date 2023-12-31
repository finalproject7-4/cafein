package com.cafein.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.ClientVO;
import com.cafein.domain.MemberVO;
import com.cafein.service.ClientService;

@Controller
@RequestMapping(value = "information/*")
public class ClientController {
	
	private static final Logger logger = LoggerFactory.getLogger(ClientController.class);
	
	@Inject
	private ClientService cService;
	
	// http://localhost:8088/information/clientJoin
	@RequestMapping(value = "/clientJoin", method = RequestMethod.GET)
	public void clientJoinGET() throws Exception {
		logger.debug(" /information/clientJoin -> clientJoinGET() 호출 ");
		logger.debug(" /views/information/clientJoin.jsp 페이지로 이동 ");
	}
	
	@RequestMapping(value = "/clientJoin", method = RequestMethod.POST)
	public String clientJoinPOST(ClientVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug(" form submit -> clientJoinPOST() 호출 ");
		logger.debug(" vo : " + vo);
		
		cService.clientJoin(vo);
		logger.debug(" 거래처 등록 완료! ");
		
		rttr.addFlashAttribute("result","CREATEOK");
		logger.debug(" /information/clients 이동 ");
		
		return "redirect:/information/clients";
	}
	
	// http://localhost:8088/information/clients
	@RequestMapping(value = "/clients", method = RequestMethod.GET)
	public String listAllGET(Model model) throws Exception {
		logger.debug(" /information/clients -> clientListGET() 호출 ");
		
		List<ClientVO> clientList = cService.clientList();
		model.addAttribute("clientList", cService.clientList());
		
		return "/information/clients";
	}
	

	// http://localhost:8088/information/clientUpdate?clientid=1
	@RequestMapping(value = "/clientUpdate", method = RequestMethod.GET)
	public void clientUpdateGET(@ModelAttribute("clientid") int clientid, Model model) throws Exception {
		logger.debug(" /information/clientUpdate -> clientUpdateGET() 호출 ");
		logger.debug(" 수정할 거래처 번호 : " + clientid);
		
		// 기존의 거래처 정보를 가져와서 화면에 출력
		ClientVO resultVO = cService.clientInfo(clientid);
		// 거래처 정보를 Model 객체에 저장해서 전달
		model.addAttribute("resultVO", resultVO);
	}
	
	@RequestMapping(value = "/clientUpdate", method = RequestMethod.POST)
	public String clientUpdatePOST(ClientVO vo,
								  RedirectAttributes rttr) throws Exception {
		logger.debug(" /information/clientUpdate -> clientUpdatePOST() 호출 ");
		logger.debug(" 수정할 정보 : " + vo);
		
		int result = cService.clientUpdate(vo);
		rttr.addFlashAttribute("result", "updateOK");
		
		return "redirect:/information/clients";
	}
	
	// http://localhost:8088/information/clientDelete?clientid=1
	@RequestMapping(value = "/clientDelete", method = RequestMethod.GET)
	public void clientDeleteGET(@ModelAttribute("clientid") int clientid, Model model) throws Exception {
		logger.debug(" /information/clientDelete -> clientDeleteGET() 호출 ");
		logger.debug(" 비활성화할 거래처 번호 : " + clientid);
		
		// 기존의 직원 정보를 가져와서 화면에 출력
		ClientVO resultVO = cService.clientInfo(clientid);
		// 직원 정보를 Model 객체에 저장해서 전달
		model.addAttribute("resultVO", resultVO);
	}
	
	// http://localhost:8088/information/clientDelete?clientid=1
	@RequestMapping(value = "/clientDelete", method = RequestMethod.POST)
	public String clientDeletePOST(ClientVO vo,
								  RedirectAttributes rttr) throws Exception {
		logger.debug(" /information/clientDelete -> clientDeletePOST() 호출 ");
		logger.debug(" 비활성화할 정보 : " + vo);
		
		int result = cService.clientDelete(vo);
		rttr.addFlashAttribute("result", "deleteOK");
		
		return "redirect:/information/clients";
	}

}































