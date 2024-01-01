package com.cafein.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.BomVO;
import com.cafein.domain.Criteria;
import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.persistence.ProductionDAO;
import com.mysql.cj.result.Row;

@Service
public class ProductionServiceImpl implements ProductionService{
	
	private static final Logger logger = LoggerFactory.getLogger(ProductionServiceImpl.class);
	
	@Inject
	private ProductionDAO pdao;
	
	
	// AJAX생산 목록 조회
	@Override
	public List<ProduceVO> getProduceListAJAX(ProduceVO vo) throws Exception{
		logger.debug("Service - 생산지시 목록 조회 getProduceList() 실행");
		return pdao.getProduceListAJAX(vo);
	}
	
	// 엑셀파일 출력용 생산지시 목록 조회
	@Override
	public List<ProduceVO> getExcelDownProduceList(ProduceVO vo) throws Exception {
		logger.debug("Service - 엑셀 출력용 생산지시 목록 조회");
		return pdao.getExcelDownProduceList(vo);
	}




	// AJAX 생산지시 목록 글 개수 확인
	@Override
	public Integer AJAXcountProduceList(ProduceVO vo) throws Exception {
		logger.debug("Service - 생산지시 수량은 몇개요???");
		return pdao.AJAXcountProduceList(vo);
	}

	// BOM 목록 조회
	@Override
	public List<BomVO> getBomList() throws Exception {
		logger.debug("Service - BOM 목록 조회 getBomList() 실행");
		return pdao.getBomList();
	}


	// 생산지시 등록
	@Override
	public void regProduce(ProduceVO vo) throws Exception {
		logger.debug("Service - 생산지시 등록 regProduce() 실행");
		pdao.insertProducePlan(vo);
	}

	// BOM 등록
	@Override
	public void regBom(BomVO vo) throws Exception {
		logger.debug("Service - BOM 등록 regBom() 실행");
		
		pdao.insertBom(vo);
		
	}
	
	
	// BOM 등록되지 않은 품목
	@Override
	public List<ItemVO> getNewItem() throws Exception {
		logger.debug("Service - BOM 등록 안한 제품 getNewItem() 실행");
		
		return pdao.getNewItem();
		
	}


	// 품목 아이템 리스트 조회
	@Override
	public List<ItemVO> getItemList() throws Exception {
		logger.debug("Service - 품목 아이템리스트 조회 getItemList() 실행");
		
		return pdao.getItemList();
	}

	// 생산 상태 업데이트
	@Override
	public void updateProduceState(ProduceVO vo) throws Exception {
		logger.debug("Service - 생산 상태 업데이트 updateProduceState() 실행");
		
		pdao.updateProduceState(vo);
	}

	// 생산지시리스트 엑셀파일 다운로드
	@Override
	public void excelPrint(ProduceVO vo, HttpServletResponse response) throws Exception {

		List<ProduceVO> produceList = pdao.getExcelDownProduceList(vo);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // 날짜타입변경
		try {
		// 엑셀 다운로드 시작
		Workbook workbook = new HSSFWorkbook();
		
		// 시트생성
		Sheet sheet = workbook.createSheet("생산지시_관리");
		
		// 행, 열, 열번호
		org.apache.poi.ss.usermodel.Row row = null;
		Cell cell = null;
		int rowNo = 0;
		
		// 테이블 헤더용 스타일
		CellStyle headStyle = workbook.createCellStyle();
		
		// 테이블 경계선
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setBorderBottom(BorderStyle.THIN);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);
		
		// 첫행인 컬럼 배경색 노랑
		headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
		headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		// 출력데이터용 경계 스타일 테두리 지정
		CellStyle bodyStyle = workbook.createCellStyle();
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		
		// 헤더명 설정
		String[] headerArray = {"번호", "등록일", "생산일", "제품명", "생산라인", "공정과정", "품질검수", "상태", "생산량"};
		row = sheet.createRow(rowNo++);
		
		for(int i=0; i<headerArray.length; i++) {
		cell = row.createCell(i);
		cell.setCellStyle(headStyle);
		cell.setCellValue(headerArray[i]);
		}
		
		for(ProduceVO excelData : produceList) {
			row = sheet.createRow(rowNo++);
			
			// 생산id
			cell = row.createCell(0);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(excelData.getProduceid());
			
			// 등록일
			cell = row.createCell(1);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(dateFormat.format(excelData.getSubmitdate()));
			
			// 생산지시일
			cell = row.createCell(2);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(dateFormat.format(excelData.getProducedate()));
			
			// 제품명
			cell = row.createCell(3);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(excelData.getItemname());
			
			// 생산라인
			cell = row.createCell(4);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(excelData.getProduceline());
			
			// 공정과정
			cell = row.createCell(5);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(excelData.getProcess());
			
			// 품질검수 상태
			cell = row.createCell(6);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(excelData.getQualitycheck());
			
			// 생산 상태
			cell = row.createCell(7);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(excelData.getState());
			
			// 생산량
			cell = row.createCell(8);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(excelData.getAmount());
		}
		
		// 컨텐츠 타입과 파일명 지정
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("생산지시_관리.xls", "UTF-8"));
		
		// 엑셀출력
		workbook.write(response.getOutputStream());
		workbook.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	
	

	
	
	
	

	
	
	
	

	

	
	
	
	
	
	
}
