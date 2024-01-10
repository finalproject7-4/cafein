package com.cafein.persistence;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.Criteria;
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
	public List<ReturnVO> searchReturns(Criteria cri) throws Exception {

		return sqlSession.selectList(NAMESPACE + ".searchReturns",cri) ;
	}

	@Override
	public List<ReturnVO> searchReturnsByCondition(ReturnVO rvo,Criteria cri) throws Exception {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("rvo", rvo);
		paramMap.put("cri", cri);
		logger.debug("paramMap : " + paramMap);
		
		return sqlSession.selectList(NAMESPACE + ".searchReturnsByCondition", paramMap);
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
	public List<ItemVO> itList() throws Exception {

		return sqlSession.selectList(NAMESPACE + ".itList");
	}
	
	@Override
	public int updateReturn(ReturnVO rvo) throws Exception {
		
		System.out.println("DAO : 수정");

		return sqlSession.update(NAMESPACE + ".updateReturn", rvo);
	}

	@Override
	public void deleteReturn(int rvo) throws Exception {
		
		sqlSession.delete(NAMESPACE + ".deleteReturn", rvo);
	}

	@Override
	public void addReturn(int returnid) throws Exception {
		
		sqlSession.insert(NAMESPACE + ".addReturn",returnid);
	}

	@Override
	public void refundDate(String returnCode) throws Exception {

		sqlSession.insert(NAMESPACE + ".refundDate",returnCode); 
	}

	@Override
	public int returnPageCnt(ReturnVO rvo) throws Exception {
		
		return sqlSession.selectOne(NAMESPACE + ".returnPageCnt", rvo);
	}

	@Override
	public int returnAllCnt() throws Exception {
		
		return sqlSession.selectOne(NAMESPACE + ".returnAllCnt");
	}

	@Override
	public List<ReturnVO> returnListExcel(ReturnVO rvo) throws Exception {
		
		return sqlSession.selectList(NAMESPACE + ".returnListExcel", rvo);
	}
	
	
	
	
	
	
	
	
}