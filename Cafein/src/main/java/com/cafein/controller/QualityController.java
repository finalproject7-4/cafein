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
import com.cafein.service.StockService;

@Controller
@RequestMapping(value = "/quality/*")
public class QualityController {
	
	private static final Logger logger = LoggerFactory.getLogger(QualityController.class);
	
	@Inject
	private QualityService qService;
	
	@Inject
	private StockService sService;
	
	// 품질 관리 페이지 (생산 + 반품)
	// http://localhost:8088/quality/qualities
	@GetMapping(value = "/qualities")
	public void productQualityGET(HttpSession session, @RequestParam(name = "page", required = false) Integer page, 
			@RequestParam(name = "searchBtn", required = false) String searchBtn, @RequestParam(name = "startDate", required = false) String startDate, @RequestParam(name = "endDate", required = false) String endDate) {
		session.getAttribute("membercode");
		
	}
	
	// 품질 관리 페이지 (자재)
	// http://localhost:8088/quality/qualitiesMaterial
	@GetMapping(value = "/qualitiesMaterial")
	public void materialQualityGET(HttpSession session) {
		session.getAttribute("membercode");
		
	}

	// 품질 관리 (생산 + 반품) 목록
	@GetMapping(value = "/productQualityList")
	public void productQualityListGET(Model model, HttpSession session, QualityVO vo, 
			Criteria cri) throws Exception{
		
		session.getAttribute("membercode");
		
		cri.setPageSize(5);
		vo.setCri(cri);
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(qService.qualityListSearchBtnCount(vo));
		logger.debug(" 총 개수 : " + pageVO.getTotalCount());
		
		model.addAttribute("pageVO", pageVO);
		
		model.addAttribute("list", qService.qualityListSearchBtn(vo));
	}
	
	// 품질 관리 (자재) 목록
	@GetMapping(value = "/materialQualityList")
	public void materialQualityList(Model model, HttpSession session, QualityVO vo, Criteria cri) throws Exception{
		
		session.getAttribute("membercode");
		
		cri.setPageSize(5);
		vo.setCri(cri);
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(qService.materialQualityListSearchBtnCount(vo));
		logger.debug(" 총 개수 : " + pageVO.getTotalCount());
		
		model.addAttribute("pageVO", pageVO);
		
		model.addAttribute("list", qService.materialQualityListSearchBtn(vo));
	}
	
	// 불량 현황 (생산 + 반품) 목록
	@GetMapping(value = "/productDefectList")
	public void productQualityDefectListGET(Model model, HttpSession session, 
			Criteria cri, QualityVO vo) throws Exception{
		
		session.getAttribute("membercode");
		
		cri.setPageSize(5);
		vo.setCri(cri);
		
		PageVO pageVO2 = new PageVO();
		pageVO2.setCri(cri);
		pageVO2.setTotalCount(qService.defectsListSearchBtnCount(vo));
		logger.debug(" pageVO2.setTotalCount : " + pageVO2.getTotalCount());
		
		model.addAttribute("pageVO2", pageVO2);
		model.addAttribute("defectList", qService.defectsListSearchBtn(vo));
	}
	
	// 불량 현황 (자재) 목록
	@GetMapping(value = "/materialDefectList")
	public void  materialDefectListGET(Model model, HttpSession session, 
			Criteria cri, QualityVO vo) throws Exception{
		
		session.getAttribute("membercode");
		
		cri.setPageSize(5);
		vo.setCri(cri);
		
		PageVO pageVO2 = new PageVO();
		pageVO2.setCri(cri);
		pageVO2.setTotalCount(qService.materialDefectsListSearchBtnCount(vo));
		logger.debug(" pageVO2.setTotalCount : " + pageVO2.getTotalCount());
		
		model.addAttribute("pageVO2", pageVO2);
		model.addAttribute("defectList", qService.materialDefectsListSearchBtn(vo));
		
	}
	
