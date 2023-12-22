package com.cafein.persistence;


import java.util.List;

import com.cafein.domain.ProduceVO;

public interface ProductionDAO {

	// 생산지시 목록 조회
	public List<ProduceVO> getProduceList(ProduceVO vo);
	
	
}
