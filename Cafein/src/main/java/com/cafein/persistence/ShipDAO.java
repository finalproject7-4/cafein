package com.cafein.persistence;

import java.util.List;
import java.util.Map;

import com.cafein.domain.MemberVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;
import com.cafein.domain.SalesVO;
import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;

public interface ShipDAO {
	
	// 출하 조회
	public List<ShipVO> getSHList(ShipVO svo) throws Exception;
	
	// 총개수
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
	public int getSHCount(ShipVO svo) throws Exception;
		
	// 출하 검색
	public List<ShipVO> searchSHList(Map<String, Object> searchParams) throws Exception;	
	
	// 출하 수정
	public int updateSH(ShipVO svo) throws Exception;
	
	// 출하 상태 완료 변경
	public int ingUpdate(ShipVO svo) throws Exception;
	
		
	
	// 작업 지시 조회
	public List<WorkVO> getWKList(WorkVO wvo) throws Exception;
	
	// 총개수
	public int countWK(WorkVO wvo) throws Exception;
	
	// 작업 지시 등록
	public void registWK(WorkVO wvo) throws Exception;
	
	// 작업 지시 등록 - 수주코드
	public List<WorkVO> registPC() throws Exception;
	
	// 작업 지시 코드 생성
	public int getWKCount(WorkVO wvo) throws Exception;
	
	// 작업 지시 수정
	public int updateWK(WorkVO wvo) throws Exception;
	
	// 작업 지시 삭제
	public void deleteWK(WorkVO wvo) throws Exception;
	
	// 작업지시 등록시 출하 등록(접수)
	public void insertShipList(ShipVO svo) throws Exception;
	
	// 출하 완료-> 작업지시 완료
	public void updateCompletWork(WorkVO wvo) throws Exception;
	
	
	
	// 실적 조회
	public List<WorkVO> getPFList(WorkVO wvo) throws Exception;
	
	// 총개수
	public int countPF(WorkVO wvo) throws Exception;
	
	// 실적 수정
	public int updatePF(WorkVO wvo) throws Exception;

	

}