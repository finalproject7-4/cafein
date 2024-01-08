package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.ReturnVO;

public interface ReturnDAO {
	
	// 반품 목록 
	public List<ReturnVO> searchReturns() throws Exception;
	
	// 반품 검색
	public List<ReturnVO> searchReturnsByCondition(ReturnVO rvo) throws Exception;
	
	// 반품유형별 총 개수
	public int getReturnCount(ReturnVO rvo) throws Exception;
	
	// 반품 등록
	public void insertReturn(ReturnVO rvo) throws Exception;
	
	// 완제품 목록
	//public List<ProduceVO> prList() throws Exception;
	
	// 원자재,부자재 목록
	public List<ItemVO> itList() throws Exception;
	
	// 반품 수정
	public int updateReturn(ReturnVO rvo) throws Exception;

	// 반품 삭제
	public void deleteReturn(int rvo) throws Exception;

	// 품질관리 등록
	public void addReturn(int returnid) throws Exception;
	
	// 환불날짜 등록
	public void refundDate(String returnCode) throws Exception;
	
	
	
}