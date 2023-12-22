package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.OrdersVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.persistence.OrdersDAO;
import com.cafein.persistence.ReceiveDAO;

@Service
public class ReceiveServiceImpl implements ReceiveService {

	private static final Logger logger = LoggerFactory.getLogger(ReceiveServiceImpl.class);

	@Inject
	private ReceiveDAO rvdao;
	
	@Override
	public List<ReceiveVO> receiveList() throws Exception {
		logger.debug("Service - receiveList()");
		return rvdao.getReceiveList();
	}

}
