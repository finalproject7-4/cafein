package com.cafein.controller;

import java.net.URLEncoder;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.Criteria;
import com.cafein.domain.PageVO;
import com.cafein.domain.QualityVO;
import com.cafein.service.StockService;

@Controller
@RequestMapping(value = "/material/*")
public class StockController {
	
	private static final Logger logger = LoggerFactory.getLogger(StockController.class);
	
	@Inject
	private StockService sService;
	
	// 재고 관리 통합 페이지 (자재 / 생산 + 반품)
	// http://localhost:8088/material/stock
	// @GetMapping(value = "/stock")
	// public void allStockGET(HttpSession session) {
		
	// }
	
	// http://localhost:8088/material/stockProduct
	// 재고 목록 조회 검색 버튼 (생산 [포장] + 반품)
	@RequestMapping(value = "/stockProduct", method = RequestMethod.GET)
	public void productStockListGET(Model model, HttpSession session, QualityVO vo, Criteria cri) throws Exception{
		session.getAttribute("membercode");
		
		// cri.setPageSize(1); // 삭제 예정
		vo.setCri(cri);
		List<QualityVO> resultList = sService.stockList(vo); // 생산 + 반품 재고 목록
		List<QualityVO> storageList = sService.storageList(); // 생산 + 반품 창고 목록
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(sService.stockListCount(vo));
		
		model.addAttribute("pageVO", pageVO);
		
		model.addAttribute("list", resultList);
		model.addAttribute("slist", storageList);
	}

	// http://localhost:8088/material/stockProduct
	// 재고 목록 조회 검색 버튼 (자재)
	@GetMapping(value = "/stock")
	public void materialStockListGET(Model model, HttpSession session, QualityVO vo, Criteria cri) throws Exception{
		session.getAttribute("membercode");
		
		// cri.setPageSize(1); // 삭제 예정
		vo.setCri(cri);
		List<QualityVO> resultList = sService.materialStockList(vo); // 자재 재고 목록
		List<QualityVO> rawStorageList = sService.rawmaterialStorageList(); // 원자재 창고 목록
		List<QualityVO> subStorageList = sService.submaterialStorageList(); // 부자재 창고 목록
		logger.debug(" rawStorageList : " + rawStorageList);
		logger.debug(" subStorageList : " + subStorageList);
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(sService.materialStockListCount(vo));
		
		model.addAttribute("pageVO", pageVO);
		
		model.addAttribute("list", resultList);
		model.addAttribute("rlist", rawStorageList);
		model.addAttribute("slist", subStorageList);
	}

	// 재고 입력 (생산 [포장] + 반품)
	@RequestMapping(value = "/newStock", method = RequestMethod.POST)
	public String newStockPOST(QualityVO vo, RedirectAttributes rttr, HttpSession session) throws Exception{
		int qualityid = vo.getQualityid();
		logger.debug(" qualityid : " + qualityid);
		Integer duResult = sService.duplicateStock(qualityid);
		if(duResult != null) {
			logger.debug(" 이미 재고 정보가 등록된 검수 내역입니다. ");
			rttr.addFlashAttribute("result", "duplicateStock");
			return "redirect:/quality/qualities";
		}else {
		
		int workerbycode = (int) session.getAttribute("membercode"); // 세션에 있는 사용자코드 받아오기 (수정 예정)
		vo.setWorkerbycode(workerbycode);
		
		int produceid = vo.getProduceid();
		// sService.normalRoastedBeanLot(produceid);
		
		if(vo.getItemtype() != null && vo.getItemtype().equals("생산")) {
			int stockquantity = vo.getStockquantity() / vo.getWeight();
			vo.setStockquantity(stockquantity);
		}
		
		int result = sService.newStock(vo);
		if(result == 0) {
			rttr.addFlashAttribute("result", "STOCKNO");
			logger.debug(" 재고 등록 실패! ");
			return "redirect:/quality/qualities";
		}else {
			sService.normalRoastedBeanLot(produceid);
			rttr.addFlashAttribute("result", "STOCKYES");
			logger.debug(" 재고 등록 성공! ");
		}
		// 재고 등록 여부 업데이트
		sService.registerStockY(vo);
		return "redirect:/material/stockProduct";
		}
	}
	
	// 재고 입력 (자재)
	@RequestMapping(value = "/newMaterialStock", method = RequestMethod.POST)
	public String newMaterialStockPOST(QualityVO vo, RedirectAttributes rttr, HttpSession session) throws Exception{
		int qualityid = vo.getQualityid();
		logger.debug(" qualityid : " + qualityid);
		Integer duResult = sService.duplicateStock(qualityid);
		if(duResult != null) {
			logger.debug(" 이미 재고 정보가 등록된 검수 내역입니다. ");
			rttr.addFlashAttribute("result", "duplicateStock");
			return "redirect:/quality/qualities";
		}else {
			
		int workerbycode = (int) session.getAttribute("membercode"); // 세션에 있는 사용자코드 받아오기 (수정 예정)
		vo.setWorkerbycode(workerbycode);
		
		int receiveid = vo.getReceiveid();
		
		int result = sService.newStock(vo);
		if(result == 0) {
			rttr.addFlashAttribute("result", "STOCKNO");
			logger.debug(" 재고 등록 실패! ");
			return "redirect:/quality/qualitiesMaterial";
		}else {
			sService.normalRoastedBeanLotMat(receiveid);
			rttr.addFlashAttribute("result", "STOCKYES");
			logger.debug(" 재고 등록 성공! ");
		}
		// 재고 등록 여부 업데이트
		sService.registerStockY(vo);
		return "redirect:/material/stock";
		}
	}
	
