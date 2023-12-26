package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ClientVO;
import com.cafein.domain.SalesVO;

public interface SalesDAO {
	
	// 수주 등록
	public void registPO(SalesVO svo) throws Exception;
	
	// 수주 조회
	public List<SalesVO> getPOList() throws Exception;

	//수주조회 - 납품처
	public List<ClientVO> getAddCliList() throws Exception;
}
