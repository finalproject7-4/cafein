package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.SalesVO;
import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;
import com.cafein.persistence.ShipDAO;

@Service
public class ShipServiceImpl implements ShipService {

	private static final Logger logger = LoggerFactory.getLogger(ShipServiceImpl.class);

	@Inject
	private ShipDAO shdao;
	
	// 출하 조회
	@Override
	public List<ShipVO> AllSHList() throws Exception{
		logger.debug("AllSHList()");
		return shdao.getSHList();
	}

	// 출하 등록
	@Override
	public void registSH(ShipVO svo) throws Exception {
		logger.debug("registSHList 메서드 호출");
		shdao.registSH(svo);
		
	}
	
	// 출하등록 - 작업지시코드
	@Override
	public List<WorkVO> registWC() throws Exception {
		logger.debug("S :registWC()");
		return shdao.registWC();
	}
	

	// 작업 지시 조회
	@Override
	public List<WorkVO> AllWKList() throws Exception {
		logger.debug("AllWKList()");
		return shdao.getWKList();
	}
	
	// 작업 지시 등록
	@Override
	public void registWK(WorkVO wvo) throws Exception {
		logger.debug("registWKList 메서드 호출");
		shdao.registWK(wvo);
	}

	// 실적 조회
	@Override
	public List<WorkVO> AllPFList() throws Exception {
		logger.debug("AllPFList()");
		return shdao.getPFList();
	}

	// 실적 등록
	@Override
	public void registPF(WorkVO wvo) throws Exception {
		logger.debug("registPFList 메서드 호출");
		shdao.registWK(wvo);
	}



}