	// 재고량 변경 (생산 [포장] + 반품)
	@RequestMapping(value = "/updateStockQuantity", method = RequestMethod.POST)
	public String updateStockQuantityPOST(QualityVO vo, RedirectAttributes rttr, HttpSession session, Criteria cri) throws Exception{
		logger.debug(" updateStockQuantity 실행! ");	
		
		int workerbycode = (int) session.getAttribute("membercode"); // 세션에 있는 사용자코드 받아오기 (수정 예정)
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
		
		int page = cri.getPage();
		String searchBtn = vo.getSearchBtn();
		String searchText = vo.getSearchText();
		
		if(vo.getType() != null && vo.getType().equals("생산")) {
		if(searchBtn != null && searchText != null) {
			return "redirect:/material/stockProduct?page=" + page + "&searchBtn=" + URLEncoder.encode(searchBtn) + "&searchText=" + URLEncoder.encode(searchText);
		}
		
		if(searchBtn == null && searchText != null) {
			return "redirect:/material/stockProduct?page=" + page + "&searchText=" + URLEncoder.encode(searchText);
		}
		
		if(searchBtn != null && searchText == null) {
			return "redirect:/material/stockProduct?page=" + page + "&searchBtn=" + URLEncoder.encode(searchBtn);
		}
		
		return "redirect:/material/stockProduct?page=" + page;
		} 
		
		// 생산이 아닌 경우
		if(searchBtn != null && searchText != null) {
			return "redirect:/material/stock?page=" + page + "&searchBtn=" + URLEncoder.encode(searchBtn) + "&searchText=" + URLEncoder.encode(searchText);
		}
		
		if(searchBtn == null && searchText != null) {
			return "redirect:/material/stock?page=" + page + "&searchText=" + URLEncoder.encode(searchText);
		}
		
		if(searchBtn != null && searchText == null) {
			return "redirect:/material/stock?page=" + page + "&searchBtn=" + URLEncoder.encode(searchBtn);
		}
		
		return "redirect:/material/stock?page=" + page;
	}
	
	// 창고 변경
	@RequestMapping(value = "/updateStockStorage", method = RequestMethod.POST)
	public String updateStockStoragePOST(QualityVO vo, RedirectAttributes rttr, HttpSession session, Criteria cri) throws Exception{
		
		int workerbycode = (int) session.getAttribute("membercode"); // 세션에 있는 사용자코드 받아오기 (수정 예정)
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
		
		int page = cri.getPage();
		String searchBtn = vo.getSearchBtn();
		String searchText = vo.getSearchText();
		
		if(vo.getType() != null && vo.getType().equals("생산")) {
		if(searchBtn != null && searchText != null) {
			return "redirect:/material/stockProduct?page=" + page + "&searchBtn=" + URLEncoder.encode(searchBtn) + "&searchText=" + URLEncoder.encode(searchText);
		}
		
		if(searchBtn == null && searchText != null) {
			return "redirect:/material/stockProduct?page=" + page + "&searchText=" + URLEncoder.encode(searchText);
		}
		
		if(searchBtn != null && searchText == null) {
			return "redirect:/material/stockProduct?page=" + page + "&searchBtn=" + URLEncoder.encode(searchBtn);
		}
		
		return "redirect:/material/stockProduct?page=" + page;
		} 
		
		// 생산이 아닌 경우
		if(searchBtn != null && searchText != null) {
			return "redirect:/material/stock?page=" + page + "&searchBtn=" + URLEncoder.encode(searchBtn) + "&searchText=" + URLEncoder.encode(searchText);
		}
		
		if(searchBtn == null && searchText != null) {
			return "redirect:/material/stock?page=" + page + "&searchText=" + URLEncoder.encode(searchText);
		}
		
		if(searchBtn != null && searchText == null) {
			return "redirect:/material/stock?page=" + page + "&searchBtn=" + URLEncoder.encode(searchBtn);
		}
		
		return "redirect:/material/stock?page=" + page;
	}
	
	// 재고 알림용 토스트 데이터 (생산 [포장] + 반품)
	@GetMapping(value = "/productStockToast")
	public void productStockToast(Model model) throws Exception{
		model.addAttribute("productToast", sService.productStockToast());
	}
	
	// 재고 알림용 토스트 데이터 (자재)
	@GetMapping(value = "/materialStockToast")
	public void materialStockToast(Model model) throws Exception{
		model.addAttribute("materialToast", sService.materialStockToast());
	}
	
}
