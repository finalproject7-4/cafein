package com.cafein.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.cafein.domain.BomVO;
import com.cafein.domain.Criteria;
import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.RoastedbeanVO;

public interface ProductionService {
	
	// AJAX생산지시목록 조회
	public List<ProduceVO> getProduceListAJAX(ProduceVO vo) throws Exception;
	
	// 엑셀파일 다운로드용 생산지시 목록 조회
	public List<ProduceVO> getExcelDownProduceList(ProduceVO vo) throws Exception;
	
	// AJAX 생산지시 글 개수 확인
	public Integer AJAXcountProduceList(ProduceVO vo) throws Exception;
	
	// BOM 목록 조회
	public List<BomVO> getBomList() throws Exception;
	
	// 생산지시 등록
	public void regProduce(ProduceVO vo) throws Exception;
	
	// BOM 등록
	public void regBom(BomVO vo) throws Exception;
	
	// BOM 등록되지 않은 품목 조회
	public List<ItemVO> getNewItem() throws Exception;
	
	// 품목 아이템 목록 조회
	public List<ItemVO> getItemList() throws Exception;
	
	// 생산 상태 업데이트
	public void updateProduceState(ProduceVO vo) throws Exception;
	
	// 생산 공정과정 업데이트 (블렌딩 -> 로스팅)
	public void updateProduceProcessRoasting(ProduceVO vo) throws Exception;
	
	// 생산 공정과정 업데이트 (로스팅 -> 포장)
	public void updateProduceProcess(ProduceVO vo) throws Exception;
	
	// 생산지시 엑셀파일 다운로드
	public void excelPrint(ProduceVO vo, HttpServletResponse response) throws Exception;
	
	// 포장공정 완료된 제품 roastedbean 테이블에 추가
	public void insertRoastedbean(RoastedbeanVO vo) throws Exception;
	
	// 대기중인 블렌딩 공정 지시 삭제
	public void deleteProducePlan(ProduceVO vo) throws Exception;
	
	// 로스팅 업데이트 제품 온도 조회
	public int getRoastingTemper(ProduceVO vo) throws Exception;
	
	// 로스팅 완료 제품 목록 조회
	public List<RoastedbeanVO> getRoastedList(RoastedbeanVO vo) throws Exception;
	
	// 로스팅 목록 개수 조회
	public Integer countRoastedbean(RoastedbeanVO vo) throws Exception;
	
	
	

}
