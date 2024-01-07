package com.cafein.service;


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

import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.QualityVO;
import com.cafein.domain.ReleasesVO;
import com.cafein.domain.RoastedbeanVO;
import com.cafein.persistence.ProductionDAO;


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

	// 포장공정 완료된 제품 roastedbean 테이블에 추가
	@Override
	public void insertRoastedbean(RoastedbeanVO vo) throws Exception {
		logger.debug("Service - 포장공정완료! 로스티드제품 추가!");
		
		pdao.insertRoastedbean(vo);
	}
	
	// 생산 공정과정 업데이트 (블렌딩 -> 로스팅)
	@Override
	public void updateProduceProcessRoasting(ProduceVO vo) throws Exception {
		logger.debug("Service - 생산공정과정 로스팅으로 변경! ");
		
		pdao.updateProduceProcessRoasting(vo);
	}

	
	// 생산 공정과정 업데이트 (로스팅 -> 포장)
	@Override
	public void updateProduceProcess(ProduceVO vo) throws Exception {
		logger.debug("Service - 생산공정과정 포장으로 변경! ");
		
		pdao.updateProduceProcess(vo);
		
	}
	
	
	// 대기중인 블렌딩 작업 삭제
	@Override
	public void deleteProducePlan(ProduceVO vo) throws Exception {
		logger.debug("Service - 블렌딩 작업 삭제!");
		
		pdao.deleteProducePlan(vo);
		
	}

	// 로스팅 제품 온도 체크
	@Override
	public int getRoastingTemper(ProduceVO vo) throws Exception {
		logger.debug("Service - 로스팅 업데이트 제품 온도체크 ");
		return pdao.getRoastingTemper(vo);
	}

	// 로스팅 제품 목록 조회
	@Override
	public List<RoastedbeanVO> getRoastedList(RoastedbeanVO vo) throws Exception {
		logger.debug("Service - 로스팅 완료 제품 목록 조회");
		
		return pdao.getRoastedList(vo);
	}

	// 로스팅 목록 글 개수 조회
	@Override
	public Integer countRoastedbean(RoastedbeanVO vo) throws Exception {
		logger.debug("Service - 로스팅 완료 제품 목록 조회");
		
		return pdao.countRoastedbean(vo);
	}

	// 생산지시 등록시 품질 리스트 데이터 삽입
	@Override
	public void regQualityList(QualityVO vo) throws Exception {
		logger.debug("Service - 블렌딩 작업 시작해서 품질리스트 업데이트");
		
		pdao.regQualityList(vo);
	}

	// 블렌딩 -> 로스팅 전환시 품질 데이터 신규 삽입
	@Override
	public void regRoastingQualityList(QualityVO vo) throws Exception {
		logger.debug("Service - 블렌딩 완료! 로스팅 시작! 품질 데이터 신규 삽입");
		
		pdao.regRoastingQualityList(vo);
	}
	
	// 로스팅 -> 포장 전환시 품질 데이터 신규 삽입
	@Override
	public void regPackingQualityList(QualityVO vo) throws Exception {
		logger.debug("Service - 블렌딩 완료! 로스팅 시작! 품질 데이터 신규 삽입");
		
		pdao.regPackingQualityList(vo);
	}
	

	// 생산지시 등록과 동시에 출고 지시 등록
	@Override
	public void insertReleasesList(ReleasesVO vo) throws Exception {
		logger.debug("Service - 생산등록 했으니 출고 지시도 등록한다!");
		
		pdao.insertReleasesList(vo);
		
	}

	// 생산코드 생성 메서드
	@Override
	public Integer getProducecodeCount(String datePart) throws Exception {
		logger.debug("Service - 생산코드 생성 실행!");
		return pdao.getProducecodeCount(datePart);
	}

	
	// 출고리스트 상태 대기 -> 완료 변경
	@Override
	public void updateCompletRelease(ProduceVO vo) throws Exception {
		logger.debug("Service - 출고리스트 완료로 변경!");
		
		pdao.updateCompletRelease(vo);
		
	}

	// 블렌딩 대기 -> 생산중, 출고리스트 대기 -> 완료로 변경될때 재고리스트 재고 차감
	@Override
	public void updateStockList(ProduceVO vo) throws Exception {
		logger.debug("Service - 재고리스트 업데이트");
		
		pdao.updateStockList(vo);
	}

	// 당일 총 생산량
	@Override
	public Integer getProduceAmountToday() throws Exception {
		logger.debug("Service - 당일 총 생산량 구하는 getProduceAmountToday() 호출!");
		return pdao.getProduceAmountToday();
	}

	// 당월 총 생산량
	@Override
	public Integer getProduceAmountThisMonth() throws Exception {
		logger.debug("Service - 이번달 총 생산량 구하는 getProduceAmountThisMonth() 호출!");
		return pdao.getProduceAmountThisMonth();
	}

	// 당해 총 생산량
	@Override
	public Integer getProduceAmountThisYear() throws Exception {
		logger.debug("Service - 이번년도 총 생산량 구하는 getProduceAmountThisYear() 호출!");
		return pdao.getProduceAmountThisYear();
	}

	// 생산지시리스트 출력(메인용)
	@Override
	public List<ProduceVO> getProduceList() throws Exception {
		logger.debug("Service - 생산지시리스트 메인용 getProduceList() 호출!");
		return pdao.getProduceList();
	}
	
	
	
	
	
	
	
	

	
	
	
	
	

	
	

	
	
	
	

	
	
	
	

	

	
	
	
	
	
	
}
