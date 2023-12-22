package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ClientVO;

public interface ClientDAO {
	
	public void insertClient(ClientVO vo) throws Exception;

	public List<ClientVO> getClientList() throws Exception;
}
