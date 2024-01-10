package com.cafein.controller;

import java.io.OutputStream;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cafein.domain.Criteria;
import com.cafein.domain.PageVO;
import com.cafein.domain.ReturnVO;
import com.cafein.service.ReturnService;

@Controller
@RequestMapping(value = "/quality/*")
public class ReturnController {

	private static final Logger logger = LoggerFactory.getLogger(ReturnController.class);

	@Inject
	private ReturnService rService;
	
	// 반품 목록
	// http://localhost:8088/quality/returns
	@RequestMapping(value = "/returns", method = RequestMethod.GET)
	public void returnsGET(Model model, ReturnVO rvo,Criteria cri) throws Exception {

		logger.debug("returnsGET() 호출");
		
		PageVO vo = new PageVO();
		
		
		// 원자재,부자재 목록
		model.addAttribute("itList", rService.itList());

		
		if (rvo.getReturncode() != null || rvo.getReturnstatus() != null || rvo.getStartDate() != null || rvo.getReturntype() != null || rvo.getEndDate() != null ) {
			
			// 검색결과 페이징
			vo.setCri(cri);
			vo.setTotalCount(rService.returnPageCnt(rvo));
			logger.debug("총 개수: " + vo.getTotalCount());
			
			// 검색결과
			List<ReturnVO> returnList = rService.searchReturnsByCondition(rvo,cri);
			model.addAttribute("returnList", returnList);
			
			//페이징정보 저장
			model.addAttribute("vo", vo);
			// 검색정보 전달
			model.addAttribute("rvo", rvo);
		}

		else {
			
			// 전체결과 페이징
			vo.setCri(cri);
			vo.setTotalCount(rService.returnAllCnt());
			logger.debug("총 개수: " + vo.getTotalCount());
			
			// 전체결과
			List<ReturnVO> returnList = rService.searchReturns(cri);
			model.addAttribute("returnList", returnList);
			
			//페이징정보 저장
			model.addAttribute("vo", vo);
			// 검색정보 전달
			model.addAttribute("rvo", rvo);
			
		}
		
		
		
	}

	
	
	  // 반품 등록
	  @PostMapping(value = "/returnRegist") 
	  public String returnRegistPOST(ReturnVO rvo,  Model model) throws Exception{
	  
		  logger.debug("returnRegistPOST() 호출"); 
		  logger.debug("returnVO : "+rvo);
		  
		  // 반품 코드 저장
		  rvo.setReturncode(generateReturnCode(rvo));
		  
		  // 등록시 기본 설정
		  rvo.setReturnstatus("대기");
		  rvo.setReprocessmethod("검수중");
		  rvo.setReturninfo("확인중");
		  
		 rService.returnRegist(rvo); 
		  
		  
		  return "redirect:/quality/returns"; 
	  }
	  
	  

	// 반품코드 생성 메서드
	private String generateReturnCode(ReturnVO rvo) throws Exception {

		// 반품 유형에 따른 코드
		String typeCode = "";

		switch (rvo.getReturntype()) {
		case "원자재":
			typeCode = "MOT";
			break;
		case "부자재":
			typeCode = "SAT";
			break;
		case "완제품":
			typeCode = "PRO";
			break;
		// 다른 품목이 추가될 경우에도 처리 가능
		}

		// 반품 사유에 따른 코드
		String reasonCode = "";
		switch (rvo.getReturnReason()) {
		case "제품불량":
			reasonCode = "01";
			break;
		case "포장불량":
			reasonCode = "02";
			break;
		// 다른 사유가 추가될 경우에도 처리 가능
		}

		// 품목별 개수 + 100
		int num = 100 + rService.returnCount(rvo);

		// 3개를 합친 코드
		return typeCode + reasonCode + num;
	}

	
	
