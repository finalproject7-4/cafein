package com.cafein.service;

import java.util.List;

import com.cafein.domain.ReturnVO;

public interface ReturnService {
	
	//반품 목록
	public List<ReturnVO> searchReturns() throws Exception;
	
	//반품 검색
	public List<ReturnVO> searchReturnsByCondition(ReturnVO condition) throws Exception;

	//반품 유형별 총 개수 계산
	public int returnCount(ReturnVO vo) throws Exception;








}