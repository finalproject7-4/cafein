package com.cafein.controller;

import java.io.OutputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.Criteria;
import com.cafein.domain.OrdersVO;
import com.cafein.domain.PageVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;
import com.cafein.service.ClientService;
import com.cafein.service.ItemService;
import com.cafein.service.MaterialService;

@Controller
@RequestMapping(value = "/material/*")
public class MaterialController {

	private static final Logger logger = LoggerFactory.getLogger(MaterialController.class);

	@Inject
	private MaterialService materService;
	
	@Inject
	private ClientService cService;
	
	@Inject
	private ItemService iService;
	
	// http://localhost:8088/material/orders
	// 발주 목록 - GET
	@RequestMapping(value = "/orders", method = RequestMethod.GET)
	public void ordersList(HttpSession session, Model model, OrdersVO vo, Criteria cri) throws Exception {
		logger.debug("ordersList() 호출");
		logger.debug("OrdersVO: " + vo);
		
		// OrdersVO의 Criteria 설정
		vo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(materService.ordersCount(vo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("membercode", session.getAttribute("membercode"));
		model.addAttribute("ordersList", materService.ordersList(vo));
		model.addAttribute("clientList", cService.clientList()); // 공급처 모달
		model.addAttribute("itemList", iService.itemList()); // 품목 모달
		model.addAttribute("pageVO", pageVO);
		
		// 연결된 뷰페이지로 이동
		logger.debug("/views/material/orders.jsp 페이지로 이동");
	}
	
	// 발주 등록 - POST
	@RequestMapping(value = "/orderRegist", method = RequestMethod.POST)
	public String orderRegist(OrdersVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {
		logger.debug("orderRegist() 호출");
		
		// 생성한 발주코드 저장
		vo.setOrderscode(generateOrdersCode());
		
		// 서비스
		materService.orderRegist(vo);
		
		// 등록 완료 시 뜨는 알림창 (정보 이동)
		rttr.addFlashAttribute("result1", "REGISTOK");
		
		return "redirect:/material/orders";
	} // orderRegist() 끝	
	
	// 발주코드 생성 메서드
	public String generateOrdersCode() throws Exception {
		
		String prefix = "OR";
		String datePart = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

		// 발주코드 개수 계산
		int counter = materService.orderscodeCount(datePart) + 1;

		String formattedCounter = String.format("%02d", counter);
		return prefix + datePart + formattedCounter;
	}
	
	// 발주 수정 - POST
	@RequestMapping(value = "/orderModify", method = RequestMethod.POST)
	public String orderModify(OrdersVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug("orderModify() 호출");
		
		// 서비스
		materService.orderModify(vo);
		
		// 수정 완료 시 뜨는 알림창 (정보 이동)
		rttr.addFlashAttribute("result2", "MODIFYOK");
		
		return "redirect:/material/orders";
	}
	
	// 발주 삭제 - POST
	@RequestMapping(value = "/orderDelete", method = RequestMethod.POST)
	public String orderDelete(OrdersVO vo) throws Exception {
		logger.debug("orderDelete() 호출");
		
		// 서비스
		materService.orderDelete(vo);
		
		return "redirect:/material/orders";
	}
	
	// 발주 목록 (엑셀 파일 다운로드) - GET
	@RequestMapping(value = "/orderListExcelDownload", method = RequestMethod.GET)
	public void orderListExcelDownload(HttpServletResponse response, OrdersVO vo) throws Exception { 
		// 1. 테이블 데이터를 가져옴
		List<OrdersVO> list = materService.orderListExcel(vo);
		logger.debug("list: " + list);
		
		// 2. 엑셀 데이터로 변환
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
				
		// 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가)
		Row headerRow = sheet.createRow(0);
		String[] headers = {"번호", "발주코드", "품목코드", "품명", "거래처", "발주수량", "발주금액(원)", "발주일자", "납기일자", "담당자"};

	    CellStyle headerStyle = workbook.createCellStyle();
	    headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); 
	    headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);	    		
		
		for (int i = 0; i < headers.length; i++) {
			Cell cell = headerRow.createCell(i);
			cell.setCellValue(headers[i]);
			cell.setCellStyle(headerStyle);	
		}

		int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작
		for (OrdersVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);

			int colNum = 0;
			// 컬럼 내용 추가 (vo의 Getter를 사용)
			row.createCell(colNum++).setCellValue(vo2.getOrdersid());
			row.createCell(colNum++).setCellValue(vo2.getOrderscode());
			row.createCell(colNum++).setCellValue(vo2.getItemcode());
			row.createCell(colNum++).setCellValue(vo2.getItemname());
			row.createCell(colNum++).setCellValue(vo2.getClientname());
			row.createCell(colNum++).setCellValue(vo2.getOrdersquantity());
			row.createCell(colNum++).setCellValue(vo2.getOrderprice());
					
			DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환
			CellStyle dateCellStyle = workbook.createCellStyle();
			dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));

