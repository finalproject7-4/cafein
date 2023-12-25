package com.cafein.service;

import java.util.List;

import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;

public interface ShipService {
	
	// 출하 조회
	public List<ShipVO> AllSHList() throws Exception;
	
	// 작업 지시 조회
	public List<WorkVO> AllWKList() throws Exception;
	
	// 실적 조회
	public List<WorkVO> AllPFList() throws Exception;
	
}