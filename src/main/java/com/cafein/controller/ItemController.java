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
	@RequestMapping(value = "/items", method = RequestMethod.GET)
	public String itemListAll(Model model) throws Exception {
		logger.debug("/information/item 호출 -> itemListAll() 호출");
		// 연결된 뷰페이지로 이동
		logger.debug("/views/information/item.jsp 페이지로 이동");
		
		// 서비스 - DB에 저장된 글을 가져오기
		List<ItemVO> itemList = iService.itemList();
		logger.debug("(●'◡'●)" + itemList);
				
		// 데이터를 연결된 뷰페이지로 전달 (Model 객체 필요)
		model.addAttribute("itemList", itemList);
		
		return "/information/item";
	}
	
	@RequestMapping(value = "/items", method = RequestMethod.POST)
	public String itemList(String option, String keyword, Model model) throws Exception {
		logger.debug("option: " + option);
		logger.debug("keyword: " + keyword);
		
		Map map = new HashMap();
		
		map.put("option", option);
		map.put("keyword", keyword);
		
		List<ItemVO> searchItemList = iService.searchItemList(map);
		
		model.addAttribute("itemList", searchItemList);
		
		return "/information/item";
		
	}
	
	
}
