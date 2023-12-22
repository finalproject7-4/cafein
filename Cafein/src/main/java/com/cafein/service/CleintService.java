package com.cafein.service;

import java.util.List;

import com.cafein.domain.ClientVO;

public interface CleintService {
	
	public void clientJoin(ClientVO vo);
	
	public List<ClientVO> clientListAll();

}
