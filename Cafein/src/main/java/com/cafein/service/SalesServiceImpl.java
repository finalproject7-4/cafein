package com.cafein.service;

import java.util.List;

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
	
	/*수주조회*/
	@Override
	public List<SalesVO> AllPOList() {
		logger.debug("AllPOList()");
		return sdao.getPOList();
	}

	/*수주등록*/
	@Override
	public void registPO(SalesVO svo) {
		logger.debug("registPOList 메서드 호출");
		sdao.insertPOList(svo);
	}



	

}