	// 생산 검수 입력 처리 - POST
	@PostMapping(value = "/productAudit")
	public String productQualityAuditPOST(QualityVO vo, RedirectAttributes rttr, HttpSession session, @ModelAttribute("page") Integer page, 
			@ModelAttribute("searchBtn") String searchBtn, @ModelAttribute("startDate") String startDate, @ModelAttribute("endDate") String endDate) throws Exception{
		// 페이지 유지를 위한 페이지 정보 가져오기
		rttr.addFlashAttribute("page", page);
		
		if(searchBtn != null) {
			rttr.addFlashAttribute("searchBtn", searchBtn);
		}
		if(startDate != null) {
			rttr.addFlashAttribute("startDate", startDate);
		}
		if(endDate != null) {
			rttr.addFlashAttribute("endDate", endDate);
		}
		
		if(vo.getAuditquantity() == 0) {
			logger.debug(" 검수량 0개 불가 ");
			rttr.addFlashAttribute("auditQuantity", "zero");
			return "redirect:/quality/qualities";
		}
		
		// 검수자 입력 (멤버코드)
		vo.setAuditbycode(session.getAttribute("membercode").toString());
		
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
				if((double) vo.getDefectquantity() / vo.getProductquantity() >= 0 && (double) vo.getDefectquantity() / vo.getProductquantity() <= 0.3) { // 생산 검수 - 정상 [불량 비율 : 0.3 (30%)]
						vo.setQualitycheck("정상");
						qService.productQualityCheck(vo);
						
						if(vo.getProduceprocess() != null && !vo.getProduceprocess().equals("생산 - 포장")) {
							sService.registerStockY(vo);
						}
						
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
	public String returnQualityAuditPOST(QualityVO vo, HttpSession session, RedirectAttributes rttr, @ModelAttribute("page") Integer page, 
			@ModelAttribute("searchBtn") String searchBtn, @ModelAttribute("startDate") String startDate, @ModelAttribute("endDate") String endDate) throws Exception{
		// 페이지 유지를 위한 페이지 정보 가져오기
		rttr.addFlashAttribute("page", page);
		
		if(searchBtn != null) {
			rttr.addFlashAttribute("searchBtn", searchBtn);
		}
		if(startDate != null) {
			rttr.addFlashAttribute("startDate", startDate);
		}
		if(endDate != null) {
			rttr.addFlashAttribute("endDate", endDate);
		}
		
		if(vo.getAuditquantity() == 0) {
			logger.debug(" 검수량 0개 불가 ");
			rttr.addFlashAttribute("auditQuantity", "zero");
			return "redirect:/quality/qualities";
		}
		
		// 검수자 입력 (멤버코드)
		vo.setAuditbycode(session.getAttribute("membercode").toString());
		
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
			
			if((double) vo.getDefectquantity() / vo.getProductquantity() >= 0 && (double) vo.getDefectquantity() / vo.getProductquantity() <= 0.3) { // 생산 검수 - 정상 [불량 비율 : 0.3 (30%)]
				vo.setReprocessmethod("정상");
				vo.setReturnstatus("완료");
				vo.setReturninfo("재등록");
				qService.returnsQualityid(vo);
			}else { // 생산 검수 - 불량
				vo.setReprocessmethod("불량");
				vo.setReturnstatus("완료");
				vo.setReturninfo("폐기");
				qService.returnsQualityid(vo);
			}
			
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
		rttr.addFlashAttribute("AUDIT", "O");
		return "redirect:/quality/qualities";
	}
	
	// 자재 검수 입력 처리 - POST
	@PostMapping(value = "/materialAudit")
	public String materialQualityAuditPOST(QualityVO vo, RedirectAttributes rttr, Criteria cri, HttpSession session) throws Exception{
		if(vo.getAuditquantity() == 0) {
			logger.debug(" 검수량 0개 불가 ");
			rttr.addFlashAttribute("auditQuantity", "zero");
			return "redirect:/quality/qualities";
		}
		
		// 검수자 입력 (멤버코드)
		vo.setAuditbycode(session.getAttribute("membercode").toString());
		
		int result = 0;
		if(vo.getProductquantity() == vo.getAuditquantity()) { // 생산량 = 검수량 ("검수완료")
			vo.setAuditstatus("검수완료");
			
			// 검수코드 생성
			if(vo.getAuditcode().equals("")) {
			LocalDateTime now = LocalDateTime.now();
			String fmt = "yyMMddHHmmss";
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern(fmt);
			String dateTime = now.format(dtf);
			vo.setAuditcode("QM" + dateTime);
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
			vo.setAuditcode("QM" + dateTime);
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
			return "redirect:/quality/qualitiesMaterial";
		}
		logger.debug(" 검수 성공 ");
		qService.returnsQualityid(vo);
		rttr.addFlashAttribute("AUDIT", "O");
		return "redirect:/quality/qualitiesMaterial";
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
	
	// 불량 현황 입력 처리 (자재) - POST
	@PostMapping(value = "/materialNewDefect")
	public String materialQualityNewDefectPOST(QualityVO vo, RedirectAttributes rttr) throws Exception{
		
		int result = qService.produceReturnDefects(vo);
		if(result == 0) {
			logger.debug(" 불량 현황 입력 실패 ");
			rttr.addFlashAttribute("DEFECT", "X");
			return "redirect:/quality/qualitiesMaterial";
		}
		logger.debug(" 불량 현황 입력 성공 ");
		// 품질 관리에서 불량 등록 여부 업데이트
		qService.registerDefectY(vo);
		rttr.addFlashAttribute("DEFECT", "O");
		return "redirect:/quality/qualitiesMaterial";
	}
	
	// 포장, 반품이 아닐 때 생산 상태 업데이트 - POST
	@PostMapping
	public String updateQualityCheck(QualityVO vo) throws Exception{
		logger.debug(" /updateQualityCheck(QualityVO vo) 실행! ");
		System.out.println(" /updateQualityCheck(QualityVO vo) 실행! ");
		vo.setQualitycheck("정상");
		qService.productQualityCheck(vo);
		sService.registerStockY(vo);
		return "redirect:/quality/qualities";
	}
	
	// roastedBean 검수 / 불량 업데이트 - POST
	@PostMapping(value = "/roastedBeanDefect")
	public String roastedBeanDefect(QualityVO vo, HttpSession session, RedirectAttributes rttr, @ModelAttribute("page") Integer page, 
			@ModelAttribute("searchBtn") String searchBtn, @ModelAttribute("startDate") String startDate, @ModelAttribute("endDate") String endDate) throws Exception{
		// 페이지 유지를 위한 페이지 정보 가져오기
		rttr.addFlashAttribute("page", page);
		
		if(searchBtn != null) {
			rttr.addFlashAttribute("searchBtn", searchBtn);
		}
		if(startDate != null) {
			rttr.addFlashAttribute("startDate", startDate);
		}
		if(endDate != null) {
			rttr.addFlashAttribute("endDate", endDate);
		}
		
		qService.roastedBeanDefect(vo);
		// 검수자 입력 (멤버코드)
		vo.setAuditbycode(session.getAttribute("membercode").toString());
		
		int weight = vo.getWeight();
		int auditquantity = vo.getAuditquantity();
		int normalquantity = vo.getNormalquantity();
		int defectquantity = vo.getDefectquantity();
		
		vo.setAuditquantity(auditquantity + vo.getWeight()); // 검수량 변경 (기존 검수량 + 중량)
		
		int result = 0;
		if(vo.getDefect() != null && vo.getDefect().equals("Y")) { // 불량 있음
			
			if(vo.getProductquantity() == vo.getAuditquantity()) { // 검수 완료
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
				
				vo.setDefectquantity(defectquantity + weight);
				vo.setNormalquantity(vo.getAuditquantity() - vo.getDefectquantity());
				result = qService.productAuditFull(vo);
				
				
				if((double) vo.getDefectquantity() / vo.getProductquantity() >= 0 && (double) vo.getDefectquantity() / vo.getProductquantity() <= 0.3) { // 생산 검수 - 정상 [불량 비율 : 0.3 (30%)]
					vo.setQualitycheck("정상");
					qService.productQualityCheck(vo);
							
				}else { // 생산 검수 - 불량
					vo.setQualitycheck("불량");
					qService.productQualityCheck(vo);
				}
			
				
			}else { // 검수 중
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
				
				vo.setDefectquantity(defectquantity + weight);
				vo.setNormalquantity(vo.getAuditquantity() - vo.getDefectquantity());
				result = qService.produceAudit(vo);
			}
			
			
		}else { // 불량 없음
			if(vo.getProductquantity() == vo.getAuditquantity()) { // 검수 완료
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
				
				vo.setNormalquantity(normalquantity + weight);
				vo.setDefectquantity(vo.getAuditquantity() - vo.getNormalquantity());
				result = qService.productAuditFull(vo);
				
				if((double) vo.getDefectquantity() / vo.getProductquantity() >= 0 && (double) vo.getDefectquantity() / vo.getProductquantity() <= 0.3) { // 생산 검수 - 정상 [불량 비율 : 0.3 (30%)]
					vo.setQualitycheck("정상");
					qService.productQualityCheck(vo);
							
				}else { // 생산 검수 - 불량
					vo.setQualitycheck("불량");
					qService.productQualityCheck(vo);
				}

			}else { // 검수 중
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
				
				vo.setNormalquantity(normalquantity + weight);
				vo.setDefectquantity(vo.getAuditquantity() - vo.getNormalquantity());
				result = qService.produceAudit(vo);
			}
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
	
	// http://localhost:8088/quality/productQualityToast
	@GetMapping(value = "/productQualityToast")
	// 품질 관리 미완료 알림 토스트 (생산 + 반품)
	public void productQualityToast(Model model) throws Exception{
		model.addAttribute("productToast", qService.productQualityToast());
	}
	
	@GetMapping(value = "/materialQualityToast")
	// 품질 관리 미완료 알림 토스트 (자재)
	public void materalQualityToast(Model model) throws Exception{
		model.addAttribute("materialToast", qService.materialQualityToast());
	}
}
