package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ShipVO;

public interface ShipDAO {
	
	// 출하 조회
	public List<ShipVO> getSHList() throws Exception;
	
	// 작업 지시 조회
	public List<ShipVO> getWKList() throws Exception;

	

}