package com.cafein.persistence;


import java.util.List;

import com.cafein.domain.BomVO;
import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.QualityVO;
import com.cafein.domain.ReleasesVO;
import com.cafein.domain.RoastedbeanVO;

public interface ProductionDAO {

	// 생산지시 목록 조회 (AJAX)
	public List<ProduceVO> getProduceListAJAX(ProduceVO vo) throws Exception;
	
	// 엑셀파일 다운로드용 생산지시 조회
	public List<ProduceVO> getExcelDownProduceList(ProduceVO vo) throws Exception;


	// AJAX 생산목록 글 개수 확인
	public Integer AJAXcountProduceList(ProduceVO vo) throws Exception;
	
	// BOM 목록 조회
	public List<BomVO> getBomList() throws Exception;
	
	// 생산지시 등록
	public void insertProducePlan(ProduceVO vo) throws Exception;
	
	// BOM등록
	public void insertBom(BomVO vo) throws Exception;
	
	// BOM 등록되지 않은 품목 조회
	public List<ItemVO> getNewItem() throws Exception;
	
	// 품목 리스트 조회
	public List<ItemVO> getItemList() throws Exception;
	
	// 생산 상태 업데이트
	public void updateProduceState(ProduceVO vo) throws Exception;
	
	// 생산지시 공정 상태 수정 (블렌딩 -> 로스팅)
	public void updateProduceProcessRoasting(ProduceVO vo) throws Exception;
	
	// 생산지시 공정 상태 수정 (로스팅 -> 포장)
	public void updateProduceProcess(ProduceVO vo) throws Exception;
	
	// 포장완료 제품 roastedbean 테이블에 추가
	public void insertRoastedbean(RoastedbeanVO vo) throws Exception;
	
	// 대기중인 블렌딩 공정과정 삭제
	public void deleteProducePlan(ProduceVO vo) throws Exception;
	
	// 로스팅 온도값 조회
	public int getRoastingTemper(ProduceVO vo) throws Exception;
	
	// 로스팅 제품 조회
	public List<RoastedbeanVO> getRoastedList(RoastedbeanVO vo) throws Exception;
	
	// 로스팅 목록 글 개수 조회
	public Integer countRoastedbean(RoastedbeanVO vo) throws Exception;
	
	// 생산지시 블렌딩작업 시작하면 품질 리스트 데이터 삽입
	public void regQualityList(QualityVO vo) throws Exception;
	
	// 블렌딩 -> 로스팅으로 작업 전환시 품질테이블에 신규 데이터 삽입
	public void regRoastingQualityList(QualityVO vo) throws Exception;
	
	// 로스팅 -> 포장으로 작업 전환시 품질테이블에 신규 데이터 삽입
	public void regPackingQualityList(QualityVO vo) throws Exception;
	
	// 생산지시 등록시 출고 등록(대기)
	public void insertReleasesList(ReleasesVO vo) throws Exception;
	
	// 생산코드 생성 
	public Integer getProducecodeCount(String datePart) throws Exception;
	
	// 출고지시 리스트 상태 대기 -> 완료로 업데이트
	public void updateCompletRelease(ProduceVO vo) throws Exception;

	// 재고리스트 업데이트
	public void updateStockList(ProduceVO vo) throws Exception;
	
	// 당일 총 생산량
	public Integer getProduceAmountToday() throws Exception;
	
	// 당월 총 생산량
	public Integer getProduceAmountThisMonth() throws Exception;
	
	// 당해 총 생산량
	public Integer getProduceAmountThisYear() throws Exception;
	
	// 생산지시리스트 출력(메인용)
	public List<ProduceVO> getProduceList() throws Exception;
	
}






