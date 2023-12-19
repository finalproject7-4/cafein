package com.cafein.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.SalesVO;
import com.cafein.domain.TestVO;


@Repository
public class SalesDAOImpl implements SalesDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SalesDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	// mapper 위치정보
	private static final String NAMESPACE ="com.cafein.mapper.SalesMapper";

	@Override
	public void insertPOList(SalesVO svo) {
		logger.debug("수주정보");
		sqlSession.insert(NAMESPACE+".insertPOList",svo);
	}
	
	
	

}
