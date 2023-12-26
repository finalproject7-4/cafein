package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.ClientVO;
import com.cafein.persistence.ClientDAO;

@Service
public class ClientServiceImpl implements CleintService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(ClientServiceImpl.class);
	
	@Inject
	private ClientDAO cdao;

	@Override
	public void clientJoin(ClientVO vo) throws Exception {
		logger.debug(" Service : 거래처 등록 clientJoin(ClientVO vo) ");
		cdao.insertClient(vo);
	}

	@Override
	public List<ClientVO> clientList() throws Exception {
		logger.debug(" Service : 거래처 목록 조회 clientList() ");
		return cdao.getClientList();
	}
	
	
	
	

}
