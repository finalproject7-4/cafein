package com.cafein.controller;

import java.io.OutputStream;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafein.domain.Criteria;
import com.cafein.domain.ItemVO;
import com.cafein.domain.PageVO;
import com.cafein.service.ClientService;
import com.cafein.service.ItemService;

@Controller
@RequestMapping(value = "/information/*")
public class ItemController {

	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

	@Inject
	private ItemService iService;

	@Inject
	private ClientService cService;
	
	// http://localhost:8088/information/items
	// 품목 목록 - GET
	@RequestMapping(value = "/items", method = RequestMethod.GET)
	public void itemList(HttpSession session, Model model, ItemVO vo, Criteria cri) throws Exception {
		logger.debug("itemList() 호출");
		logger.debug("ItemVO: " + vo);
		
		session.getAttribute("membercode");
		
		// ItemVO의 Criteria 설정
		vo.setCri(cri);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(iService.itemCount(vo));
		logger.debug("총 개수: " + pageVO.getTotalCount());
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("itemList", iService.itemList(vo));
		model.addAttribute("clientList", cService.clientList());
		model.addAttribute("pageVO", pageVO);
				
		// 연결된 뷰페이지로 이동
		logger.debug("/views/information/items.jsp 페이지로 이동");
	}
	
	// 품목 등록 - POST
	@RequestMapping(value = "/itemRegist", method = RequestMethod.POST)
	public String itemRegist(ItemVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug("itemRegist() 호출");
		
		// 생성한 품목코드 저장
		vo.setItemcode(generateItemCode(vo));
		
		// 서비스
		iService.itemRegist(vo);
		
		// 등록 완료 시 뜨는 알림창 (정보 이동)
		rttr.addFlashAttribute("result", "REGISTOK");
		
		return "redirect:/information/items";
	} // itemRegist() 끝
	
	// 품목코드 생성 메서드
	public String generateItemCode(ItemVO vo) throws Exception {
		
		String code = "";
		int num = 101 + iService.itemtypeCount(vo);
		
		switch(vo.getItemtype()) {
			case "원자재": code = "MM"; break;
			case "부자재": code = "SM"; break;
			case "완제품": code = "P"; break;
		}
		
		return code + num;
	}
	
	// 품목 수정 - POST
	@RequestMapping(value = "/itemModify", method = RequestMethod.POST)
	public String itemModify(ItemVO vo) throws Exception {
		logger.debug("itemModify() 호출");
		
		// 서비스
		iService.itemModify(vo);
		
		return "redirect:/information/items";
	}
	
	// 품목 삭제 (비활성화) - POST
	@RequestMapping(value = "/itemDelete", method = RequestMethod.POST)
	public String itemDelete(ItemVO vo) throws Exception {
		logger.debug("itemDelete() 호출");
		
		// 서비스
		iService.itemDelete(vo);
		
		return "redirect:/information/items";
	}
	
	// 품목 목록 (엑셀 파일 다운로드)
	@RequestMapping(value = "/itemListExcelDownload", method = RequestMethod.GET)
	public void itemListExcelDownload(HttpServletResponse response, ItemVO vo) throws Exception { 
		// 1. 테이블 데이터를 가져옴
		List<ItemVO> list = iService.itemListExcel(vo);
		logger.debug("list: " + list);

		// 2. 엑셀 데이터로 변환
		XSSFWorkbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("sheet");
		
	    // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가)
	    Row headerRow = sheet.createRow(0);
	    String[] headers = {"번호", "품목유형", "품목코드", "품명", "원산지", "중량(g)", "단가(원)"};
	    
	    CellStyle headerStyle = workbook.createCellStyle();
	    headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); 
	    headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);	    
	    
	    for (int i = 0; i < headers.length; i++) {
	        Cell cell = headerRow.createCell(i);
	        cell.setCellValue(headers[i]);
	        cell.setCellStyle(headerStyle);	        
	    }

		int rowNum = 1; // 컬럼명을 추가했으면 1, 컬럼명을 추가하지 않았으면 0으로 시작
		for (ItemVO vo2 : list) { // 향상된 for문 사용 (서비스에서 받아온 목록을 해당 VO에 대입)
			Row row = sheet.createRow(rowNum++);

			int colNum = 0;
			// 컬럼 내용 추가 (vo의 Getter를 사용)
			row.createCell(colNum++).setCellValue(vo2.getItemid());
			row.createCell(colNum++).setCellValue(vo2.getItemtype());
			row.createCell(colNum++).setCellValue(vo2.getItemcode());
			row.createCell(colNum++).setCellValue(vo2.getItemname());
			row.createCell(colNum++).setCellValue(vo2.getOrigin());
			
			if(vo2.getItemweight() != null) {
				row.createCell(colNum++).setCellValue(vo2.getItemweight());
			}
			if(vo2.getItemweight() == null) {
				row.createCell(colNum++).setCellValue("");
			}
			
			row.createCell(colNum++).setCellValue(vo2.getItemprice());
			
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
		}
		
		String fileName = "ItemList.xlsx"; // 저장하는 파일명

		// 3. 엑셀 파일을 저장합니다.
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // 엑셀 형식
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName); // 다운로드 형태로 실행
		
        OutputStream out = response.getOutputStream();
        workbook.write(out);
        out.flush();
        
        out.close();
        workbook.close();
	}
	
} // Controller 끝
