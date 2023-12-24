package com.cafein.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.Criteria;
import com.cafein.domain.PageVO;
import com.cafein.domain.QualityVO;
import com.cafein.service.QualityService;

@Controller
@RequestMapping(value = "/quality/*")
public class QualityController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(QualityController.class);
	
	@Inject
	private QualityService qService;
	
	// 품질 관리 통합 페이지 (생산 + 반품 / 자재)
	// http://localhost:8088/quality/qualities
	@GetMapping(value = "/qualities")
	public void allQualityGET(HttpSession session) {
		session.setAttribute("membercode", "admin"); // 정상 처리 시 세션에 저장된 값 사용 (get으로 변경)
		
	}
	
	// http://localhost:8088/quality/productQualityList
	// 품질 관리 (생산 + 반품) 목록
	@GetMapping(value = "/productQualityList")
	public void productQualityListGET(Model model, HttpSession session, QualityVO vo, 
			Criteria cri) throws Exception{
		
//		model.addAttribute("list", qService.qualityList());
		vo.setCri(cri);
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(43);
		
		model.addAttribute("list", qService.qualityListSearchBtn(vo));
		model.addAttribute("pageVO", pageVO);
	}
	
	// 품질 관리 (자재) 목록
	@GetMapping(value = "/materialQualityList")
	public void materialQualityList() throws Exception{
		
	}
	
	// http://localhost:8088/quality/productDefectList	
	// 불량 현황 (생산 + 반품) 목록
	@GetMapping(value = "/productDefectList")
	public void productQualityDefectListGET(Model model, HttpSession session, 
			Criteria cri) throws Exception{
		
		session.setAttribute("membercode", "admin"); // 정상 처리 시 세션에 저장된 값 사용
		
		model.addAttribute("defectList", qService.defectsList());
	}
	
	// 불량 현황 (자재) 목록
	@GetMapping(value = "/materialDefectList")
	public void  materialDefectListGET() throws Exception{
		
	}
	
	// 생산 검수 입력 처리 - POST
	@PostMapping(value = "/productAudit")
	public String productQualityAuditPOST(QualityVO vo, RedirectAttributes rttr) throws Exception{
		if(vo.getAuditquantity() == 0) {
			logger.debug(" 검수량 0개 불가 ");
			rttr.addFlashAttribute("auditQuantity", "zero");
			return "redirect:/quality/qualities";
		}
		
		int result = 0;
		if(vo.getProductquantity() == vo.getAuditquantity()) { // 생산량 = 검수량 ("검수완료")
			vo.setAuditstatus("검수완료");
			
			// 검수코드 생성
			if(vo.getAuditcode().equals("")) {
			LocalDateTime now = LocalDateTime.now();
			String fmt = "yyMMddHHmmss";
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern(fmt);
			String dateTime = now.format(dtf);
			vo.setAuditcode("QC" + dateTime);
			}else if(!vo.getAuditcode().equals("")) {
				vo.setAuditcode(vo.getAuditcode());
			}
			
			logger.debug(" 검수 상태 : " + vo.getAuditstatus());
			logger.debug(" vo : " + vo);
			result = qService.productAuditFull(vo);
			
			if(result != 0) {
				if(vo.getDefectquantity() == 0) { // 생산 검수 - 정상
					vo.setQualitycheck("정상");
					qService.productQualityCheck(vo);
				}else { // 생산 검수 - 불량
					vo.setQualitycheck("불량");
					qService.productQualityCheck(vo);
				}
			}
			
		}else if(vo.getAuditquantity() != 0 && vo.getProductquantity() > vo.getAuditquantity()) { // 생산량 > 검수량 ("검수중")
			vo.setAuditstatus("검수중");
			
			// 검수코드 생성
			if(vo.getAuditcode().equals("")) {
			LocalDateTime now = LocalDateTime.now();
			String fmt = "yyMMddHHmmss";
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern(fmt);
			String dateTime = now.format(dtf);
			vo.setAuditcode("QC" + dateTime);
			}else if(!vo.getAuditcode().equals("")) {
				vo.setAuditcode(vo.getAuditcode());
			}
			
			logger.debug(" 검수 상태 : " + vo.getAuditstatus());
			logger.debug(" vo : " + vo);
			result = qService.produceAudit(vo);
		}
		
		if(result == 0) {
			logger.debug(" 검수 실패 ");
			rttr.addFlashAttribute("AUDIT", "X");
			return "redirect:/quality/qualities";
		}
		logger.debug(" 검수 성공 ");
		rttr.addFlashAttribute("AUDIT", "O");
		return "redirect:/quality/qualities";
	}
	
	// 반품 검수 입력 처리 - POST
	@PostMapping(value = "/returnAudit")
	public String returnQualityAuditPOST(QualityVO vo, RedirectAttributes rttr) throws Exception{
		if(vo.getAuditquantity() == 0) {
			logger.debug(" 검수량 0개 불가 ");
			rttr.addFlashAttribute("auditQuantity", "zero");
			return "redirect:/quality/qualities";
		}
		
		int result = 0;
		if(vo.getProductquantity() == vo.getAuditquantity()) { // 생산량 = 검수량 ("검수완료")
			vo.setAuditstatus("검수완료");
			
			// 검수코드 생성
			if(vo.getAuditcode().equals("")) {
			LocalDateTime now = LocalDateTime.now();
			String fmt = "yyMMddHHmmss";
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern(fmt);
			String dateTime = now.format(dtf);
			vo.setAuditcode("QR" + dateTime);
			}else if(!vo.getAuditcode().equals("")) {
				vo.setAuditcode(vo.getAuditcode());
			}
			
			logger.debug(" 검수 상태 : " + vo.getAuditstatus());
			logger.debug(" vo : " + vo);
			result = qService.returnAuditFull(vo);
		}else if(vo.getAuditquantity() != 0 && vo.getProductquantity() > vo.getAuditquantity()) { // 생산량 > 검수량 ("검수중")
			vo.setAuditstatus("검수중");
			
			// 검수코드 생성
			if(vo.getAuditcode().equals("")) {
			LocalDateTime now = LocalDateTime.now();
			String fmt = "yyMMddHHmmss";
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern(fmt);
			String dateTime = now.format(dtf);
			vo.setAuditcode("QR" + dateTime);
			}else if(!vo.getAuditcode().equals("")) {
				vo.setAuditcode(vo.getAuditcode());
			}
			
			logger.debug(" 검수 상태 : " + vo.getAuditstatus());
			logger.debug(" vo : " + vo);
			result = qService.returnAudit(vo);
		}
		
		if(result == 0) {
			logger.debug(" 검수 실패 ");
			rttr.addFlashAttribute("AUDIT", "X");
			return "redirect:/quality/qualities";
		}
		logger.debug(" 검수 성공 ");
		qService.returnsQualityid(vo);
		rttr.addFlashAttribute("AUDIT", "O");
		return "redirect:/quality/qualities";
	}
	
	// 불량 현황 입력 처리 (생산 + 반품) - POST
	@PostMapping(value = "/productReturnNewDefect")
	public String productReturnQualityNewDefectPOST(QualityVO vo, RedirectAttributes rttr) throws Exception{
		
		int result = qService.produceReturnDefects(vo);
		if(result == 0) {
			logger.debug(" 불량 현황 입력 실패 ");
			rttr.addFlashAttribute("DEFECT", "X");
			return "redirect:/quality/qualities";
		}
		logger.debug(" 불량 현황 입력 성공 ");
		// 품질 관리에서 불량 등록 여부 업데이트
		qService.registerDefectY(vo);
		rttr.addFlashAttribute("DEFECT", "O");
		return "redirect:/quality/qualities";
	}
}
