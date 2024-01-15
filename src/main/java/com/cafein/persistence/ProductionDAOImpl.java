package com.cafein.persistence;


import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.ProduceVO;

@Repository

public class ProductionDAOImpl implements ProductionDAO {
	
	
	private static final Logger logger = LoggerFactory.getLogger(ProductionDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.cafein.mapper.ProductionMapper";
	
	// 생산지시 목록조회 메서드
	@Override
	public List<ProduceVO> getProduceList(ProduceVO vo) {
		logger.debug("DAO - 생산지시 목록 조회 getProduceList() 실행!");
		logger.debug("produceList : "+ vo.getStartDate());
		logger.debug("DAO - vo end : "+ vo.getEndDate());
	
		return sqlSession.selectList(NAMESPACE+".getProduceList", vo);
	}


	
	

	

	
}
