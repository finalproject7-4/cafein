package com.cafein.service;

import java.util.List;

import com.cafein.domain.ReceiveVO;

public interface ReceiveService {
	
	// 입고 목록
	public List<ReceiveVO> receiveList() throws Exception;
	
}
