package com.cafein.service;

import java.util.List;

import com.cafein.domain.ClientVO;
import com.cafein.domain.SalesVO;

public interface SalesService {
	
	//수주 등록
	public void registPO(SalesVO svo) throws Exception;
	
	
	// 수주 조회
	public List<SalesVO> AllPOList() throws Exception;
		
	// 수주등록 - 납품처
	public List<SalesVO> registCli() throws Exception;
	// 수주등록 - 품목
	public List<SalesVO> registItem() throws Exception;
		
		
		
		
}
