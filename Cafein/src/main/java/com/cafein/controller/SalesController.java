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

		
		logger.debug("cliList",sService.registCli());        
		logger.debug("iList",sService.registItem());         
		
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
	
	//목록 엑셀
	@GetMapping("/SalesPrint")
    public void POPrint(HttpServletResponse response) throws Exception {
        // 1. 테이블 데이터를 가져옵니다.
        List<SalesVO> list = sService.POPrint();
        logger.debug(" list : " + list);

        // 2. 엑셀 데이터로 변환합니다.
        XSSFWorkbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("sheet");
        // 첫 번째 행에 열의 헤더 추가 (엑셀 첫 행에 컬럼명 추가입니다. 쓰실 분만 쓰시면 됩니다.)
	    Row headerRow = sheet.createRow(0);
	    String[] headers = {"수주번호", "수주상태", "수주코드", "납품처명","납품처코드", "품명", "품목코드", "수량", "수주일자", "납품일자", "담당자"};
	    for (int i = 0; i < headers.length; i++) {
	        Cell cell = headerRow.createCell(i);
	        cell.setCellValue(headers[i]);
	    }
	    // 첫 번째 행에 열의 헤더 추가
        int rowNum = 1;
        for (SalesVO vo2 : list) {
            Row row = sheet.createRow(rowNum++);

            int colNum = 0;
            row.createCell(colNum++).setCellValue(vo2.getPoid());
            row.createCell(colNum++).setCellValue(vo2.getPostate());
            row.createCell(colNum++).setCellValue(vo2.getPocode());
            row.createCell(colNum++).setCellValue(vo2.getClientname());
            row.createCell(colNum++).setCellValue(vo2.getClientcode());
            row.createCell(colNum++).setCellValue(vo2.getItemname());
            row.createCell(colNum++).setCellValue(vo2.getItemcode());
            row.createCell(colNum++).setCellValue(vo2.getPocnt());
            row.createCell(colNum++).setCellValue(vo2.getOrdersdate());
            row.createCell(colNum++).setCellValue(vo2.getOrdersduedate());
            row.createCell(colNum++).setCellValue(vo2.getMembercode());
            
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
			
			// 셀 크기 조정
			sheet.autoSizeColumn(colNum - 1);  // 현재 열의 너비를 자동으로 조정
			
//			row.createCell(colNum++).setCellValue(vo2.getUpdatehistory());
        }

        // 3. 엑셀 파일을 저장합니다.
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
//        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

        OutputStream out = response.getOutputStream();
        workbook.write(out);
        out.flush();

        out.close();
        workbook.close();
    } 

	
	
	
	
	
	
}
