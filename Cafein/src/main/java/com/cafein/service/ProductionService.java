package com.cafein.service;

import java.util.List;

import com.cafein.domain.ProduceVO;

public interface ProductionService {
	
	// 생산지시목록 조회
	public List<ProduceVO> getProduceList(ProduceVO vo);
	
	
}
