package com.cafein.service;

import java.util.List;
import java.util.Map;

import com.cafein.domain.MemberVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;
import com.cafein.domain.SalesVO;
import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;

public interface ShipService {
	
	// 출하 조회
	public List<ShipVO> AllSHList(ShipVO svo) throws Exception;
	
	// 총 개수
	public int countSH(ShipVO svo) throws Exception;
	
	// 출하 등록
	public void registSH(ShipVO svo) throws Exception;
	
	// 출하 등록 - 작업지시코드
	public List<WorkVO> registWC() throws Exception;
	
	// 출하 등록 - 재고량
	public List<WorkVO> registST() throws Exception;
	
	// 출하 등록 - 멤버 코드
	public List<MemberVO> registMC() throws Exception;
	
	// 출하 코드 생성
	public int shCount(ShipVO svo) throws Exception;
	
	// 출하 검색
	public List<ShipVO> searchSHList(Map<String, Object> searchParams) throws Exception;
		
	// 출하 수정
	public int SHModify(ShipVO svo) throws Exception;
		
		
	
	// 작업 지시 조회
	public List<WorkVO> AllWKList(WorkVO wvo) throws Exception;
	
	// 총 개수
	public int countWK(WorkVO wvo) throws Exception;
	
//	// 작업 지시 검색
//	public List<WorkVO> searchWKList(String keyword) throws Exception;
	
	// 작업 지시 등록
	public void registWK(WorkVO wvo) throws Exception;
	
	// 작업 지시 등록 - 수주 코드
	public List<WorkVO> registPC() throws Exception;
	
	// 작업 지시 코드 생성
	public int wkCount(WorkVO wvo) throws Exception;
	
	// 작업 지시 수정
	public int WKModify(WorkVO wvo) throws Exception;
	
	// 작업 지시 삭제
	public void WKDelete(WorkVO wvo) throws Exception;
	
	// 작업 지시 등록과 동시에 출하 지시 등록
	public void insertShipList(ShipVO svo) throws Exception;
	
	// 작업 지시 진행 = 출하 진행
	public void updateCompletShip(WorkVO wvo) throws Exception;
	
	
	
	
	// 실적 조회
	public List<WorkVO> AllPFList(WorkVO wvo) throws Exception;
	
	// 총 개수
	public int countPF(WorkVO wvo) throws Exception;
	
	// 실적 수정
	public int PFModify(WorkVO wvo) throws Exception;
	
}