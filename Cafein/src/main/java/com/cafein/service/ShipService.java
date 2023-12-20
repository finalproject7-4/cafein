package com.cafein.service;

import java.util.List;

import com.cafein.domain.ShipVO;

public interface ShipService {
	
	// 출하 조회
	public List<ShipVO> AllSHList() throws Exception;
	
	
}