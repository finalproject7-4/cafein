package com.cafein.persistence;

import java.util.Collections;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.ReturnVO;

@Repository
public class ReturnDAOImpl implements ReturnDAO {

    private static final Logger logger = LoggerFactory.getLogger(ReturnDAOImpl.class);

    @Inject
    private SqlSession sqlSession;
    
    private static final String NAMESPACE = "com.cafein.mapper.ReturnMapper";

	@Override
	public List<ReturnVO> searchReturns() throws Exception {

		return sqlSession.selectList(NAMESPACE + ".searchReturns") ;
	}

	@Override
	public List<ReturnVO> searchReturnsByCondition(ReturnVO rvo) throws Exception {
		
		return sqlSession.selectList(NAMESPACE + ".searchReturnsByCondition", rvo);
	}

	@Override
	public int getReturnCount(ReturnVO rvo) throws Exception {

		return sqlSession.selectOne(NAMESPACE +".getReturnCount", rvo);
	}

	@Override
	public void insertReturn(ReturnVO rvo) throws Exception {
		
		sqlSession.insert(NAMESPACE + ".insertReturn", rvo);
	}

	@Override
	public List<ProduceVO> prList() throws Exception {

		return sqlSession.selectList(NAMESPACE + ".prList");
	}

	@Override
	public List<ItemVO> itList() throws Exception {

		return sqlSession.selectList(NAMESPACE + ".itList");
	}
	
	@Override
	public int updateReturn(ReturnVO rvo) throws Exception {

		return sqlSession.update(NAMESPACE + ".updateReturn", rvo);
	}

	
	
	
}