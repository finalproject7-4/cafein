package com.cafein.service;

import java.util.List;

import com.cafein.domain.ClientVO;
import com.cafein.domain.MemberVO;

public interface ClientService {
	
	// 거래처 정보 등록 동작
	public void clientJoin(ClientVO vo) throws Exception;
	
	// 거래처 목록 가져오기 동작
	public List<ClientVO> clientList() throws Exception;

	// 특정 거래처 정보 조회 동작
	public ClientVO clientInfo(int clientid) throws Exception;
	
	// 특정 거래처 정보 수정 동작
	public int clientUpdate(ClientVO vo) throws Exception;
	
	// 특정 거래처 정보 삭제 동작
	public int clientDelete(ClientVO vo) throws Exception;
}
