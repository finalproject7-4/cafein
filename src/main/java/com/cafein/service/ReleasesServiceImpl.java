package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.OrdersVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;
import com.cafein.persistence.OrdersDAO;
import com.cafein.persistence.ReceiveDAO;
import com.cafein.persistence.ReleasesDAO;

@Service
public class ReleasesServiceImpl implements ReleasesService {

	private static final Logger logger = LoggerFactory.getLogger(ReleasesServiceImpl.class);

	@Inject
	private ReleasesDAO rsdao;
	
	@Override
	public List<ReleasesVO> releasesList() throws Exception {
		logger.debug("Service - releasesList()");
		return rsdao.getReleasesList();
	}

}
