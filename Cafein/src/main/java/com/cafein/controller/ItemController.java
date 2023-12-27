package com.cafein.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafein.domain.ItemVO;
import com.cafein.service.ItemService;

@Controller
@RequestMapping(value = "/information/*")
public class ItemController {

	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

	@Inject
	private ItemService iService;
	
	// http://localhost:8088/information/items
	// 품목 목록 출력 - GET
	@RequestMapping(value = "/items", method = RequestMethod.GET)
	public String itemListAll(Model model) throws Exception {
		logger.debug("itemListAll() 호출");
		// 연결된 뷰페이지로 이동
		logger.debug("/views/information/item.jsp 페이지로 이동");
		
		// 서비스 - DB에 저장된 글을 가져오기
		List<ItemVO> itemList = iService.itemList();
		logger.debug("(●'◡'●)" + itemList);
				
		// 데이터를 연결된 뷰페이지로 전달 (Model 객체 필요)
		model.addAttribute("itemList", itemList);
		
		return "/information/item";
	}
	
	// 품목 목록 출력 (검색) - POST
	@RequestMapping(value = "/itemSearchList", method = RequestMethod.POST)
	public String itemSearchList(String option, String keyword, Model model) throws Exception {
		logger.debug("itemSearchList() 호출");
		logger.debug("option: " + option + ", keyword: " + keyword);
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("option", option);
		map.put("keyword", keyword);
		
		model.addAttribute("itemList", iService.searchItemList(map));
		
		return "/information/item";
	}
	
	// 품목 등록 - POST
	@RequestMapping(value = "/itemRegist", method = RequestMethod.POST)
	public String itemRegist(ItemVO vo) throws Exception {
		logger.debug("itemRegist() 호출");
		logger.debug("ItemVO: " + vo);
			
		// 생성한 품목코드 저장
		vo.setItemcode(generateItemCode(vo));
		
		iService.itemRegist(vo);
		
		return "redirect:/information/items";
	} // itemRegist() 끝
	
	// 품목코드 생성 메서드
	public String generateItemCode(ItemVO vo) throws Exception {
		
		String code = "";
		int num = 101 + iService.itemCount(vo);
		
		switch(vo.getItemtype()) {
			case "원자재": code = "MM"; break;
			case "부자재": code = "SM"; break;
			case "완제품": code = "P"; break;
		}
		
		return code + num;
	}
	
} // Controller 끝
