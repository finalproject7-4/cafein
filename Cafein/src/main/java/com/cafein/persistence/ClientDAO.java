package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ClientVO;
import com.cafein.domain.Criteria;

public interface ClientDAO {
	
	// 거래처 등록 동작
	public void insertClient(ClientVO vo) throws Exception;

	// 거래처 목록 조회
	public List<ClientVO> getClientListPage(int page) throws Exception;
	public List<ClientVO> getClientListPage(Criteria cri) throws Exception;
	
	// 거래처 정보를 list에 담아오는 동작
	public List<ClientVO> getClientList() throws Exception;
	
	// 총 거래처 수 조회
	public int getClientCount() throws Exception;
	
	// 거래처 정보 조회
	public ClientVO getClient(int clientid) throws Exception;
	
	// 거래처 정보 수정
	public int updateClient(ClientVO vo) throws Exception;
	
	// 거래처 정보 삭제
	public int deleteClient(ClientVO vo) throws Exception;
}
