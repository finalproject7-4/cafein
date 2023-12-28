package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.ClientVO;
import com.cafein.domain.MemberVO;
import com.cafein.persistence.ClientDAO;

@Service
public class ClientServiceImpl implements ClientService {
	
	
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

	@Override
	public ClientVO clientInfo(int clientid) throws Exception {
		logger.debug(" Service : 거래처 정보 조회 clientInfo(int clientid) ");
		return cdao.getClient(clientid);
	}

	@Override
	public int clientUpdate(ClientVO vo) throws Exception {
		logger.debug(" Service : 거래처 정보 수정 clientUpdate(ClientVO vo) ");
		return cdao.updateClient(vo);
	}

	@Override
	public int clientDelete(ClientVO vo) throws Exception {
		logger.debug(" Service : 거래처 정보 비활성화 clientDelete(ClientVO vo) ");
		return cdao.deleteClient(vo);
	}
	

}


























