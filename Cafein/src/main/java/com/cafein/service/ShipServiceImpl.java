package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;
import com.cafein.persistence.ShipDAO;

@Service
public class ShipServiceImpl implements ShipService {

	private static final Logger logger = LoggerFactory.getLogger(ShipServiceImpl.class);

	@Inject
	private ShipDAO shdao;
	
	/*출하 조회*/
	@Override
	public List<ShipVO> AllSHList() throws Exception{
		logger.debug("AllSHList()");
		return shdao.getSHList();
	}

	@Override
	public List<WorkVO> AllWKList() throws Exception {
		logger.debug("AllWKList()");
		return shdao.getWKList();
	}

	@Override
	public List<WorkVO> AllPFList() throws Exception {
		logger.debug("AllPFList()");
		return shdao.getPFList();
	}
	
	
	
	



	

}