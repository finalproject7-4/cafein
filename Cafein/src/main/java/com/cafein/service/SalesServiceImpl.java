package com.cafein.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.SalesVO;
import com.cafein.domain.TestVO;
import com.cafein.persistence.SalesDAO;
import com.cafein.persistence.TestDAO;

@Service
public class SalesServiceImpl implements SalesService {

	private static final Logger logger = LoggerFactory.getLogger(SalesServiceImpl.class);

	@Inject
	private SalesDAO sdao;

	@Override
	public void purorders(SalesVO svo) {
		logger.debug("purorders 메서드 호출");
		sdao.insertPOList(svo);
		
	}


	

}
