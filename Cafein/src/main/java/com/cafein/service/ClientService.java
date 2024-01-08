package com.cafein.service;

import java.util.List;

import com.cafein.domain.ClientVO;

public interface ClientService {
	
	// 거래처 정보 등록 동작
	public void clientJoin(ClientVO vo) throws Exception;
	
	// 최신 등록된 거래처의 거래처 코드 확인
	public int maxClientCode(ClientVO vo) throws Exception;
	
	// 거래처 목록 (페이징)
	public List<ClientVO> clientPageList(ClientVO vo) throws Exception;
	
	// 총 거래처 수 조회
	public Integer totalClientCount(ClientVO vo) throws Exception;
	
	// 거래처 정보를 list에 담아오는 동작
	public List<ClientVO> clientList() throws Exception;
	
	// 특정 거래처 정보 조회 동작
	public ClientVO clientInfo(int clientid) throws Exception;
	
	// 특정 거래처 정보 수정 동작
	public int clientUpdate(ClientVO vo) throws Exception;
	
	// 특정 거래처 정보 삭제 동작
	public int clientDelete(ClientVO vo) throws Exception;
	
}

