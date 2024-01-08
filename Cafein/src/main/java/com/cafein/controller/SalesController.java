package com.cafein.controller;

import java.io.OutputStream;
import java.sql.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook; 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.Criteria;
import com.cafein.domain.PageVO;
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
	public String AllPOListGET(Model model, HttpSession session, SalesVO svo,Criteria cri
			) throws Exception{
		logger.debug("AllPOListGET() 실행");

		// SalesVO의 Criteria 설정
		svo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(sService.countPO(svo));
		logger.debug("총 개수: " + pageVO.getTotalCount());

		model.addAttribute("countPO",sService.countPO(svo));
		model.addAttribute("POList", sService.POList(svo));
		logger.debug("@@@postate"+svo.getPostate());
		logger.debug("@@@POList"+sService.POList(svo));
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("cliList", sService.registCli()); 
		model.addAttribute("iList", sService.registItem());  
		
		
		return "/sales/POList";
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
	public String cancelUpdate(SalesVO svo, @RequestParam("poid") int poid) throws Exception {
	    try {
	        logger.debug("/sales/cancelUpdate() 호출!");
	        svo.setPoid(poid);

	        logger.debug("수주상태 변경" + svo.getPostate());
	        logger.debug("@@@@ 수주id " + svo.getPoid());
	        sService.updatePOstate(svo);
	        logger.debug("수주상태 업데이트 성공!");
	    } catch (Exception e) {
	        logger.error("수주상태 업데이트 중 오류 발생:", e);
	    }
		return "redirect:/sales/POList";                                             
	}
	//수주상태 진행 변경
	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/ingUpdate", method = RequestMethod.POST)
	public String ingUpdate(SalesVO svo, @RequestParam("poid") int poid) throws Exception {
		try {
			logger.debug("/sales/ingUpdate() 호출!");
			svo.setPoid(poid);
			
			logger.debug("수주상태 변경" + svo.getPostate());
			logger.debug("@@@@ 수주id " + svo.getPoid());
			sService.ingUpdate(svo);
			logger.debug("수주상태 업데이트 성공!");
		} catch (Exception e) {
			logger.error("수주상태 업데이트 중 오류 발생:", e);
		}
		return "redirect:/sales/POList";                                             
	}
	/************************************************************************************************************/
	//리스트출력
	@GetMapping("/POListPrint") // 기호에 맞게 매핑하시면 됩니다
	public void POPrint(HttpServletResponse response, SalesVO svo) throws Exception { 
		// 메서드명도 기호에 맞게 바꾸시고 HttpServletResponse response만 매개변수로 반드시 받아주세요
		// 1. 테이블 데이터를 가져옵니다.
		List<SalesVO> list = sService.POListExcel(svo); // 서비스에서 리스트로 받아서 List<VO> 형태로 넣어주세요.
		logger.debug(" list : " + list); // 확인용 로그입니다.

		// 2. 엑셀 데이터로 변환합니다.
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
		
	    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가입니다. 쓰실 분만 쓰시면 됩니다.)
	    Row headerRow = (Row) sheet.createRow(0);
	    String[] headers = {"수주번호", "수주상태", "수주코드", "납품처코드-납품처명", "품목코드-품목명", "수량", "수주일자", "수정일자", "납품예정일", "담당자"};
	    
	    CellStyle headerStyle = workbook.createCellStyle();
	    headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); 
	    headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    
	    for (int i = 0; i < headers.length; i++) {
	        Cell cell = headerRow.createCell(i);
	        cell.setCellValue(headers[i]);
	        cell.setCellStyle(headerStyle);
	    }
	    // 첫 번째 행에 열의 헤더 추가

		int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작하시면 됩니다.
		for (SalesVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);

			int colNum = 0;
			// 컬럼 내용 추가 (vo의 Getter를 사용하시면 됩니다.)
			row.createCell(colNum++).setCellValue(vo2.getPoid());
			row.createCell(colNum++).setCellValue(vo2.getPostate());
			row.createCell(colNum++).setCellValue(vo2.getPocode());
			row.createCell(colNum++).setCellValue(vo2.getClientcode() + " - " + vo2.getClientname());
			sheet.setColumnWidth(colNum - 1, 20*256); 
			row.createCell(colNum++).setCellValue(vo2.getItemcode() + " - " + vo2.getItemname());
			sheet.setColumnWidth(colNum - 1, 20*256);  // 현재 열의 너비를 자동으로 조정
			row.createCell(colNum++).setCellValue(vo2.getPocnt());
			
			DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환입니다. 형식을 정하지 않으면 날짜가 제대로 표기되지 않습니다.
			CellStyle dateCellStyle = workbook.createCellStyle();
			dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));

			Cell registrationDateCell = row.createCell(colNum++);
			registrationDateCell.setCellValue(vo2.getOrdersdate()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
			registrationDateCell.setCellStyle(dateCellStyle);
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

			Cell updateDateCell = row.createCell(colNum++);
			updateDateCell.setCellValue(vo2.getUpdatedate()); // 위와 동일
			updateDateCell.setCellStyle(dateCellStyle);
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
			
			Cell OrdersdueDateCell = row.createCell(colNum++);
			OrdersdueDateCell.setCellValue(vo2.getOrdersduedate()); // 위와 동일
			OrdersdueDateCell.setCellStyle(dateCellStyle);
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

			row.createCell(colNum++).setCellValue(vo2.getMembercode());
			sheet.autoSizeColumn(colNum - 1);
		}
		
		String fileName = "수주 전체 리스트.xlsx"; // 저장하는 파일명입니다 (기호에 파일명 맞게 수정하시면 됩니다 [확장자만 xlsx])

		// 3. 엑셀 파일을 저장합니다.
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식입니다
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행됩니다
		
        OutputStream out = response.getOutputStream();
        workbook.write(out);
        out.flush();
        
        out.close();
        workbook.close();
	}

	/****************************************************************************************************************************************/

	
}
