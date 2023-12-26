package com.cafein.service;

import java.util.List;

import com.cafein.domain.ClientVO;

public interface CleintService {
	
	public void clientJoin(ClientVO vo) throws Exception;
	
	public List<ClientVO> clientList() throws Exception;

}
