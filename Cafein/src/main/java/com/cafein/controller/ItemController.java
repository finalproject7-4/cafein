package com.cafein.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafein.domain.Criteria;
import com.cafein.domain.ItemVO;
import com.cafein.domain.PageVO;
import com.cafein.service.ClientService;
import com.cafein.service.ItemService;

@Controller
@RequestMapping(value = "/information/*")
public class ItemController {

	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

	@Inject
	private ItemService iService;

	@Inject
	private ClientService cService;
	
	// http://localhost:8088/information/items
	// 품목 목록 - GET
	@RequestMapping(value = "/items", method = RequestMethod.GET)
	public void itemList(Model model, ItemVO vo, Criteria cri) throws Exception {
		logger.debug("itemList() 호출");
		
		// ItemVO의 Criteria 설정
		vo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(iService.itemCount(vo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("itemList", iService.itemList(vo));
		model.addAttribute("clientList", cService.clientList());
		model.addAttribute("pageVO", pageVO);
				
		// 연결된 뷰페이지로 이동
		logger.debug("/views/information/items.jsp 페이지로 이동");
	}
	
	// 품목 등록 - POST
	@RequestMapping(value = "/itemRegist", method = RequestMethod.POST)
	public String itemRegist(ItemVO vo) throws Exception {
		logger.debug("itemRegist() 호출");
			
		// 생성한 품목코드 저장
		vo.setItemcode(generateItemCode(vo));
		
		iService.itemRegist(vo);
		
		return "redirect:/information/items";
	} // itemRegist() 끝
	
	// 품목코드 생성 메서드
	public String generateItemCode(ItemVO vo) throws Exception {
		
		String code = "";
		int num = 101 + iService.itemtypeCount(vo);
		
		switch(vo.getItemtype()) {
			case "원자재": code = "MM"; break;
			case "부자재": code = "SM"; break;
			case "완제품": code = "P"; break;
		}
		
		return code + num;
	}
	
} // Controller 끝
