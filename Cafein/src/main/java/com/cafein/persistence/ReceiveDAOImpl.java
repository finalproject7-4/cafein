package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.OrdersVO;
import com.cafein.domain.ReceiveVO;

@Repository
public class ReceiveDAOImpl implements ReceiveDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ReceiveDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.cafein.mapper.ReceiveMapper";
	
	@Override
	public List<ReceiveVO> getReceiveList() throws Exception {
		logger.debug("DAO - getReceiveList()");
		return sqlSession.selectList(NAMESPACE + ".receiveList");
	}

}
