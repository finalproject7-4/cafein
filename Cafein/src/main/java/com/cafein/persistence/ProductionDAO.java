package com.cafein.persistence;


import java.util.List;

import com.cafein.domain.BomVO;
import com.cafein.domain.ProduceVO;

public interface ProductionDAO {

	// 생산지시 목록 조회
	public List<ProduceVO> getProduceList(ProduceVO vo) throws Exception;
	
	// BOM 목록 조회
	public List<BomVO> getBomList() throws Exception;
	
	// 생산지시 등록
	public void insertProducePlan(ProduceVO vo) throws Exception;
	
}
