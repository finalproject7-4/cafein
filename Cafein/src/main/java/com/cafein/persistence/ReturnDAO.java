package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ReturnVO;

public interface ReturnDAO {
	
	// 반품 목록
	public List<ReturnVO> searchReturns() throws Exception;
	 
	// 반품 검색
	public List<ReturnVO> searchReturnsByCondition(ReturnVO condition) throws Exception;
	
	// 반품유형별 총 개수
	public int getReturnCount(ReturnVO vo) throws Exception;
	
	
	
	
	
}