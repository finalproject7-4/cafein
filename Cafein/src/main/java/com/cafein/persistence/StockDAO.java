package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.QualityVO;

public interface StockDAO {

	// 재고 목록 조회 (생산 [포장] + 반품)
	public List<QualityVO> selectStockList() throws Exception;
	
	// 재고 입력
	public int insertStockList(QualityVO vo) throws Exception;
	
	// 재고 등록 중복 확인 (생산 [포장] + 반품)
	public Integer selectDuplicateStock(int qualityid) throws Exception;
	
	// 재고량 변경 (생산 [포장] + 반품)
	public int updateStockQuantity(QualityVO vo) throws Exception;
	
	// 창고 목록 조회 (생산 [포장] + 반품)
	public List<QualityVO> selectStorageList() throws Exception;
	
	// 창고 변경 (생산 [포장] + 반품)
	public int updateStockStorage(QualityVO vo) throws Exception;
	
	// roastedbean - LOT번호 조회 
	public String selectRoastedBeanLotNum(QualityVO vo) throws Exception;
	
	// receive - LOT번호 조회
	public String selectReceiveLotNum(QualityVO vo) throws Exception;
	
	// 재고 등록 여부 업데이트
	public void updateRegisterStock(QualityVO vo) throws Exception;
}
