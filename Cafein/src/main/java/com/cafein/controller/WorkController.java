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

import com.cafein.domain.Criteria;
import com.cafein.domain.PageVO;
import com.cafein.domain.SalesVO;
import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;
import com.cafein.service.ShipService;

@Controller
@RequestMapping(value = "/production/*")
public class WorkController {

	private static final Logger logger = LoggerFactory.getLogger(ShipController.class);

	@Inject
	private ShipService shService;
	
	// 작업지시 조회
	// http://localhost:8088/production/WKList
	@RequestMapping(value = "/WKList", method = RequestMethod.GET)
	public String AllWKListGET(Model model, WorkVO wvo, HttpSession session, Criteria cri) throws Exception {
		logger.debug("AllWKListGET() 실행");
		
		// SalesVO의 Criteria 설정
		wvo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(shService.countWK(wvo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		List<WorkVO> WKList = shService.AllWKList(wvo);
		
		model.addAttribute("countWK",shService.countWK(wvo));
		model.addAttribute("WKList", WKList );
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("pcList", shService.registPC()); 
		model.addAttribute("mcList", shService.registMC());
		model.addAttribute("membercode", session.getAttribute("membercode"));
		
		logger.debug("작업지시 리스트 출력!");
		
		return "/production/WKList";
	}
	
	
	// 작업지시 등록 - POST
	// http://localhost:8088/production/WKList
	@RequestMapping(value = "/registWK", method = RequestMethod.POST)
	public String registWK(WorkVO wvo, ShipVO svo, HttpSession session, Model model,
			@RequestParam(value = "workdate1") String workdate1) 
										throws Exception {
		
		logger.debug("registWK() 호출 ");                                 
		logger.debug(" wvo : " + wvo);  
		wvo.setWorkcode(makeWKcode(wvo));
		wvo.setWorkdate1(Date.valueOf(workdate1));
		
		model.addAttribute("membercode", session.getAttribute("membercode"));
		
		shService.registWK(wvo);                                                      
		logger.debug(" 작업지시 등록 완료! ");     
                                     	
	                                                                                 
		logger.debug("/production/registWK 이동");                                          
		return "redirect:/production/WKList";                                             
	}
	
	// 출하 코드 생성 메서드
		public String makeSHcode(ShipVO svo) throws Exception {
		    // DB에서 전체 작업 수 조회
		    int count = shService.shCount(svo);

		    String codePrefix = "SH";
		    DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyMMdd");
		    String datePart = LocalDate.now().format(dateFormat);
		    String countPart = String.format("%04d", count + 1); // 4자리 숫자로 포맷팅

		    // 최종 코드 생성
		    return codePrefix + datePart + countPart;
		}

	// 작업 지시 코드 생성 메서드
	public String makeWKcode(WorkVO wvo) throws Exception {
	    // DB에서 전체 작업 수 조회
	    int count = shService.wkCount(wvo);

	    // 작업 코드 형식 설정
	    String codePrefix = "WK";
	    DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyMMdd");
	    String datePart = LocalDate.now().format(dateFormat);
	    String countPart = String.format("%04d", count + 1); // 4자리 숫자로 포맷팅

	    // 최종 코드 생성
	    return codePrefix + datePart + countPart;
	}
	
	// 작업지시 수정 - POST
	// http://localhost:8088/production/WKList
	@RequestMapping(value = "/modifyWK", method = RequestMethod.POST)
	public String modifyPOST(WorkVO wvo, ShipVO svo, HttpSession session, Model model) throws Exception {
		logger.debug(" /modify form -> modifyPOST()");
		logger.debug(" 수정할 정보 " + wvo);

		// 출하 등록 조건 검사
	    if ("진행".equals(wvo.getWorksts())) {
	        svo.setShipdate1(wvo.getWorkdate1());
	        svo.setShipcode(makeSHcode(svo));
	        svo.setWorkcode(wvo.getWorkcode());
	        svo.setPocode(wvo.getPocode());
	        svo.setClientname(wvo.getClientname());
	        svo.setItemname(wvo.getItemname());
	        svo.setShipsts(wvo.getWorksts());
	        svo.setPocnt(wvo.getPocnt());
	        svo.setShipdate2(wvo.getWorkdate2());
	        svo.setMembercode(wvo.getMembercode());
	        shService.insertShipList(svo);
	        model.addAttribute("membercode", session.getAttribute("membercode")); 
	    }

		// 서비스 - 정보수정 동작
		int result = shService.WKModify(wvo);
		logger.debug("result", result);
		return "redirect:/production/WKList";
	}
	
	// 작업지시 삭제 - POST
		@RequestMapping(value = "/WKDelete", method = RequestMethod.POST)
		public String WKDelete(WorkVO wvo, HttpSession session, Model model) throws Exception {
			logger.debug("WKdelete() 호출");
			
			// 서비스
			shService.WKDelete(wvo);
			model.addAttribute("membercode", session.getAttribute("membercode")); 
			
			return "redirect:/production/WKList";
		}
		
		/************************************************************************************************************/
		//리스트출력
		@GetMapping("/WKListPrint") // 기호에 맞게 매핑하시면 됩니다
		public void WKPrint(HttpServletResponse response, WorkVO wvo) throws Exception { 
			// 메서드명도 기호에 맞게 바꾸시고 HttpServletResponse response만 매개변수로 반드시 받아주세요
			// 1. 테이블 데이터를 가져옵니다.
			List<WorkVO> list = shService.WKListExcel(wvo); // 서비스에서 리스트로 받아서 List<VO> 형태로 넣어주세요.
			logger.debug(" list : " + list); // 확인용 로그입니다.

			// 2. 엑셀 데이터로 변환합니다.
			XSSFWorkbook workbook = new XSSFWorkbook();
			Sheet sheet = workbook.createSheet("sheet");
			
		    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가입니다. 쓰실 분만 쓰시면 됩니다.)
		    Row headerRow = (Row) sheet.createRow(0);
		    String[] headers = {"작업지시번호", "작업지시일", "작업지시코드", "수주코드", "납품처명", "품목명", "지시수량", "지시상태", "완료일자", "담당자"};
		    
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
			for (WorkVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
				Row row = sheet.createRow(rowNum++);

				int colNum = 0;
				// 컬럼 내용 추가 (vo의 Getter를 사용하시면 됩니다.)
				DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환입니다. 형식을 정하지 않으면 날짜가 제대로 표기되지 않습니다.
				CellStyle dateCellStyle = workbook.createCellStyle();
				dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));
				
				row.createCell(colNum++).setCellValue(vo2.getWorkid());
				
				Cell registrationDateCell = row.createCell(colNum++);
				registrationDateCell.setCellValue(vo2.getWorkdate1()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
				registrationDateCell.setCellStyle(dateCellStyle);
				sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
				
				row.createCell(colNum++).setCellValue(vo2.getWorkcode());
				sheet.setColumnWidth(colNum - 1, 20*256);
				row.createCell(colNum++).setCellValue(vo2.getPocode());
				sheet.setColumnWidth(colNum - 1, 20*256);
				row.createCell(colNum++).setCellValue(vo2.getClientname());
				sheet.setColumnWidth(colNum - 1, 20*256); 
				row.createCell(colNum++).setCellValue(vo2.getItemname());
				sheet.setColumnWidth(colNum - 1, 20*256);  // 현재 열의 너비를 자동으로 조정
				row.createCell(colNum++).setCellValue(vo2.getPocnt());
				row.createCell(colNum++).setCellValue(vo2.getWorksts());
				
				Cell updateDateCell = row.createCell(colNum++);
				updateDateCell.setCellValue(vo2.getWorkdate2()); // 위와 동일
				updateDateCell.setCellStyle(dateCellStyle);
				sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

				row.createCell(colNum++).setCellValue(vo2.getMembername());
				sheet.setColumnWidth(colNum - 1, 20*256);
			}
			
			String fileName = "WorkList.xlsx"; // 저장하는 파일명입니다 (기호에 파일명 맞게 수정하시면 됩니다 [확장자만 xlsx])

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