	//반품 수정
	@PostMapping(value = "/returnModify")
	public String returnModify(ReturnVO rvo) throws Exception{
		
		logger.debug(" returnModify(ReturnVO rvo) 호출@@@@@@@@@@@@@@@@@@@@@@"); 
		logger.debug("returnVO : "+rvo);
		
		
		// 수정 서비스
	     rService.returnModify(rvo);
		logger.debug("result",rvo);
		
		
		return "redirect:/quality/returns"; 
	}
	
	
	// 반품 삭제
	@PostMapping(value = "/returnDelete")
	public String returnDelete(@RequestParam("returnid") String returnid) throws Exception{
		
		logger.debug(" returnDelete(ReturnVO rvo) 호출 @@@@@@@@");
		logger.debug("returnid  : {}", returnid);
		
		int rvo = Integer.parseInt(returnid);
		
		rService.returnDelete(rvo);
		
		return "redirect:/quality/returns";
	}
	
	
	
	// 품질 관리 등록
	@PostMapping(value = "/addReturn")
	public String addReturn(@RequestParam("returnid") int returnid) throws Exception{
	
		logger.debug(" addReturn(returnid) 호출 @@@@@@@@");
		logger.debug("returnid  : {}", returnid);
	    
	    
		rService.addReturn(returnid);
		
		return "redirect:/quality/returns";
	}
	

	
	// 환불 날짜 등록
	@PostMapping(value = "/refund")
	public String refundDate(@RequestParam(value = "selectedReturnId", required = false) String[] selectedReturnIds) throws Exception {
		
		logger.debug("refundDate() 호출(환불날짜)");
		if(selectedReturnIds != null) {
		    for (String returnCode : selectedReturnIds) {
		    	logger.debug("returnCode  : {}", returnCode);
		    	rService.refundDate(returnCode);
		    }
		}
	    
	    return "redirect:/quality/returns";
	}
	
	// 반품 목록 (엑셀 파일 다운로드)
			@RequestMapping(value = "/returnListExcelDownload", method = RequestMethod.GET)
			public void itemListExcelDownload(HttpServletResponse response, ReturnVO rvo) throws Exception { 
				// 1. 테이블 데이터를 가져옴
				List<ReturnVO> list = rService.returnListExcel(rvo);
				logger.debug("list: " + list);

				// 2. 엑셀 데이터로 변환
				XSSFWorkbook workbook = new XSSFWorkbook();
				Sheet sheet = workbook.createSheet("sheet");
				
			    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가)
			    Row headerRow = sheet.createRow(0);
			    String[] headers = {"번호","반품코드","제품명", "품목", "수량", "반품상태","검수상태","반품정보"};
			    
			    CellStyle headerStyle = workbook.createCellStyle();
			    headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); 
			    headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);	    
			    
			    for (int i = 0; i < headers.length; i++) {
			        Cell cell = headerRow.createCell(i);
			        cell.setCellValue(headers[i]);
			        cell.setCellStyle(headerStyle);	        
			    }

				int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작
				for (ReturnVO rvo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
					Row row = sheet.createRow(rowNum++);

					int colNum = 0;
					// 컬럼 내용 추가 (rvo의 Getter를 사용)
					row.createCell(colNum++).setCellValue(rvo2.getReturnid());
					row.createCell(colNum++).setCellValue(rvo2.getReturncode());
					row.createCell(colNum++).setCellValue(rvo2.getReturnname());
					row.createCell(colNum++).setCellValue(rvo2.getReturntype());
					row.createCell(colNum++).setCellValue(rvo2.getReturnquantity());
					row.createCell(colNum++).setCellValue(rvo2.getReturnstatus());
					row.createCell(colNum++).setCellValue(rvo2.getReprocessmethod());
					row.createCell(colNum++).setCellValue(rvo2.getReturninfo());
					
					// 셀 크기 조정
					sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
				}
				
				String fileName = "ReturnList.xlsx"; // 저장하는 파일명

				// 3. 엑셀 파일을 저장합니다.
		        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식
		        response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행
				
		        OutputStream out = response.getOutputStream();
		        workbook.write(out);
		        out.flush();
		        
		        out.close();
		        workbook.close();
			}
	
	
	
}