			Cell registrationDateCell = row.createCell(colNum++);
			registrationDateCell.setCellValue(vo2.getOrdersdate()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
			registrationDateCell.setCellStyle(dateCellStyle);
					
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

			Cell updateDateCell = row.createCell(colNum++);
			updateDateCell.setCellValue(vo2.getDeliverydate()); // 위와 동일
			updateDateCell.setCellStyle(dateCellStyle);
			
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
		}
				
		String fileName = "OrderList.xlsx"; // 저장하는 파일명

		// 3. 엑셀 파일을 저장
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식
		response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행
				
		OutputStream out = response.getOutputStream();
		workbook.write(out);
		out.flush();
		        
		out.close();
		workbook.close();
	}
	
	// http://localhost:8088/material/receive
	// 입고 목록 - GET
	@RequestMapping(value = "/receive", method = RequestMethod.GET)
	public void receiveList(HttpSession session, Model model, ReceiveVO vo, Criteria cri) throws Exception {
		logger.debug("receiveList() 호출");
		
		// ReceiveVO의 Criteria 설정
		vo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(materService.receiveCount(vo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("membercode", session.getAttribute("membercode"));
		model.addAttribute("receiveList", materService.receiveList(vo));
		model.addAttribute("ordersList", materService.ordersList());
		model.addAttribute("storageList", materService.storageList());
		model.addAttribute("pageVO", pageVO);
				
		// 연결된 뷰페이지로 이동
		logger.debug("/views/material/receive.jsp 페이지로 이동");
	}
	
	// 입고 등록 - POST
	@RequestMapping(value = "/receiveRegist", method = RequestMethod.POST)
	public String receiveRegist(ReceiveVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {
		logger.debug("receiveRegist() 호출");

		// 생성한 입고코드 저장
		vo.setReceivecode(generateReceiveCode());
		
		// 생성한 LOT번호 저장
		vo.setLotnumber(generateLotNumber());
		
		// 서비스 - 입고 등록
		materService.receiveRegist(vo);
		
		// 등록 완료 시 뜨는 알림창 (정보 이동)
		rttr.addFlashAttribute("result1", "REGISTOK");
		
		return "redirect:/material/receive";
	}

	// 입고코드 생성 메서드
	public String generateReceiveCode() throws Exception {
		
		String prefix = "RC";
		String datePart = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

		// 입고코드 개수 계산
		int counter = materService.receivecodeCount(datePart) + 1;

		String formattedCounter = String.format("%02d", counter);
		return prefix + datePart + formattedCounter;
	}
	
	// LOT 번호 생성 메서드
	public String generateLotNumber() throws Exception {
		
        Random random = new Random();

        // 0부터 9999999999까지의 랜덤한 숫자 생성
        long randomNumber = (long) (random.nextDouble() * 10000000000L);

        // 생성된 숫자를 12자리 문자열로 변환
        String formattedNumber = String.format("%012d", randomNumber);

        // 문자열을 원하는 형태로 포맷팅
        String formattedPhoneNumber = formattedNumber.replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");

        return formattedPhoneNumber;
        
	}
	
	// 입고 수정 - POST
	@RequestMapping(value = "/receiveModify", method = RequestMethod.POST)
	public String receiveModify(ReceiveVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug("receiveModify() 호출");
		logger.debug("입고 상태: " + vo.getReceivestate());
				
		// 서비스
		// 입고상태가 대기일 경우 수정만 처리
		if(vo.getReceivestate().equals("대기")) {
			materService.receiveModify(vo);
		}
		
		// 입고상태가 완료일 경우 수정 후 품질관리에 입고 데이터 등록
		if(vo.getReceivestate().equals("완료")) {
			materService.receiveModify(vo);
			materService.qualityRegist(vo);
		}
		
		// 수정 완료 시 뜨는 알림창 (정보 이동)
		rttr.addFlashAttribute("result2", "MODIFYOK");
		
		return "redirect:/material/receive";
	}
	
	// 입고 삭제 - POST
	@RequestMapping(value = "/receiveDelete", method = RequestMethod.POST)
	public String receiveDelete(ReceiveVO vo) throws Exception {
		logger.debug("receiveDelete() 호출");
		
		// 서비스
		materService.receiveDelete(vo);
		
		return "redirect:/material/receive";
	}
	
	// 입고 목록 (엑셀 파일 다운로드) - GET
	@RequestMapping(value = "/receiveListExcelDownload", method = RequestMethod.GET)
	public void receiveListExcelDownload(HttpServletResponse response, ReceiveVO vo) throws Exception { 
		// 1. 테이블 데이터를 가져옴
		List<ReceiveVO> list = materService.receiveListExcel(vo);
		logger.debug("list: " + list);
		
		// 2. 엑셀 데이터로 변환
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
				
		// 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가)
		Row headerRow = sheet.createRow(0);
		String[] headers = {"번호", "입고코드", "발주코드", "품명", "입고수량", "입고일자", "LOT번호", "담당자"};

	    CellStyle headerStyle = workbook.createCellStyle();
	    headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); 
	    headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);	    		
		
		for (int i = 0; i < headers.length; i++) {
			Cell cell = headerRow.createCell(i);
			cell.setCellValue(headers[i]);
			cell.setCellStyle(headerStyle);	
		}

		int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작
		for (ReceiveVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);

			int colNum = 0;
			// 컬럼 내용 추가 (vo의 Getter를 사용)
			row.createCell(colNum++).setCellValue(vo2.getReceiveid());
			row.createCell(colNum++).setCellValue(vo2.getReceivecode());
			row.createCell(colNum++).setCellValue(vo2.getOrderscode());
			row.createCell(colNum++).setCellValue(vo2.getItemname());
			row.createCell(colNum++).setCellValue(vo2.getReceivequantity());
					
			DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환
			CellStyle dateCellStyle = workbook.createCellStyle();
			dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));

			Cell registrationDateCell = row.createCell(colNum++);
			registrationDateCell.setCellValue(vo2.getReceivedate()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
			registrationDateCell.setCellStyle(dateCellStyle);
					
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

			row.createCell(colNum++).setCellValue(vo2.getLotnumber());
			row.createCell(colNum++).setCellValue(vo2.getMembername());
			
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
		}
				
		String fileName = "ReceiveList.xlsx"; // 저장하는 파일명

		// 3. 엑셀 파일을 저장
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식
		response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행
				
		OutputStream out = response.getOutputStream();
		workbook.write(out);
		out.flush();
		        
		out.close();
		workbook.close();
	}	
	
	// 출고 목록 - GET
	@RequestMapping(value = "/releases", method = RequestMethod.GET)
	public void releasesList(HttpSession session, Model model, ReleasesVO vo, Criteria cri) throws Exception {
		logger.debug("releasesList() 호출");

		// ReleasesVO의 Criteria 설정
		vo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(materService.releasesCount(vo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("releasesCount", materService.releasesCount(vo));
		model.addAttribute("releasesList", materService.releasesList(vo));
		model.addAttribute("stockList",  materService.stockList());
		model.addAttribute("pageVO", pageVO);
				
		// 연결된 뷰페이지로 이동
		logger.debug("/views/material/releases.jsp 페이지로 이동");
	}

	// 출고 목록 (엑셀 파일 다운로드) - GET
	@RequestMapping(value = "/releaseListExcelDownload", method = RequestMethod.GET)
	public void releaseListExcelDownload(HttpServletResponse response, ReleasesVO vo) throws Exception { 
		// 1. 테이블 데이터를 가져옴
		List<ReleasesVO> list = materService.releaseListExcel(vo);
		logger.debug("list: " + list);
		
		// 2. 엑셀 데이터로 변환
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
				
		// 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가)
		Row headerRow = sheet.createRow(0);
		String[] headers = {"번호", "출고코드", "생산지시코드", "품명", "재고수량", "출고수량", "출고일자", "담당자"};

	    CellStyle headerStyle = workbook.createCellStyle();
	    headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); 
	    headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);	    		
		
		for (int i = 0; i < headers.length; i++) {
			Cell cell = headerRow.createCell(i);
			cell.setCellValue(headers[i]);
			cell.setCellStyle(headerStyle);	
		}

		int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작
		for (ReleasesVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);

			int colNum = 0;
			// 컬럼 내용 추가 (vo의 Getter를 사용)
			row.createCell(colNum++).setCellValue(vo2.getReleaseid());
			row.createCell(colNum++).setCellValue(vo2.getReleasecode());
			row.createCell(colNum++).setCellValue(vo2.getProducecode());
			row.createCell(colNum++).setCellValue(vo2.getItemname());
			row.createCell(colNum++).setCellValue(vo2.getStockquantity());
			row.createCell(colNum++).setCellValue(vo2.getReleasequantity());
					
			DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환
			CellStyle dateCellStyle = workbook.createCellStyle();
			dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));

			Cell registrationDateCell = row.createCell(colNum++);
			registrationDateCell.setCellValue(vo2.getReleasedate()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
			registrationDateCell.setCellStyle(dateCellStyle);
					
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

			row.createCell(colNum++).setCellValue(vo2.getMembername());
			
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
		}
				
		String fileName = "ReleaseList.xlsx"; // 저장하는 파일명

		// 3. 엑셀 파일을 저장
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식
		response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행
				
		OutputStream out = response.getOutputStream();
		workbook.write(out);
		out.flush();
		        
		out.close();
		workbook.close();
	}
	
	// 출고 수정 - POST
	@RequestMapping(value = "/releaseModify", method = RequestMethod.POST)
	public String releaseModify(ReleasesVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug("releaseModify() 호출");
				
		// 출고상태 완료로 변경 후 재고관리에 출고 데이터 등록
		materService.releaseModify(vo);
		materService.stockRegist(vo);
		
		// 수정 완료 시 뜨는 알림창 (정보 이동)
		rttr.addFlashAttribute("result", "MODIFYOK");
		
		return "redirect:/material/releases";
	}	
	
}
