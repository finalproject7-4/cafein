package com.cafein.controller;

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
import com.cafein.domain.Criteria;
import com.cafein.domain.PageVO;
import com.cafein.service.ClientService;

@Controller
@RequestMapping(value = "/information/*")
public class ClientController {
	
	private static final Logger logger = LoggerFactory.getLogger(ClientController.class);
	
	@Inject
	private ClientService cService;
	
	// 거래처 등록 - GET
	// http://localhost:8088/information/clientJoin
	@RequestMapping(value = "/clientJoin", method = RequestMethod.GET)
	public void clientJoinGET() throws Exception {
		logger.debug(" /information/clientJoin -> clientJoinGET() 호출 ");
		logger.debug(" /views/information/clientJoin.jsp 페이지로 이동 ");
	}
	
	// 거래처 등록 - POST
	@RequestMapping(value = "/clientJoin", method = RequestMethod.POST)
	public String clientJoinPOST(ClientVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug(" form submit -> clientJoinPOST() 호출 ");
		logger.debug(" vo : " + vo);
		
		// 생성한 거래처 코드 저장
		vo.setClientcode(generateClientcode(vo));
		logger.debug(" vo : " + vo);
		
		cService.clientJoin(vo);
		logger.debug(" 거래처 등록 완료! ");
		
		rttr.addFlashAttribute("result","JOINOK");
		logger.debug(" /information/clients 이동 ");
		
		return "redirect:/information/clients";
	}
	
	// 거래처 코드 생성 메서드
	public String generateClientcode(ClientVO vo) throws Exception {
		
		String code = "";
		int num = 101 + cService.maxClientCode(vo);
		
		switch(vo.getCategoryofclient()) {
			case "납품": code = "D"; break;
			case "공급": code = "S"; break;
		}
		
		return code + num;
		
	}
	
	// 거래처 목록 조회 (페이징) - GET
	// http://localhost:8088/information/clients
	@RequestMapping(value = "/clients", method = RequestMethod.GET)
	public void clientList(Model model, ClientVO vo, Criteria cri, HttpSession session) throws Exception {
		logger.debug(" clientList() 호출 ");
		logger.debug(" ClientVO : " + vo);
		
		// ClientVO의 Criteria 설정
		vo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(cService.totalClientCount(vo));
		logger.debug(" 총 개수 : " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("clientList", cService.clientPageList(vo));
		model.addAttribute("pageVO", pageVO);
				
		// 연결된 뷰페이지로 이동
		logger.debug(" /views/information/clients.jsp 페이지로 이동 ");
	}
		
	// 거래처 수정 - GET
	// http://localhost:8088/information/clientUpdate?clientid=2
	@RequestMapping(value = "/clientUpdate", method = RequestMethod.GET)
	public void clientUpdateGET(@ModelAttribute("clientid") int clientid, Model model) throws Exception {
		logger.debug(" /information/clientUpdate -> clientUpdateGET() 호출 ");
		logger.debug(" 수정할 거래처 번호 : " + clientid);
		
		// 기존의 거래처 정보를 가져와서 화면에 출력
		ClientVO resultVO = cService.clientInfo(clientid);
		// 거래처 정보를 Model 객체에 저장해서 전달
		model.addAttribute("resultVO", resultVO);
	}
	
	// 거래처 수정 - POST
	@RequestMapping(value = "/clientUpdate", method = RequestMethod.POST)
	public String clientUpdatePOST(ClientVO vo,
								  RedirectAttributes rttr) throws Exception {
		logger.debug(" /information/clientUpdate -> clientUpdatePOST() 호출 ");
		logger.debug(" 수정할 정보 : " + vo);
		
		int result = cService.clientUpdate(vo);
		rttr.addFlashAttribute("result", "UPDATEOK");
		
		return "redirect:/information/clients";
	}
	
	// 거래처 비활성화 - GET
	// http://localhost:8088/information/clientDelete?clientid=1
	@RequestMapping(value = "/clientDelete", method = RequestMethod.GET)
	public void clientDeleteGET(@ModelAttribute("clientid") int clientid, Model model) throws Exception {
		logger.debug(" /information/clientDelete -> clientDeleteGET() 호출 ");
		logger.debug(" 비활성화할 거래처 번호 : " + clientid);
		
		// 기존의 거래처 정보를 가져와서 화면에 출력
		ClientVO resultVO = cService.clientInfo(clientid);
		// 거래처 정보를 Model 객체에 저장해서 전달
		model.addAttribute("resultVO", resultVO);
	}
	
	// 거래처 비활성화 - POST
	@RequestMapping(value = "/clientDelete", method = RequestMethod.POST)
	public String clientDeletePOST(ClientVO vo,
								  RedirectAttributes rttr) throws Exception {
		logger.debug(" /information/clientDelete -> clientDeletePOST() 호출 ");
		logger.debug(" 비활성화할 정보 : " + vo);
		
		int result = cService.clientDelete(vo);
		rttr.addFlashAttribute("result", "DELETEOK");
		
		return "redirect:/information/clients";
	}

}