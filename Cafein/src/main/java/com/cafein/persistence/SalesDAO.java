package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ItemVO;
import com.cafein.domain.QualityVO;
import com.cafein.domain.SalesVO;

public interface SalesDAO {
	
	// 수주 등록
	public void registPO(SalesVO svo) throws Exception;
	
	// 수주 조회
	public List<SalesVO> getPOList() throws Exception;

	// 품목 목록 (페이징)
	public List<SalesVO> getPOList(SalesVO svo) throws Exception;
	
	
	// 수주등록 - 납품처
	public List<SalesVO> registCli() throws Exception;

	// 수주등록 - 품목
	public List<SalesVO> registItem() throws Exception;
	
	// 수주코드 생성
	public int getPOCount(SalesVO svo) throws Exception;
	
	//수주수정
	public int updatePO(SalesVO svo) throws Exception;

	
	//납품서
	public List<SalesVO> getReceiptList() throws Exception;
	
	//엑셀
	public List<SalesVO> getPOPrint() throws Exception;

	//수주상태 취소
	public int updatePOstate(SalesVO svo) throws Exception;
	//수주상태 진행
	public int ingUpdate(SalesVO svo) throws Exception;

	//총개수
	public int countPO(SalesVO svo) throws Exception;
	
	//리스트출력
	public List<SalesVO> selectPOListExcel(SalesVO svo) throws Exception;

	//수주상태-대기
	public List<SalesVO> stopState() throws Exception;

	
	
}
