package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.SalesVO;
import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;

public interface ShipDAO {
	
	// 출하 조회
	public List<ShipVO> getSHList() throws Exception;
	
	// 출하 등록
	public void registSH(ShipVO svo) throws Exception;
	
	// 출하 등록 - 작업지시코드
	public List<WorkVO> registWC() throws Exception;
	
	// 작업 지시 조회
	public List<WorkVO> getWKList() throws Exception;
	
//	// 작업 지시 검색
//    public List<WorkVO> searchWKList(String keyword) throws Exception;
	
	// 작업 지시 등록
	public void registWK(WorkVO wvo) throws Exception;
	
	// 작업 지시 등록 - 수주코드
	public List<WorkVO> registPC() throws Exception;
	
	// 작업 지시 코드 생성
	public int getWKCount(WorkVO wvo) throws Exception;
	
	// 작업 지시 수정
	public int updateWK(WorkVO wvo) throws Exception;
	
	// 실적 조회
	public List<WorkVO> getPFList() throws Exception;
	
	// 실적 등록
	public void registPF(WorkVO wvo) throws Exception;

	

}