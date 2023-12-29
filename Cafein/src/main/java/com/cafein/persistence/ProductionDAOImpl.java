package com.cafein.persistence;


import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.BomVO;
import com.cafein.domain.Criteria;
import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;

@Repository

public class ProductionDAOImpl implements ProductionDAO {
	
	
	private static final Logger logger = LoggerFactory.getLogger(ProductionDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.cafein.mapper.ProductionMapper";
	
	// 생산지시 목록조회 메서드
	@Override
	public List<ProduceVO> getProduceList(ProduceVO vo) throws Exception{
		logger.debug("DAO - 생산지시 목록 조회 getProduceList() 실행!");
		logger.debug("produceList : "+ vo.getStartDate());
		logger.debug("DAO - vo end : "+ vo.getEndDate());
	
		return sqlSession.selectList(NAMESPACE+".getProduceList", vo);
	}
	

	// 생산지시 글 개수 확인
	@Override
	public int getProdueCount() throws Exception {
		logger.debug("DAO - 작업지시 수량 몇개? ");
		return sqlSession.selectOne(NAMESPACE+".countProduceList");
	}

	// BOM 목록 조회 메서드
	@Override
	public List<BomVO> getBomList() throws Exception {
		logger.debug("DAO - 생산지시 목록 조회 getBomList() 실행!");
		return sqlSession.selectList(NAMESPACE+".getBomList");
	}
	
	// 생산지시 등록
	@Override
	public void insertProducePlan(ProduceVO vo) throws Exception {
		logger.debug("DAO - 생산지시 등록 regProduce() 실행!");
		
		sqlSession.insert(NAMESPACE+".insertProducePlan", vo);
		
	}
	
	// BOM 등록
	@Override
	public void insertBom(BomVO vo) throws Exception {
		logger.debug("DAO -  BOM 등록 insertBom() 실행!");
		
		sqlSession.insert(NAMESPACE+".insertBom", vo);
		
	}
	
	
	// BOM 등록되지 않은 품목 조회
	@Override
	public List<ItemVO> getNewItem() throws Exception {
		logger.debug("DAO -  BOM 등록안된 품목 getNewItem() 실행!");
		
		return sqlSession.selectList(NAMESPACE+".getNewItem");
		
	}


	// 품목 리스트 조회
	@Override
	public List<ItemVO> getItemList() throws Exception {
		logger.debug("DAO - 품목 리스트 조회 getItemList() 실행!");
		
		return sqlSession.selectList(NAMESPACE+".getItemList");
	}
	
	

	
	
	
	
	


	
	


	
	

	

	
}
