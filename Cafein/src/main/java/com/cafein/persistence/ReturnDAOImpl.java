package com.cafein.persistence;

import java.util.Collections;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.ReturnVO;

@Repository
public class ReturnDAOImpl implements ReturnDAO {

    private static final Logger logger = LoggerFactory.getLogger(ReturnDAOImpl.class);

    @Inject
    private SqlSession sqlSession;
    
    private static final String NAMESPACE = "com.cafein.mapper.ReturnsMapper";

	@Override
	public List<ReturnVO> searchReturns() throws Exception {
		
		return sqlSession.selectList(NAMESPACE + ".searchReturns");
	}

	@Override
	public List<ReturnVO> searchReturnsByCondition(ReturnVO condition) throws Exception {
		
		return sqlSession.selectList(NAMESPACE + ".searchReturnsByCondition", condition);
	}

	@Override
	public int getReturnCount(ReturnVO vo) throws Exception {
		
		return sqlSession.selectOne(NAMESPACE +".getReturnCount", vo);
	}

	

	
	
	
	
	
	
	
	
	
}