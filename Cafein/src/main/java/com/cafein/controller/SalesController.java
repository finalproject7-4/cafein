package com.cafein.controller;

import java.io.OutputStream;
import java.sql.Date;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.Criteria;
import com.cafein.domain.PageVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.SalesVO;
import com.cafein.service.SalesService;

@Controller
@RequestMapping(value = "/sales/*")
public class SalesController {

	private static final Logger logger = LoggerFactory.getLogger(SalesController.class);

	@Inject
	private SalesService sService;

	// 수주조회 - GET
	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/POList", method = RequestMethod.GET)
	public String AllPOListGET(Model model,SalesVO svo,  Criteria cri
			) throws Exception{
		logger.debug("AllPOListGET() 실행");
		

		// SalesVO의 Criteria 설정
		svo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(sService.poCount(svo));
		logger.debug("총 개수: " + pageVO.getTotalCount());

		model.addAttribute("POList", sService.POList(svo));
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("cliList", sService.registCli()); 
		model.addAttribute("iList", sService.registItem());  
		
		
		return "/sales/POList";
	}
	
	//납품서
	// http://localhost:8088/sales/receipt
	@RequestMapping(value = "/receipt", method = RequestMethod.GET)
    public String showReceiptPage(Model model) throws Exception{
		logger.debug("showReceiptPage() 실행 ");
		
		List<SalesVO> receiptList = sService.receiptList();
		logger.debug(" @@@ " + receiptList);
		model.addAttribute("receiptList", receiptList);

        return "/sales/receipt";
    }
		
	// 수주등록 - POST
	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/registPO", method = RequestMethod.POST)
	public String registPOST(SalesVO svo, 
							@RequestParam(value = "ordersdate") String ordersdate,
							@RequestParam(value = "ordersduedate") String ordersduedate,
							@RequestParam(value = "clientid") int clientid,
							@RequestParam(value = "itemid") int itemid,
							RedirectAttributes rttr) throws Exception {
		
		logger.debug("폼submit -> registPOST() 호출 ");                                 
		logger.debug(" svo : " + svo);                                               

		svo.setOrdersdate(Date.valueOf(ordersdate));
		svo.setOrdersduedate(Date.valueOf(ordersduedate));
		svo.setClientid(clientid);	                                         
		svo.setItemid(itemid);
		svo.setPocode(makePOcode(svo));
		
		sService.registPO(svo);                                                      
		logger.debug(" 글작성 완료! ");     
         
		rttr.addFlashAttribute("result", "CREATEOK");                                
	                                                                                 
		logger.debug("/sales/registPO 이동");                                          
		return "redirect:/sales/POList";                                             
	}        
	
	// 품목코드 생성 메서드
	public String makePOcode(SalesVO svo) throws Exception {
		
		String code = "";
		int num = 1001 + sService.poCount(svo);
		
		switch(svo.getPostate()) {
			case "대기": code = "AL"; break;
			case "진행": code = "SK"; break;
			case "완료": code = "FJ"; break;
			case "취소": code = "GH"; break;
		}
		
		return code + num;
	}
	
	// 수주 수정 - POST
	// http://localhost:8088/sales/POList
	@RequestMapping(method = RequestMethod.POST)
	public String modifyPOST(SalesVO svo, RedirectAttributes rttr,
			@RequestParam(value = "updatedate") String updatedate,
			@RequestParam(value = "poid") int poid,
			@RequestParam(value = "clientid") int clientid,
			@RequestParam(value = "itemid") int itemid
			) throws Exception {
		logger.debug(" /modify form -> modifyPOST()");
		logger.debug(" 수정할 정보 " + svo);
		
		svo.setClientid(clientid);
		svo.setItemid(itemid);
		svo.setPoid(poid);
		svo.setUpdatedate(Date.valueOf(updatedate));


		// 서비스 - 정보수정 동작
		int result = sService.POModify(svo);
		rttr.addFlashAttribute("result", "modifyOK");
		logger.debug("result", result);
		return "redirect:/sales/POList";
	}
	
	//수주상태 취소 변경
	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/cancelUpdate", method = RequestMethod.POST)
	public void cancelUpdate(@RequestBody SalesVO svo) throws Exception {
	    try {
	        logger.debug("/sales/cancelUpdate() 호출!");
	        logger.debug("수주상태 변경" + svo.getPostate());
	        logger.debug("@@@@ 수주id " + svo.getPoid());
	        sService.updatePOstate(svo);
	        logger.debug("수주상태 업데이트 성공!");
	    } catch (Exception e) {
	        logger.error("수주상태 업데이트 중 오류 발생:", e);
	    }
	}


	
	
}
