package com.cafein.service;

import java.util.List;

import com.cafein.domain.QualityVO;

public interface StockService {
	
	// 재고 목록 조회 (생산 [포장] + 반품)
	public List<QualityVO> stockList() throws Exception;
	
	// 재고 입력 (생산 [포장] + 반품)
	public int newStock(QualityVO vo) throws Exception;
	
	// 재고 등록 중복 확인 (생산 [포장] + 반품)
	public Integer duplicateStock(int qualityid) throws Exception;
	
	// 재고량 변경 (생산 [포장] + 반품)
	public int stockQuantity(QualityVO vo) throws Exception;
	
	// 창고 목록 조회 (생산 [포장] + 반품)
	public List<QualityVO> storageList() throws Exception;
	
	// 창고 변경 (생산 [포장] + 반품)
	public int stockStorage(QualityVO vo) throws Exception;
}
