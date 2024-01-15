package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.QualityVO;

public interface StockDAO {

	// 재고 목록 조회 검색 버튼 (생산 [포장] + 반품)
	public List<QualityVO> selectStockList(QualityVO vo) throws Exception;
	
	// 재고 목록 조회 검색 버튼 개수 조회 (생산 [포장] + 반품)
	public Integer selectStockListCount(QualityVO vo) throws Exception;
	
	// 재고 목록 조회 검색 버튼 (자재)
	public List<QualityVO> selectMaterialStockList(QualityVO vo) throws Exception;
	
	// 재고 목록 조회 검색 버튼 개수 조회 (자재)
	public Integer selectMatrialStockListCount(QualityVO vo) throws Exception;
	
	// 재고 입력
	public int insertStockList(QualityVO vo) throws Exception;
	
	// 재고 등록 중복 확인 (생산 [포장] + 반품)
	public Integer selectDuplicateStock(int qualityid) throws Exception;
	
	// 재고량 변경 (생산 [포장] + 반품)
	public int updateStockQuantity(QualityVO vo) throws Exception;
	
	// 창고 목록 조회 (생산 [포장] + 반품)
	public List<QualityVO> selectStorageList() throws Exception;
	
	// 창고 목록 조회 (원자재)
	public List<QualityVO> selectRawMaterialStorageList() throws Exception;
	
	// 창고 목록 조회 (부자재)
	public List<QualityVO> selectSubMaterialStorageList() throws Exception;
	
	// 창고 변경 (생산 [포장] + 반품)
	public int updateStockStorage(QualityVO vo) throws Exception;
	
	// roastedbean - LOT번호 조회 
	public String selectRoastedBeanLotNum(QualityVO vo) throws Exception;
	
	// receive - LOT번호 조회
	public String selectReceiveLotNum(QualityVO vo) throws Exception;
	
	// 재고 등록 여부 업데이트
	public void updateRegisterStock(QualityVO vo) throws Exception;
	
	// 재고 토스트 데이터 (생산 [포장] + 반품)
	public QualityVO selectProductStockToast() throws Exception;
	
	// 재고 토스트 데이터 (자재)
	public QualityVO selectMaterialStockToast() throws Exception;
	
	// 재고 엑셀용 출력 목록 조회 (생산 [포장] + 반품)
	public List<QualityVO> selectStockListExcel(QualityVO vo) throws Exception;
	
	// 재고 엑셀용 출력 목록 조회 (반품)
	public List<QualityVO> selectMaterialStockListExcel(QualityVO vo) throws Exception;
	
	// roastedBean 테이블 조회
	public QualityVO selectRoastedBean(String lotnumber) throws Exception;
	
	// roastedBean - lotnumber 테이블 조회
	public List<QualityVO> selectRoastedBeanLot(int produceid) throws Exception;
	
	// receive 테이블 조회
	public QualityVO selectReceiveInfo(String receiveid) throws Exception;
	
	// produceid로 roastedBean LOT 조회 후 입력 (포장)
	public void insertNormalRoastedBeanLot(int produceid) throws Exception;
	
	// receiveid로 receive LOT 조회 후 입력 (자재)
	public void insertNormalRoastedBeanLotMat(int receiveid) throws Exception;
	
	// 정상 LOT 번호 조회
	public List<QualityVO> selectNormalLot(QualityVO vo) throws Exception;
}
