package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ReceiveVO;


public interface ReceiveDAO {

	// 입고 목록
	public List<ReceiveVO> getReceiveList() throws Exception;
	
}
