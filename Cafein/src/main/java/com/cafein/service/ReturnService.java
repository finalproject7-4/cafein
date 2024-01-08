package com.cafein.service;

import java.util.List;

import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.ReturnVO;

public interface ReturnService {
	// 반품 목록
	public List<ReturnVO> searchReturns() throws Exception;
	
	// 반품 검색
	public List<ReturnVO> searchReturnsByCondition(ReturnVO rvo) throws Exception;
	
	// 반품 유형별 총 개수 계산
	public int returnCount(ReturnVO rvo) throws Exception;
	
	// 반품 등록
	public void returnRegist(ReturnVO rvo) throws Exception;
	
	// 완제품 목록
	//public List<ProduceVO> prList() throws Exception;
	
	// 아이템 목록
	public List<ItemVO> itList() throws Exception;
	
	// 반품 수정
	public int returnModify(ReturnVO rvo) throws Exception;
	
	// 반품 삭제
	public void returnDelete(int rvo) throws Exception;
	
	// 품질 관리 등록
	public void addReturn(int rvo) throws Exception;
	
	
	



}