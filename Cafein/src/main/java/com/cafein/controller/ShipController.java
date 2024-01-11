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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.Criteria;
import com.cafein.domain.PageVO;
import com.cafein.domain.SalesVO;
import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;
import com.cafein.service.ShipService;

@Controller
@RequestMapping(value = "/sales/*")
public class ShipController {

	private static final Logger logger = LoggerFactory.getLogger(ShipController.class);

	@Inject
	private ShipService shService;

	// 출하 조회
	// http://localhost:8088/sales/SHList
	@RequestMapping(value = "/SHList", method = RequestMethod.GET)
	public String AllSHListGET(Model model,ShipVO svo, HttpSession session, Criteria cri) throws Exception {
		logger.debug("AllSHListGET() 실행");
		
		// ShoipVO의 Criteria 설정
		svo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(shService.countSH(svo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		model.addAttribute("countSH",shService.countSH(svo));
		model.addAttribute("AllSHList", shService.AllSHList(svo));
		model.addAttribute("wcList", shService.registWC());
		model.addAttribute("mcList", shService.registMC());
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("membercode", session.getAttribute("membercode")); 
		
		logger.debug("@@@"+shService.registMC());
		logger.debug("출하 리스트 출력!");
		
		return "/sales/SHList";
	}
	
	// 출하 등록 - POST
	// http://localhost:8088/sales/SHList
	@RequestMapping(value = "/registSH", method = RequestMethod.POST)
	public String registSH(ShipVO svo, HttpSession session, Model model,
							@RequestParam(value = "shipdate1") String shipdate1,
							RedirectAttributes rttr
							) throws Exception {
		
		logger.debug("regist() 호출 ");                                 
		logger.debug(" svo : " + svo);                                               

		svo.setShipcode(makeSHcode(svo));
		svo.setShipdate1(Date.valueOf(shipdate1));	
		model.addAttribute("membercode", session.getAttribute("membercode")); 
		
		shService.registSH(svo);                                                      
		logger.debug(" 출하 등록 완료! ");                              
	                                                                                 
		logger.debug("/sales/registSH 이동");                                          
		return "redirect:/sales/SHList";                                             
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
	
	// 출하 수정 - POST
		// http://localhost:8088/sales/SHList
		@RequestMapping(value = "/modifySH", method = RequestMethod.POST)
		public String modifyPOST(ShipVO svo, HttpSession session, Model model) throws Exception {
			logger.debug(" /modify form -> modifyPOST()");
			logger.debug(" 수정할 정보 " + svo);
			
			model.addAttribute("membercode", session.getAttribute("membercode")); 

			// 서비스 - 정보수정 동작
			int result = shService.SHModify(svo);
			logger.debug("result", result);
			return "redirect:/sales/SHList";
		}

		
	//출하상태 완료 변경
		// http://localhost:8088/sales/SHList
		@RequestMapping(value = "/ingUpdate1", method = RequestMethod.POST)
		public String ingUpdate(ShipVO svo, WorkVO wvo, SalesVO ssvo, @RequestParam("shipid") int shipid,
				@RequestParam("workcode") String workcode, @RequestParam("pocode") String pocode,
				HttpSession session, Model model) throws Exception {

			logger.debug("/sales/ingUpdate1() 호출!");
			svo.setShipid(shipid);
			wvo.setWorkcode(workcode);
			ssvo.setPocode(pocode);
			
				
			// 출하 완료 시간 설정
			Date shipDate2 = new Date(System.currentTimeMillis());
		        svo.setShipdate2(shipDate2);
				
			logger.debug("출하상태 변경" + svo.getShipsts());
			logger.debug("@@@@ 출하id " + svo.getShipid());
			shService.ingUpdate(svo);
			logger.debug("출하상태 업데이트 성공!");
				
			model.addAttribute("membercode", session.getAttribute("membercode")); 

			logger.debug("작업지시상태 업데이트 성공!");

			// 작업지시 상태 완료로 업데이트
			wvo.setWorksts(svo.getShipsts());
			// 수주 상태 완료로 업데이트
			ssvo.setPostate(svo.getShipsts());
			
			// 작업지시 완료 시간 설정
			Date workDate2 = new Date(System.currentTimeMillis());
			wvo.setShipdate2(workDate2);
			
			logger.debug("updateCompletWork 메서드 호출 - 작업상태: " + wvo.getWorksts() + ", 작업코드: " + wvo.getWorkcode());
			shService.updateCompletWork(wvo);
			shService.updateCompletSale(ssvo);
			logger.debug("updateCompletWork 메서드 호출 완료!");
			
			
			return "redirect:/sales/SHList";                                             
		}
		
		

		
	// 실적 조회
	// http://localhost:8088/sales/PFList
	@RequestMapping(value = "/PFList", method = RequestMethod.GET)
	public void AllPFListGET(Model model, WorkVO wvo, HttpSession session, Criteria cri) throws Exception {
		logger.debug("AllPFListGET() 실행");
		
		// SalesVO의 Criteria 설정
		wvo.setCri(cri);
				
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(shService.countPF(wvo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		model.addAttribute("AllPFList", shService.AllPFList(wvo));
		model.addAttribute("mcList", shService.registMC());
		model.addAttribute("countPF",shService.countPF(wvo));
		model.addAttribute("pageVO", pageVO);
		logger.debug("실적 리스트 출력!");
	}
	
	// 실적 수정 - POST
	// http://localhost:8088/sales/SHList
	@RequestMapping(value = "/modifyPF", method = RequestMethod.POST)
	public String modifyPFPOST(WorkVO wvo) throws Exception {
		logger.debug(" /modify form -> modifyPOST()");
		logger.debug(" 수정할 정보 " + wvo);

		// 서비스 - 정보수정 동작
		int result = shService.PFModify(wvo);
		logger.debug("result", result);
		return "redirect:/sales/PFList";
	}
	
	/************************************************************************************************************/
	// 출하 리스트출력
	@GetMapping("/SHListPrint") // 기호에 맞게 매핑하시면 됩니다
	public void SHPrint(HttpServletResponse response, ShipVO svo) throws Exception { 
		// 메서드명도 기호에 맞게 바꾸시고 HttpServletResponse response만 매개변수로 반드시 받아주세요
		// 1. 테이블 데이터를 가져옵니다.
		List<ShipVO> list = shService.SHListExcel(svo); // 서비스에서 리스트로 받아서 List<VO> 형태로 넣어주세요.
		logger.debug(" list : " + list); // 확인용 로그입니다.

		// 2. 엑셀 데이터로 변환합니다.
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
		
	    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가입니다. 쓰실 분만 쓰시면 됩니다.)
	    Row headerRow = (Row) sheet.createRow(0);
	    String[] headers = {"출하번호", "출하일", "출하코드", "작업지시코드", "납품처명", "품목명", "출하량", "출하상태", "완료일자", "담당자"};
	    
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
		for (ShipVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);

			int colNum = 0;
			// 컬럼 내용 추가 (vo의 Getter를 사용하시면 됩니다.)
			DataFormat dataFormat = workbook.createDataFormat(); // 날짜 형식 변환입니다. 형식을 정하지 않으면 날짜가 제대로 표기되지 않습니다.
			CellStyle dateCellStyle = workbook.createCellStyle();
			dateCellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd"));
			
			row.createCell(colNum++).setCellValue(vo2.getShipid());
			
			Cell registrationDateCell = row.createCell(colNum++);
			registrationDateCell.setCellValue(vo2.getShipdate1()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
			registrationDateCell.setCellStyle(dateCellStyle);
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
			
			row.createCell(colNum++).setCellValue(vo2.getShipcode());
			sheet.setColumnWidth(colNum - 1, 20*256);
			row.createCell(colNum++).setCellValue(vo2.getWorkcode());
			sheet.setColumnWidth(colNum - 1, 20*256);
			row.createCell(colNum++).setCellValue(vo2.getClientname());
			sheet.setColumnWidth(colNum - 1, 20*256); 
			row.createCell(colNum++).setCellValue(vo2.getItemname());
			sheet.setColumnWidth(colNum - 1, 20*256);  // 현재 열의 너비를 자동으로 조정
			row.createCell(colNum++).setCellValue(vo2.getPocnt());
			row.createCell(colNum++).setCellValue(vo2.getShipsts());
			
			Cell updateDateCell = row.createCell(colNum++);
			updateDateCell.setCellValue(vo2.getShipdate2()); // 위와 동일
			updateDateCell.setCellStyle(dateCellStyle);
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정

			row.createCell(colNum++).setCellValue(vo2.getMembername());
			sheet.setColumnWidth(colNum - 1, 20*256);
		}
		
		String fileName = "ShipList.xlsx"; // 저장하는 파일명입니다 (기호에 파일명 맞게 수정하시면 됩니다 [확장자만 xlsx])

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

	/************************************************************************************************************/
	//리스트출력
	@GetMapping("/PFListPrint") // 기호에 맞게 매핑하시면 됩니다
	public void PFPrint(HttpServletResponse response, WorkVO wvo) throws Exception { 
		// 메서드명도 기호에 맞게 바꾸시고 HttpServletResponse response만 매개변수로 반드시 받아주세요
		// 1. 테이블 데이터를 가져옵니다.
		List<WorkVO> list = shService.PFListExcel(wvo); // 서비스에서 리스트로 받아서 List<VO> 형태로 넣어주세요.
		logger.debug(" list : " + list); // 확인용 로그입니다.

		// 2. 엑셀 데이터로 변환합니다.
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
		
	    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가입니다. 쓰실 분만 쓰시면 됩니다.)
	    Row headerRow = (Row) sheet.createRow(0);
	    String[] headers = {"작업지시번호", "작업지시완료일자", "작업지시코드", "납품처명", "품목명", "지시수량", "반품수량", "반품사유", "담당자"};
	    
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
			registrationDateCell.setCellValue(vo2.getWorkdate2()); // 날짜 데이터인 경우에는 위와 다르게 형식을 정하고 이렇게 넣으셔야 합니다.
			registrationDateCell.setCellStyle(dateCellStyle);
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
			
			row.createCell(colNum++).setCellValue(vo2.getWorkcode());
			sheet.setColumnWidth(colNum - 1, 20*256);
			row.createCell(colNum++).setCellValue(vo2.getClientname());
			sheet.setColumnWidth(colNum - 1, 20*256); 
			row.createCell(colNum++).setCellValue(vo2.getItemname());
			sheet.setColumnWidth(colNum - 1, 20*256);  // 현재 열의 너비를 자동으로 조정
			row.createCell(colNum++).setCellValue(vo2.getPocnt());
			row.createCell(colNum++).setCellValue(vo2.getReturncount());
			row.createCell(colNum++).setCellValue(vo2.getReturnreason());
			row.createCell(colNum++).setCellValue(vo2.getMembername());
			sheet.setColumnWidth(colNum - 1, 20*256);
		}
		
		String fileName = "PFList.xlsx"; // 저장하는 파일명입니다 (기호에 파일명 맞게 수정하시면 됩니다 [확장자만 xlsx])

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