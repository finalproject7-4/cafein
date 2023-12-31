package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.BomVO;
import com.cafein.domain.Criteria;
import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.persistence.ProductionDAO;

@Service
public class ProductionServiceImpl implements ProductionService{
	
	private static final Logger logger = LoggerFactory.getLogger(ProductionServiceImpl.class);
	
	@Inject
	private ProductionDAO pdao;
	
	
	// AJAX생산 목록 조회
	@Override
	public List<ProduceVO> getProduceListAJAX(ProduceVO vo) throws Exception{
		logger.debug("Service - 생산지시 목록 조회 getProduceList() 실행");
		return pdao.getProduceListAJAX(vo);
	}
	
	// AJAX 생산지시 목록 글 개수 확인
	@Override
	public Integer AJAXcountProduceList(ProduceVO vo) throws Exception {
		logger.debug("Service - 생산지시 수량은 몇개요???");
		return pdao.AJAXcountProduceList(vo);
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

	// BOM 등록
	@Override
	public void regBom(BomVO vo) throws Exception {
		logger.debug("Service - BOM 등록 regBom() 실행");
		
		pdao.insertBom(vo);
		
	}
	
	
	// BOM 등록되지 않은 품목
	@Override
	public List<ItemVO> getNewItem() throws Exception {
		logger.debug("Service - BOM 등록 안한 제품 getNewItem() 실행");
		
		return pdao.getNewItem();
		
	}


	// 품목 아이템 리스트 조회
	@Override
	public List<ItemVO> getItemList() throws Exception {
		logger.debug("Service - 품목 아이템리스트 조회 getItemList() 실행");
		
		return pdao.getItemList();
	}

	// 생산 상태 업데이트
	@Override
	public void updateProduceState(ProduceVO vo) throws Exception {
		logger.debug("Service - 생산 상태 업데이트 updateProduceState() 실행");
		
		pdao.updateProduceState(vo);
	}


	

	
	
	
	

	
	
	
	

	

	
	
	
	
	
	
}
