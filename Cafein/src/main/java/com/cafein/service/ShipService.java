package com.cafein.service;

import java.util.List;

import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;

public interface ShipService {
	
	// 출하 조회
	public List<ShipVO> AllSHList() throws Exception;
	
	// 출하 등록
	public void registSH(ShipVO svo) throws Exception;
	
	// 출하 조회 - 작업지시코드
	public List<WorkVO> registWC() throws Exception;
	
	// 작업 지시 조회
	public List<WorkVO> AllWKList() throws Exception;
	
	// 작업 지시 등록
	public void registWK(WorkVO wvo) throws Exception;
	
	// 실적 조회
	public List<WorkVO> AllPFList() throws Exception;
	
	// 실적 등록
	public void registPF(WorkVO wvo) throws Exception;
	
}