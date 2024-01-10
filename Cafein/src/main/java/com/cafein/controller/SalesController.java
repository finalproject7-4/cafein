package com.cafein.controller;

import java.io.OutputStream;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
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
		model.addAttribute("membercode", session.getAttribute("membercode")); 
		
		
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
							RedirectAttributes rttr, HttpSession session,Model model) throws Exception {
		
		logger.debug("폼submit -> registPOST() 호출 ");                                 
		logger.debug(" svo : " + svo);                                               

		svo.setOrdersdate(Date.valueOf(ordersdate));
		svo.setOrdersduedate(Date.valueOf(ordersduedate));
		svo.setClientid(clientid);	                                         
		svo.setItemid(itemid);
		svo.setPocode(makePOcode(svo, model));
		model.addAttribute("membercode", session.getAttribute("membercode")); 
		
		sService.registPO(svo);                                                      
		logger.debug(" 글작성 완료! ");     
         
		rttr.addFlashAttribute("result", "CREATEOK");                                
	                                                                                 
		logger.debug("/sales/registPO 이동");                                          
		return "redirect:/sales/POList";                                             
	}        
	
	// 수주코드 생성 메서드
	public String makePOcode(SalesVO svo, Model model) throws Exception {
		model.addAttribute("pocode",sService.pocode(svo));

		String code = "";
           int count = sService.poCount(svo);

           String codePrefix = sService.pocode(svo);
		    DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyMMdd");
		    String datePart = LocalDate.now().format(dateFormat);
		 // countPart 계산
		    int countPart = count % 36; // 0~9까지는 숫자로, 10 이상은 A부터 Z까지의 알파벳으로 표현

		    // 최종 코드 생성
		    return codePrefix + datePart + convertToAlphabet(countPart);
		}

		// 10부터 A부터 Z까지의 알파벳으로 변환하는 메서드
		private String convertToAlphabet(int countPart) {
		    if (countPart < 10) {
		        return String.valueOf(countPart); // 0~9까지는 숫자 그대로 반환
		    } else {
		        // 10 이상부터 A부터 Z까지의 알파벳으로 변환
		        char alphabet = (char) ('A' + (countPart - 10));
		        return String.valueOf(alphabet);
		    }
		}
	
	// 수주 수정 - POST
	// http://localhost:8088/sales/POList
	@RequestMapping(method = RequestMethod.POST)
	public String modifyPOST(SalesVO svo, RedirectAttributes rttr,
			@RequestParam(value = "updatedate") String updatedate,
			@RequestParam(value = "poid") int poid,
			@RequestParam(value = "clientid") int clientid,
			@RequestParam(value = "itemid") int itemid
			, HttpSession session, Model model) throws Exception {
		logger.debug(" /modify form -> modifyPOST()");
		logger.debug(" 수정할 정보 " + svo);
		
		svo.setClientid(clientid);
		svo.setItemid(itemid);
		svo.setPoid(poid);
		svo.setUpdatedate(Date.valueOf(updatedate));
		model.addAttribute("membercode", session.getAttribute("membercode")); 

		// 서비스 - 정보수정 동작
		int result = sService.POModify(svo);
		rttr.addFlashAttribute("result", "modifyOK");
		logger.debug("result", result);
		return "redirect:/sales/POList";
	}
	
	//수주상태 취소 변경
	// http://localhost:8088/sales/POList
	@RequestMapping(value = "/cancelUpdate", method = RequestMethod.POST)
	public String cancelUpdate(SalesVO svo, @RequestParam("poid") int poid, 
			HttpSession session, Model model) throws Exception {
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
	    model.addAttribute("membercode", session.getAttribute("membercode")); 
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
	    String[] headers = {"번호", "진행상태", "수주코드", "납품처코드-납품처명", "품목코드-품목명", "수량", "수주일자", "수정일자", "납품예정일", "담당자"};
	    
	    CellStyle headerStyle = workbook.createCellStyle();
	    headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); 
	    headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    
	    // 중앙 정렬을 위한 스타일
	    CellStyle centerAlignStyle = workbook.createCellStyle();
	    centerAlignStyle.setAlignment(HorizontalAlignment.CENTER);
	    // 좌측 정렬을 위한 스타일
	    CellStyle leftAlignStyle = workbook.createCellStyle();
	    leftAlignStyle.setAlignment(HorizontalAlignment.LEFT);
	    
	    // 엑셀 데이터로 변환합니다.
	    for (int i = 0; i < headers.length; i++) {
	        Cell cell = headerRow.createCell(i);
	        cell.setCellValue(headers[i]);
	        if (i == 0) {
	            cell.setCellStyle(headerStyle);
//	            cell.setCellStyle(centerAlignStyle);
	        } else {
	            // 나머지 열은 색상만 적용
	            cell.setCellStyle(headerStyle);
	        }
	    }
	    
	    // 첫 번째 행에 열의 헤더 추가
		int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작하시면 됩니다.
		int countpoid=1;
		for (SalesVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);
			int colNum = 0;
			// 데이터 부분에 중앙 정렬 스타일 적용
			for (int i = 0; i < headers.length; i++) {
		        Cell dataCell = row.createCell(colNum);

		        CellStyle currentStyle;
		        if (i == 0) {
		            currentStyle = workbook.createCellStyle();
		            currentStyle.cloneStyleFrom(headerStyle);
		            currentStyle.setAlignment(centerAlignStyle.getAlignment());
		        } else {
		            currentStyle = leftAlignStyle; // 기본적으로 좌측 정렬 스타일을 적용

		            if (i == 1 || i == 5 || i == 9) {
		                // 1, 5, 9행에 대해서 중앙 정렬 스타일을 추가로 적용
		                currentStyle.setAlignment(centerAlignStyle.getAlignment());
		            }
		        }


		        
		        // 컬럼 내용 추가 (vo의 Getter를 사용하시면 됩니다.)
		        if (i == 0) {
		            dataCell.setCellValue(countpoid);
		            sheet.setColumnWidth(colNum, 5*256); // 열 너비 설정
		            countpoid++;
		        } else if (i == 1) {
		            dataCell.setCellValue(vo2.getPostate());
		        } else if (i == 2) {
		            dataCell.setCellValue(vo2.getPocode());
		            sheet.setColumnWidth(colNum, 15*256); // 열 너비 설정
		        } else if (i == 3) {
		            dataCell.setCellValue(vo2.getClientcode() + " - " + vo2.getClientname());
		            sheet.setColumnWidth(colNum, 20*256); // 열 너비 설정
		        } else if (i == 4) {
		            dataCell.setCellValue(vo2.getItemcode() + " - " + vo2.getItemname());
		            sheet.setColumnWidth(colNum, 25*256); // 열 너비 설정
		        } else if (i == 5) {
		            dataCell.setCellValue(vo2.getPocnt());
		            sheet.setColumnWidth(colNum, 5*256); 
		        } else if (i == 6 || i == 7 || i == 8) {
		            DataFormat dataFormat = workbook.createDataFormat();
		            CellStyle dateCellStyle = workbook.createCellStyle();
		            dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));

		            Cell dateCell = row.createCell(colNum);
		            dateCell.setCellValue(i == 6 ? vo2.getOrdersdate() : (i == 7 ? vo2.getUpdatedate() : vo2.getOrdersduedate()));
		            dateCell.setCellStyle(dateCellStyle);
		            sheet.autoSizeColumn(colNum);  // 현재 열의 너비를 자동으로 조정
		        } else if (i == 9) {
		            dataCell.setCellValue(vo2.getMembercode());
		        }
		        
		        colNum++;  // 셀을 생성한 후에 증가시켜 다음 열로 이동
		    }
		}

		
		String fileName = "POList.xlsx"; // 저장하는 파일명입니다 (기호에 파일명 맞게 수정하시면 됩니다 [확장자만 xlsx])

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
