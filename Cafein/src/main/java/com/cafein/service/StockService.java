package com.cafein.service;

import java.util.List;

import com.cafein.domain.QualityVO;

public interface StockService {
	
	// 재고 목록 조회 검색 버튼 (생산 [포장] + 반품)
	public List<QualityVO> stockList(QualityVO vo) throws Exception;
	
	// 재고 목록 조회 검색 버튼 개수 조회 (생산 [포장] + 반품)
	public Integer stockListCount(QualityVO vo) throws Exception;
	
	// 재고 목록 조회 검색 버튼 (자재)
	public List<QualityVO> materialStockList(QualityVO vo) throws Exception;
	
	// 재고 목록 조회 검색 버튼 개수 조회 (자재)
	public Integer materialStockListCount(QualityVO vo) throws Exception;
	
	// roastedbean - LOT번호 조회
	public String roastedbeanLotNum(QualityVO vo) throws Exception;
	
	// receive - LOT번호 조회
	public String receiveLotNum(QualityVO vo) throws Exception;
	
	// 재고 입력 (생산 [포장] + 반품)
	public int newStock(QualityVO vo) throws Exception;
	
	// 재고 등록 중복 확인 (생산 [포장] + 반품)
	public Integer duplicateStock(int qualityid) throws Exception;
	
	// 재고량 변경 (생산 [포장] + 반품)
	public int stockQuantity(QualityVO vo) throws Exception;
	
	// 창고 목록 조회 (생산 [포장] + 반품)
	public List<QualityVO> storageList() throws Exception;
	
	// 창고 목록 조회 (원자재)
	public List<QualityVO> rawmaterialStorageList() throws Exception;
	
	// 창고 목록 조회 (부자재)
	public List<QualityVO> submaterialStorageList() throws Exception;
	
	// 창고 변경 (생산 [포장] + 반품)
	public int stockStorage(QualityVO vo) throws Exception;
	
	// 재고 등록 여부 업데이트
	public void registerStockY(QualityVO vo) throws Exception;
	
	// 재고 토스트 데이터 (생산 [포장] + 반품)
	public QualityVO productStockToast() throws Exception;
	
	// 재고 토스트 데이터 (자재)
	public QualityVO materialStockToast() throws Exception;
	
	// 재고 엑셀용 출력 목록 조회 (생산 [포장] + 반품)
	public List<QualityVO> stockListExcel(QualityVO vo) throws Exception;
	
	// 재고 엑셀용 출력 목록 조회 (자재)
	public List<QualityVO> materialStockListExcel(QualityVO vo) throws Exception;
	
	// roastedBean 테이블 조회
	public QualityVO roastedBeanInfo(String lotnumber) throws Exception;
	
	// roastedBean - lotnumber 테이블 조회
	public List<QualityVO> roastedBeanLot(int produceid) throws Exception;
	
	// receive 테이블 조회
	public QualityVO receiveInfo(String receiveid) throws Exception;
	
	// produceid로 roastedBean LOT 조회 후 입력 (포장)
	public void normalRoastedBeanLot(int produceid) throws Exception;
	
	// receiveid로 receive LOT 조회 후 입력 (자재)
	public void normalRoastedBeanLotMat(int receiveid) throws Exception;
	
	// 정상 LOT 번호 검색
	public List<QualityVO> normalLot(QualityVO vo) throws Exception;
	
}
