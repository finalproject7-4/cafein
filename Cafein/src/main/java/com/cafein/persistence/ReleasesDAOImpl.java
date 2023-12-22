package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.OrdersVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;

@Repository
public class ReleasesDAOImpl implements ReleasesDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ReleasesDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.cafein.mapper.ReleasesMapper";
	
	@Override
	public List<ReleasesVO> getReleasesList() throws Exception {
		logger.debug("DAO - getReleasesList()");
		return sqlSession.selectList(NAMESPACE + ".releasesList");
	}

}
