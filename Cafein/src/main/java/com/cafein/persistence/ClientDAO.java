package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ClientVO;

public interface ClientDAO {
	
	// 거래처 등록 동작
	public void insertClient(ClientVO vo) throws Exception;
	
	// 최신 등록된 거래처의 거래처 코드 확인
	public int getMaxClientCode(ClientVO vo) throws Exception;
	
	// 거래처 목록 조회 (페이징)
	public List<ClientVO> getClientPageList(ClientVO vo) throws Exception;
	
	// 총 거래처 수 조회
	public Integer getClientCount(ClientVO vo) throws Exception;

	// 거래처 정보를 list에 담아오는 동작
	public List<ClientVO> getClientList() throws Exception;
	
	// 거래처 정보 조회
	public ClientVO getClient(int clientid) throws Exception;
	
	// 거래처 정보 수정
	public int updateClient(ClientVO vo) throws Exception;
	
	// 거래처 정보 삭제
	public int deleteClient(ClientVO vo) throws Exception;
	
}
