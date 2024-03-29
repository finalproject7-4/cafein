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
	
	// 출하 상태 진행으로 변경
	public int ingUpdate(ShipVO svo) throws Exception;
	
	// 출하 엑셀 출력
	public List<ShipVO> SHListExcel(ShipVO svo) throws Exception;
		
		
	
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
	
	// 출하 완료 -> 작업지시 완료
	public void updateCompletWork(WorkVO wvo) throws Exception;
	
	// 출하 완료 -> 수주 완료
	public void updateCompletSale(SalesVO ssvo) throws Exception;
	
	// 작업지시 엑셀 출력
	public List<WorkVO> WKListExcel(WorkVO wvo) throws Exception;
	
	
	
	
	// 실적 조회
	public List<WorkVO> AllPFList(WorkVO wvo) throws Exception;
	
	// 총 개수
	public int countPF(WorkVO wvo) throws Exception;
	
	// 실적 수정
	public int PFModify(WorkVO wvo) throws Exception;
	
	// 실적 엑셀 출력
	public List<WorkVO> PFListExcel(WorkVO wvo) throws Exception;
	
}