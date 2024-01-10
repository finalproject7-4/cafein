package com.cafein.service;

import java.util.List;

import com.cafein.domain.Criteria;
import com.cafein.domain.ItemVO;
import com.cafein.domain.ReturnVO;

public interface ReturnService {
	// 반품 목록
	public List<ReturnVO> searchReturns(Criteria cri) throws Exception;
	
	// 반품 검색
	public List<ReturnVO> searchReturnsByCondition(ReturnVO rvo, Criteria cri) throws Exception;
	
	// 반품 유형별 총 개수 계산
	public int returnCount(ReturnVO rvo) throws Exception;
	
	// 반품 등록
	public void returnRegist(ReturnVO rvo) throws Exception;
	
	// 아이템 목록
	public List<ItemVO> itList() throws Exception;
	
	// 반품 수정
	public int returnModify(ReturnVO rvo) throws Exception;
	
	// 반품 삭제
	public void returnDelete(int rvo) throws Exception;
	
	// 품질 관리 등록
	public void addReturn(int returnid) throws Exception;
	
	// 환불 날짜 등록
	public void refundDate(String returnCode) throws Exception;
	
	// 검색 결과 페이징
	public int returnPageCnt(ReturnVO rvo) throws Exception;
	
	// 전체 결과 페이징
	public int returnAllCnt() throws Exception;
	
	// 반품 목록 (엑셀 파일 다운로드)
	public List<ReturnVO> returnListExcel(ReturnVO rvo) throws Exception;
}