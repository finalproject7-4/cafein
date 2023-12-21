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

import com.cafein.domain.QualityVO;
import com.cafein.service.QualityService;

@Controller
@RequestMapping(value = "/quality/*")
public class QualityController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(QualityController.class);
	
	@Inject
	private QualityService qService;
	
	// http://localhost:8088/quality/plist
	// 품질 관리 (생산 + 반품) 목록
	@GetMapping(value = "/plist")
	public void qualityList(Model model, HttpSession session) throws Exception{
		
		session.setAttribute("membercode", "admin"); // 정상 처리 시 세션에 저장된 값 사용
		
		// 품질 관리 (생산 + 반품) 목록
		model.addAttribute("list", qService.qualityList());
		
	}
	
	// http://localhost:8088/quality/pdlist	
	// 불량 현황 (생산 + 반품) 목록
	@GetMapping(value = "/pdlist")
	public void qualityDefectList(Model model, HttpSession session) throws Exception{
		
		session.setAttribute("membercode", "admin"); // 정상 처리 시 세션에 저장된 값 사용
		
		// 불량 현황 (생산 + 반품) 목록
		model.addAttribute("defectList", qService.defectsList());
	}	
	
	// 생산 검수 입력 폼 - GET
	@GetMapping(value = "/paudit")
	public void pQualityAuditGET(@ModelAttribute("produceid") int produceid, Model model) throws Exception{
		
		model.addAttribute("vo", qService.produceInfo(produceid));
	}
	
	// 생산 검수 입력 처리 - POST
	@PostMapping(value = "/paudit")
	public String pQualityAuditPOST(QualityVO vo, RedirectAttributes rttr) throws Exception{
		if(vo.getAuditquantity() == 0) {
			logger.debug(" 검수량 0개 불가 ");
			rttr.addFlashAttribute("auditQuantity", "zero");
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
			return "redirect:/quality/paudit?produceid=" + vo.getProduceid();
		}
		logger.debug(" 검수 성공 ");
			if(vo.getDefectquantity() == 0) { // 생산 검수 - 합격
				vo.setQualitycheck("합격");
				qService.productQualityCheck(vo);
			}else { // 생산 검수 - 불합격
				vo.setQualitycheck("불합격");
				qService.productQualityCheck(vo);
			}
		return "redirect:/quality/plist";
	}
	
	// 반품 검수 입력 폼 - GET
	@GetMapping(value = "/raudit")
	public void rQualityAuditGET(@ModelAttribute("returnid") int returnid, Model model) throws Exception{
		
		model.addAttribute("vo", qService.returnInfo(returnid));
	}
	
	// 반품 검수 입력 처리 - POST
	@PostMapping(value = "/raudit")
	public String rQualityAuditPOST(QualityVO vo, RedirectAttributes rttr) throws Exception{
		if(vo.getAuditquantity() == 0) {
			logger.debug(" 검수량 0개 불가 ");
			rttr.addFlashAttribute("auditQuantity", "zero");
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
			return "redirect:/quality/raudit?returnid=" + vo.getReturnid();
		}
		logger.debug(" 검수 성공 ");
		return "redirect:/quality/plist";
	}
	
	// 불량 현황 입력 폼 (생산 + 반품) - GET
	@GetMapping(value = "/pdefects")
	public String pQualityDefects(@RequestParam("qualityid") int qualityid, Model model, RedirectAttributes rttr) throws Exception{
		
		Integer result = qService.duplicateDefects(qualityid);
		if(result != null) {
			logger.debug(" 이미 불량 정보가 등록된 검수 내역입니다. ");
			rttr.addFlashAttribute("result", "duplicate");
			return "redirect:/quality/plist";
		}else {
			model.addAttribute("vo", qService.defectInfo(qualityid));
			return "/quality/pdefects";
		}
	}
	
	// 불량 현황 입력 처리 (생산 + 반품) - POST
	@PostMapping(value = "/pdefects")
	public String pQualityDefects(QualityVO vo) throws Exception{
		
		int result = qService.produceReturnDefects(vo);
		if(result == 0) {
			logger.debug(" 불량 현황 입력 실패 ");
			return "redirect:/quality/plist";
		}
		logger.debug(" 불량 현황 입력 성공 ");
		return "redirect:/quality/plist";
		
	}
	

}
