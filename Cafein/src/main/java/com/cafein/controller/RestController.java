package com.cafein.controller;

import java.io.OutputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.QualityVO;
import com.cafein.service.ExcelService;
import com.cafein.service.QualityService;
import com.cafein.service.StockService;

@org.springframework.web.bind.annotation.RestController
public class RestController {
	
	// QualityService Import
	@Inject
	private QualityService qService;

	// StockService Import
	@Inject
	private StockService sService;

	// ExcelService Import (엑셀 출력용)
	@Inject
	private ExcelService eService;

	private static final Logger logger = LoggerFactory.getLogger(RestController.class);

	// 품질 관리 엑셀용 출력 목록 조회 (생산 + 반품)
	@GetMapping(value = "/productQualityPrint")
	public void productQualityPrintGET(HttpServletResponse response, QualityVO vo) throws Exception {
		// 1. 테이블 데이터를 가져옵니다.
		List<QualityVO> list = qService.qualityListSearchBtnExcel(vo); // 서비스에서 리스트로 받아서 List<VO> 형태로 넣어주세요.
		logger.debug(" list : " + list); // 확인용 로그입니다.

		// 2. 엑셀 데이터로 변환합니다.
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
		
	    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가입니다. 쓰실 분만 쓰시면 됩니다.)
	    Row headerRow = sheet.createRow(0);
	    String[] headers = {"품질관리번호", "검수번호", "상품구분", "생산/반품번호", "품목코드", "제품명", "검수자", "생산량", "검수량", "정상", "불량", "검수상태", "등록일", "검수완료일자"};
	    for (int i = 0; i < headers.length; i++) {
	        Cell cell = headerRow.createCell(i);
	        cell.setCellValue(headers[i]);
	    }
	    // 첫 번째 행에 열의 헤더 추가

		int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작하시면 됩니다.
		for (QualityVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);

			int colNum = 0;
			// 컬럼 내용 추가 (vo의 Getter를 사용하시면 됩니다.)
			row.createCell(colNum++).setCellValue(vo2.getQualityid());
			row.createCell(colNum++).setCellValue(vo2.getAuditcode());
			if(vo2.getItemtype() != null && vo2.getItemtype().equals("생산")) {
				row.createCell(colNum++).setCellValue(vo2.getItemtype() + " - " + vo2.getProduceprocess());
				row.createCell(colNum++).setCellValue(vo2.getProduceid());
			}else {
				row.createCell(colNum++).setCellValue(vo2.getItemtype());
				row.createCell(colNum++).setCellValue(vo2.getReturnid());
			}
			row.createCell(colNum++).setCellValue(vo2.getItemcode());
			row.createCell(colNum++).setCellValue(vo2.getItemname());
			row.createCell(colNum++).setCellValue(vo2.getAuditbycode());
			row.createCell(colNum++).setCellValue(vo2.getProductquantity());
			row.createCell(colNum++).setCellValue(vo2.getAuditquantity());
			row.createCell(colNum++).setCellValue(vo2.getNormalquantity());
			row.createCell(colNum++).setCellValue(vo2.getDefectquantity());
			row.createCell(colNum++).setCellValue(vo2.getAuditstatus());
			
			DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환입니다. 형식을 정하지 않으면 날짜가 제대로 표기되지 않습니다.
			CellStyle dateCellStyle = workbook.createCellStyle();
			dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));

			Cell registrationDateCell = row.createCell(colNum++);
			registrationDateCell.setCellValue(vo2.getRegisterationdate()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
			registrationDateCell.setCellStyle(dateCellStyle);
			
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

			Cell updateDateCell = row.createCell(colNum++);
			updateDateCell.setCellValue(vo2.getCompletedate()); // 위와 동일
			updateDateCell.setCellStyle(dateCellStyle);
			
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
			
		}
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		String fileName = "ProductQualityList" + dtf.format(now) + ".xlsx"; // 저장하는 파일 형식입니다 (기호에 맞게 수정하시면 됩니다 [확장자만 xlsx])

		// 3. 엑셀 파일을 저장합니다.
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식입니다
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행됩니다
		
        OutputStream out = response.getOutputStream();
        workbook.write(out);
        out.flush();
        
        out.close();
        workbook.close();
	}
	
	// 품질 관리 엑셀용 출력 목록 조회 (자재)
	@GetMapping(value = "/materialQualityPrint")
	public void materialQualityPrintGET(HttpServletResponse response, QualityVO vo) throws Exception {
		// 1. 테이블 데이터를 가져옵니다.
		List<QualityVO> list = qService.materialQualityListSearchBtnExcel(vo); // 서비스에서 리스트로 받아서 List<VO> 형태로 넣어주세요.
		logger.debug(" list : " + list); // 확인용 로그입니다.

		// 2. 엑셀 데이터로 변환합니다.
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
		
	    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가입니다. 쓰실 분만 쓰시면 됩니다.)
	    Row headerRow = sheet.createRow(0);
	    String[] headers = {"품질관리번호", "검수번호", "상품구분", "입고번호", "품목코드", "제품명", "검수자", "입고량", "검수량", "정상", "불량", "검수상태", "등록일", "검수완료일자"};
	    for (int i = 0; i < headers.length; i++) {
	        Cell cell = headerRow.createCell(i);
	        cell.setCellValue(headers[i]);
	    }
	    // 첫 번째 행에 열의 헤더 추가

		int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작하시면 됩니다.
		for (QualityVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);

			int colNum = 0;
			// 컬럼 내용 추가 (vo의 Getter를 사용하시면 됩니다.)
			row.createCell(colNum++).setCellValue(vo2.getQualityid());
			row.createCell(colNum++).setCellValue(vo2.getAuditcode());
			row.createCell(colNum++).setCellValue(vo2.getItemtype());
			row.createCell(colNum++).setCellValue(vo2.getReceiveid());
			row.createCell(colNum++).setCellValue(vo2.getItemcode());
			row.createCell(colNum++).setCellValue(vo2.getItemname());
			row.createCell(colNum++).setCellValue(vo2.getAuditbycode());
			row.createCell(colNum++).setCellValue(vo2.getProductquantity());
			row.createCell(colNum++).setCellValue(vo2.getAuditquantity());
			row.createCell(colNum++).setCellValue(vo2.getNormalquantity());
			row.createCell(colNum++).setCellValue(vo2.getDefectquantity());
			row.createCell(colNum++).setCellValue(vo2.getAuditstatus());
			
			DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환입니다. 형식을 정하지 않으면 날짜가 제대로 표기되지 않습니다.
			CellStyle dateCellStyle = workbook.createCellStyle();
			dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));

			Cell registrationDateCell = row.createCell(colNum++);
			registrationDateCell.setCellValue(vo2.getRegisterationdate()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
			registrationDateCell.setCellStyle(dateCellStyle);
			
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

			Cell updateDateCell = row.createCell(colNum++);
			updateDateCell.setCellValue(vo2.getCompletedate()); // 위와 동일
			updateDateCell.setCellStyle(dateCellStyle);
			
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
			
		}
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		String fileName = "MaterialQualityList" + dtf.format(now) + ".xlsx"; // 저장하는 파일 형식입니다 (기호에 맞게 수정하시면 됩니다 [확장자만 xlsx])

		// 3. 엑셀 파일을 저장합니다.
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식입니다
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행됩니다
		
        OutputStream out = response.getOutputStream();
        workbook.write(out);
        out.flush();
        
        out.close();
        workbook.close();
	}
	
	// 재고 엑셀용 출력 목록 조회 (생산 [포장] + 반품)
	@GetMapping("/productStockPrint")
	public void productStockPrintGET(HttpServletResponse response, QualityVO vo) throws Exception {
		// 1. 테이블 데이터를 가져옵니다.
		List<QualityVO> list = sService.stockListExcel(vo); // 서비스에서 리스트로 받아서 List<VO> 형태로 넣어주세요.
		logger.debug(" list : " + list); // 확인용 로그입니다.

		// 2. 엑셀 데이터로 변환합니다.
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
		
	    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가입니다. 쓰실 분만 쓰시면 됩니다.)
	    Row headerRow = sheet.createRow(0);
	    String[] headers = {"재고번호", "상품구분", "품목코드", "품목명", "생산번호", "중량", "재고량", "창고명", "최종 작업자", "등록일", "변경일", "최종 변경 내역"};
	    for (int i = 0; i < headers.length; i++) {
	        Cell cell = headerRow.createCell(i);
	        cell.setCellValue(headers[i]);
	    }
	    // 첫 번째 행에 열의 헤더 추가

		int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작하시면 됩니다.
		for (QualityVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);

			int colNum = 0;
			// 컬럼 내용 추가 (vo의 Getter를 사용하시면 됩니다.)
			row.createCell(colNum++).setCellValue(vo2.getStockid());
			row.createCell(colNum++).setCellValue(vo2.getItemtype());
			row.createCell(colNum++).setCellValue(vo2.getItemcode());
			row.createCell(colNum++).setCellValue(vo2.getItemname());
			row.createCell(colNum++).setCellValue(vo2.getProduceid());
			row.createCell(colNum++).setCellValue(vo2.getWeight());
			row.createCell(colNum++).setCellValue(vo2.getStockquantity());
			row.createCell(colNum++).setCellValue(vo2.getStoragecode() + " - " + vo2.getStoragename());
			row.createCell(colNum++).setCellValue(vo2.getWorkerbycode());
			
			DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환입니다. 형식을 정하지 않으면 날짜가 제대로 표기되지 않습니다.
			CellStyle dateCellStyle = workbook.createCellStyle();
			dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));

			Cell registrationDateCell = row.createCell(colNum++);
			registrationDateCell.setCellValue(vo2.getRegisterationdate()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
			registrationDateCell.setCellStyle(dateCellStyle);
			
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

			Cell updateDateCell = row.createCell(colNum++);
			updateDateCell.setCellValue(vo2.getUpdatedate()); // 위와 동일
			updateDateCell.setCellStyle(dateCellStyle);
			
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
			
			row.createCell(colNum++).setCellValue(vo2.getUpdatehistory());
		}
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		String fileName = "ProductStockList" + dtf.format(now) + ".xlsx"; // 저장하는 파일 형식입니다 (기호에 맞게 수정하시면 됩니다 [확장자만 xlsx])

		// 3. 엑셀 파일을 저장합니다.
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식입니다
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행됩니다
		
        OutputStream out = response.getOutputStream();
        workbook.write(out);
        out.flush();
        
        out.close();
        workbook.close();
	}


	// 재고 엑셀용 출력 목록 조회 (자재)
	@GetMapping(value = "/materialStockPrint")
	public void materialStockPrintGET(HttpServletResponse response, QualityVO vo) throws Exception {
		// 1. 테이블 데이터를 가져옵니다.
		List<QualityVO> list = sService.materialStockListExcel(vo); // 서비스에서 리스트로 받아서 List<VO> 형태로 넣어주세요.
		logger.debug(" list : " + list); // 확인용 로그입니다.

		// 2. 엑셀 데이터로 변환합니다.
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
		
	    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가입니다. 쓰실 분만 쓰시면 됩니다.)
	    Row headerRow = sheet.createRow(0);
	    String[] headers = {"재고번호", "상품구분", "품목코드", "품목명", "입고번호", "재고량", "창고명", "최종 작업자", "등록일", "변경일", "최종 변경 내역"};
	    for (int i = 0; i < headers.length; i++) {
	        Cell cell = headerRow.createCell(i);
	        cell.setCellValue(headers[i]);
	    }
	    // 첫 번째 행에 열의 헤더 추가

		int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작하시면 됩니다.
		for (QualityVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);

			int colNum = 0;
			// 컬럼 내용 추가 (vo의 Getter를 사용하시면 됩니다.)
			row.createCell(colNum++).setCellValue(vo2.getStockid());
			row.createCell(colNum++).setCellValue(vo2.getItemtype());
			row.createCell(colNum++).setCellValue(vo2.getItemcode());
			row.createCell(colNum++).setCellValue(vo2.getItemname());
			row.createCell(colNum++).setCellValue(vo2.getReceiveid());
			row.createCell(colNum++).setCellValue(vo2.getStockquantity());
			row.createCell(colNum++).setCellValue(vo2.getStoragecode() + " - " + vo2.getStoragename());
			row.createCell(colNum++).setCellValue(vo2.getWorkerbycode());
			
			DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환입니다. 형식을 정하지 않으면 날짜가 제대로 표기되지 않습니다.
			CellStyle dateCellStyle = workbook.createCellStyle();
			dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));

			Cell registrationDateCell = row.createCell(colNum++);
			registrationDateCell.setCellValue(vo2.getRegisterationdate()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
			registrationDateCell.setCellStyle(dateCellStyle);
			
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

			Cell updateDateCell = row.createCell(colNum++);
			updateDateCell.setCellValue(vo2.getUpdatedate()); // 위와 동일
			updateDateCell.setCellStyle(dateCellStyle);
			
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
			
			row.createCell(colNum++).setCellValue(vo2.getUpdatehistory());
		}
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		String fileName = "MaterialStockList" + dtf.format(now) + ".xlsx"; // 저장하는 파일 형식입니다 (기호에 맞게 수정하시면 됩니다 [확장자만 xlsx])

		// 3. 엑셀 파일을 저장합니다.
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식입니다
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행됩니다
		
        OutputStream out = response.getOutputStream();
        workbook.write(out);
        out.flush();
        
        out.close();
        workbook.close();
	}
	
	// 불량 현황 엑셀용 출력 목록 조회 (생산 + 반품)
	@GetMapping(value = "/productDefectPrint")
	public void productDefectPrintGET(HttpServletResponse response, QualityVO vo) throws Exception {
		// 1. 테이블 데이터를 가져옵니다.
		List<QualityVO> list = qService.defectsListSearchBtnExcel(vo); // 서비스에서 리스트로 받아서 List<VO> 형태로 넣어주세요.
		logger.debug(" list : " + list); // 확인용 로그입니다.

		// 2. 엑셀 데이터로 변환합니다.
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
		
	    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가입니다. 쓰실 분만 쓰시면 됩니다.)
	    Row headerRow = sheet.createRow(0);
	    String[] headers = {"불량번호", "품질관리번호", "상품구분", "품목코드", "제품명", "중량 (g)", "불량", "불량사유", "처리방식", "등록일"};
	    for (int i = 0; i < headers.length; i++) {
	        Cell cell = headerRow.createCell(i);
	        cell.setCellValue(headers[i]);
	    }
	    // 첫 번째 행에 열의 헤더 추가

		int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작하시면 됩니다.
		for (QualityVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);

			int colNum = 0;
			// 컬럼 내용 추가 (vo의 Getter를 사용하시면 됩니다.)
			row.createCell(colNum++).setCellValue(vo2.getDefectid());
			row.createCell(colNum++).setCellValue(vo2.getQualityid());
			row.createCell(colNum++).setCellValue(vo2.getItemtype());
			row.createCell(colNum++).setCellValue(vo2.getItemcode());
			row.createCell(colNum++).setCellValue(vo2.getItemname());
			row.createCell(colNum++).setCellValue(vo2.getWeight());
			row.createCell(colNum++).setCellValue(vo2.getDefectquantity());
			row.createCell(colNum++).setCellValue(vo2.getDefecttype());
			row.createCell(colNum++).setCellValue(vo2.getProcessmethod());
			
			DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환입니다. 형식을 정하지 않으면 날짜가 제대로 표기되지 않습니다.
			CellStyle dateCellStyle = workbook.createCellStyle();
			dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));

			Cell registrationDateCell = row.createCell(colNum++);
			registrationDateCell.setCellValue(vo2.getRegisterationdate()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
			registrationDateCell.setCellStyle(dateCellStyle);
			
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

		}
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		String fileName = "ProductDefectList" + dtf.format(now) + ".xlsx"; // 저장하는 파일 형식입니다 (기호에 맞게 수정하시면 됩니다 [확장자만 xlsx])

		// 3. 엑셀 파일을 저장합니다.
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식입니다
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행됩니다
		
        OutputStream out = response.getOutputStream();
        workbook.write(out);
        out.flush();
        
        out.close();
        workbook.close();
	}
	
	// 불량 현황 엑셀용 출력 목록 조회 (자재)
		@GetMapping(value = "/materialDefectPrint")
		public void materialDefectPrintGET(HttpServletResponse response, QualityVO vo) throws Exception {
			// 1. 테이블 데이터를 가져옵니다.
			List<QualityVO> list = qService.materialDefectsListSearchBtnExcel(vo); // 서비스에서 리스트로 받아서 List<VO> 형태로 넣어주세요.
			logger.debug(" list : " + list); // 확인용 로그입니다.

			// 2. 엑셀 데이터로 변환합니다.
			XSSFWorkbook workbook = new XSSFWorkbook();
			Sheet sheet = workbook.createSheet("sheet");
			
		    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가입니다. 쓰실 분만 쓰시면 됩니다.)
		    Row headerRow = sheet.createRow(0);
		    String[] headers = {"불량번호", "품질관리번호", "상품구분", "품목코드", "제품명", "불량", "불량사유", "처리방식", "등록일"};
		    for (int i = 0; i < headers.length; i++) {
		        Cell cell = headerRow.createCell(i);
		        cell.setCellValue(headers[i]);
		    }
		    // 첫 번째 행에 열의 헤더 추가

			int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작하시면 됩니다.
			for (QualityVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
				Row row = sheet.createRow(rowNum++);

				int colNum = 0;
				// 컬럼 내용 추가 (vo의 Getter를 사용하시면 됩니다.)
				row.createCell(colNum++).setCellValue(vo2.getDefectid());
				row.createCell(colNum++).setCellValue(vo2.getQualityid());
				row.createCell(colNum++).setCellValue(vo2.getItemtype());
				row.createCell(colNum++).setCellValue(vo2.getItemcode());
				row.createCell(colNum++).setCellValue(vo2.getItemname());
				row.createCell(colNum++).setCellValue(vo2.getDefectquantity());
				row.createCell(colNum++).setCellValue(vo2.getDefecttype());
				row.createCell(colNum++).setCellValue(vo2.getProcessmethod());
				
				DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환입니다. 형식을 정하지 않으면 날짜가 제대로 표기되지 않습니다.
				CellStyle dateCellStyle = workbook.createCellStyle();
				dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));

				Cell registrationDateCell = row.createCell(colNum++);
				registrationDateCell.setCellValue(vo2.getRegisterationdate()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
				registrationDateCell.setCellStyle(dateCellStyle);
				
				// 셀 크기 조정
				sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

			}
			
			LocalDate now = LocalDate.now();
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
			String fileName = "MaterialDefectList" + dtf.format(now) + ".xlsx"; // 저장하는 파일 형식입니다 (기호에 맞게 수정하시면 됩니다 [확장자만 xlsx])

			// 3. 엑셀 파일을 저장합니다.
	        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식입니다
	        response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행됩니다
			
	        OutputStream out = response.getOutputStream();
	        workbook.write(out);
	        out.flush();
	        
	        out.close();
	        workbook.close();
		}
		
		// roastedBean AJAX 정보 호출용
		@GetMapping(value = "/roastedBeanInfo")
		public QualityVO roastedBeanInfoGET(@ModelAttribute("lotnumber") String lotnumber) throws Exception {
			logger.debug(" roastedBeanInfo() 호출 ");
			return sService.roastedBeanInfo(lotnumber);
		}
		
		// roastedBean lotnumber AJAX 정보 호출용
		@GetMapping(value = "/roastedBeanLot")
		public List<QualityVO> roastedBeanLotGET(@ModelAttribute("produceid") int produceid) throws Exception {
			logger.debug(" roastedBeanLot() 호출 ");
			return sService.roastedBeanLot(produceid);
		}
		
		// receive AJAX 정보 호출용
		@GetMapping(value = "/receiveInfo")
		public QualityVO receiveInfoGET(@ModelAttribute("receiveid") String receiveid) throws Exception {
			logger.debug(" receiveInfo() 호출 ");
			return sService.receiveInfo(receiveid);
		}
		
		// 정상 LOT번호 AJAX 정보 호출용
		@GetMapping(value = "/normalLot")
		public List<QualityVO> normalLotGET(QualityVO vo) throws Exception{
			int produceid = vo.getProduceid();
			logger.debug(" produceid : " + produceid);
			
			int receiveid = vo.getReceiveid();
			logger.debug(" receiveid : " + receiveid);
			
			return sService.normalLot(vo);
		}
		
		// roastedBean 검수 / 불량 업데이트 - POST
		@PostMapping(value = "/roastedBeanDefect")
		public void roastedBeanDefect(QualityVO vo, HttpSession session) throws Exception{
			qService.roastedBeanDefect(vo);
			
			int auditbycode = (int) session.getAttribute("membercode");
			
			// 검수자 입력 (멤버코드)
			vo.setAuditbycode(auditbycode);
			
			int weight = vo.getWeight();
			int auditquantity = vo.getAuditquantity();
			int normalquantity = vo.getNormalquantity();
			int defectquantity = vo.getDefectquantity();
			
			// vo.setAuditquantity(auditquantity + vo.getWeight()); // 검수량 변경 (기존 검수량 + 중량)
			
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
					
					// vo.setDefectquantity(defectquantity + weight);
					// vo.setNormalquantity(vo.getAuditquantity() - vo.getDefectquantity());
					qService.productAuditFull(vo);
					
					
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
					
					// vo.setDefectquantity(defectquantity + weight);
					// vo.setNormalquantity(vo.getAuditquantity() - vo.getDefectquantity());
					qService.produceAudit(vo);
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
					
					// vo.setNormalquantity(normalquantity + weight);
					// vo.setDefectquantity(vo.getAuditquantity() - vo.getNormalquantity());
					qService.productAuditFull(vo);
					
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
					
					// vo.setNormalquantity(normalquantity + weight);
					// vo.setDefectquantity(vo.getAuditquantity() - vo.getNormalquantity());
					qService.produceAudit(vo);
				}
			}
		}	
}
