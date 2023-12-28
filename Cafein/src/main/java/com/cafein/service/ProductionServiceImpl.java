package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.BomVO;
import com.cafein.domain.ProduceVO;
import com.cafein.persistence.ProductionDAO;

@Service
public class ProductionServiceImpl implements ProductionService{
	
	private static final Logger logger = LoggerFactory.getLogger(ProductionServiceImpl.class);
	
	@Inject
	private ProductionDAO pdao;
	

	// 생산 목록 조회
	@Override
	public List<ProduceVO> getProduceList(ProduceVO vo) throws Exception{
		logger.debug("Service - 생산지시 목록 조회 getProduceList() 실행");
		return pdao.getProduceList(vo);
	}


	// BOM 목록 조회
	@Override
	public List<BomVO> getBomList() throws Exception {
		logger.debug("Service - BOM 목록 조회 getBomList() 실행");
		return pdao.getBomList();
	}


	// 생산지시 등록
	@Override
	public void regProduce(ProduceVO vo) throws Exception {
		logger.debug("Service - 생산지시 등록 regProduce() 실행");
		pdao.insertProducePlan(vo);
	}
	
	

	
	
	
	

	

	
	
	
	
	
	
}
