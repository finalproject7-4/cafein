package com.cafein.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.QualityVO;
import com.cafein.service.StockService;

@Controller
@RequestMapping(value = "/stock/*")
public class StockController {
	
	private static final Logger logger = LoggerFactory.getLogger(StockController.class);
	
	@Inject
	private StockService sService;
	
	// http://localhost:8088/stock/slist
	// 재고 목록 조회 (생산 [포장] + 반품)
	@RequestMapping(value = "/slist", method = RequestMethod.GET)
	public void stockListGET(Model model, HttpSession session) throws Exception{
		session.setAttribute("membercode", "admin"); // 정상 처리 시 세션에 저장된 값 사용
		
		List<QualityVO> resultList = sService.stockList(); // 재고 목록
		List<QualityVO> storageList = sService.storageList(); // 창고 목록
		
		model.addAttribute("list", resultList);
		model.addAttribute("slist", storageList);
	}

	// 재고 입력 (생산 [포장] + 반품)
	@RequestMapping(value = "/new", method = RequestMethod.POST)
	public String newStockPOST(QualityVO vo, RedirectAttributes rttr, HttpSession session) throws Exception{
		int qualityid = vo.getQualityid();
		logger.debug(" qualityid : " + qualityid);
		Integer duResult = sService.duplicateStock(qualityid);
		if(duResult != null) {
			logger.debug(" 이미 재고 정보가 등록된 검수 내역입니다. ");
			rttr.addFlashAttribute("result", "duplicateStock");
			return "redirect:/quality/plist";
		}else {
		String workerbycode = (String) session.getAttribute("membercode");
		vo.setWorkerbycode(workerbycode);
		int result = sService.newStock(vo);
		if(result == 0) {
			rttr.addFlashAttribute("result", "STOCKNO");
			logger.debug(" 재고 등록 실패! ");
			return "redirect:/quality/plist";
		}else {
			rttr.addFlashAttribute("result", "STOCKYES");
			logger.debug(" 재고 등록 성공! ");
		}
		return "redirect:/stock/slist";
		}
	}
	
	// 재고량 변경 (생산 [포장] + 반품)
	@RequestMapping(value = "/updateStockQuantity", method = RequestMethod.POST)
	public String updateStockQuantityPOST(QualityVO vo, RedirectAttributes rttr, HttpSession session) throws Exception{
		
		String workerbycode = (String) session.getAttribute("membercode");
		vo.setWorkerbycode(workerbycode);
		logger.debug(" vo : " + vo);
		int result = sService.stockQuantity(vo);
		
		if(result == 0) {
			rttr.addFlashAttribute("result", "STOCKUPNO");
			logger.debug(" 재고량 변경 실패! ");
		}else {
			rttr.addFlashAttribute("result", "STOCKUPYES");
			logger.debug(" 재고량 변경 성공! ");			
		}
		
		return "redirect:/stock/slist";
	}
	
	// 창고 변경 (생산 [포장] + 반품)
	@RequestMapping(value = "/updateStockStorage", method = RequestMethod.POST)
	public String updateStockStoragePOST(QualityVO vo, RedirectAttributes rttr, HttpSession session) throws Exception{
		
		String workerbycode = (String) session.getAttribute("membercode");
		vo.setWorkerbycode(workerbycode);
		logger.debug(" vo : " + vo);
		int result = sService.stockStorage(vo);
		
		if(result == 0) {
			rttr.addFlashAttribute("result", "STOCKSUPNO");
			logger.debug(" 창고 변경 실패! ");
		}else {
			rttr.addFlashAttribute("result", "STOCKSUPYES");
			logger.debug(" 창고 변경 성공! ");			
		}
		
		return "redirect:/stock/slist";
	}
	
	// 재고 목록 조회 (자재)
	@RequestMapping(value = "/smlist", method = RequestMethod.GET)
	public void stockMListGET(Model model, HttpSession session) throws Exception{
		session.setAttribute("membercode", "admin"); // 정상 처리 시 세션에 저장된 값 사용
		
		List<QualityVO> resultList = sService.stockList();
		List<QualityVO> storageList = sService.storageList();
		
		model.addAttribute("list", resultList);
		model.addAttribute("slist", storageList);
	}

}
