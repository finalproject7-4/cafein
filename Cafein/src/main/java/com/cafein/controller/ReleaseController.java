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
import com.cafein.domain.ReleasesVO;
import com.cafein.service.ItemService;
import com.cafein.service.OrdersService;
import com.cafein.service.ReceiveService;
import com.cafein.service.ReleasesService;

@Controller
@RequestMapping(value = "/material/*")
public class ReleaseController {

	private static final Logger logger = LoggerFactory.getLogger(ReleaseController.class);

	@Inject
	private ReleasesService rsService;
	
	// http://localhost:8088/material/releases
	@RequestMapping(value = "/releases", method = RequestMethod.GET)
	public String releasesListGET(Model model) throws Exception {
		logger.debug("/material/releases 호출 -> releaseListGET() 호출");
		// 연결된 뷰페이지로 이동
		logger.debug("/views/material/releases.jsp 페이지로 이동");
		
		// 서비스 - DB에 저장된 글을 가져오기
		List<ReleasesVO> releasesList = rsService.releasesList();
		logger.debug("(●'◡'●)" + releasesList);
				
		// 데이터를 연결된 뷰페이지로 전달 (Model 객체 필요)
		model.addAttribute("releasesList", releasesList);
		
		return "/material/releases";
	}
	
	
}
