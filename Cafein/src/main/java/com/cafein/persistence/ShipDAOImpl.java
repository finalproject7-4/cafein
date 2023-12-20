package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.ShipVO;

@Repository
public class ShipDAOImpl implements ShipDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ShipDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	// mapper
	private static final String NAMESPACE ="com.cafein.mapper.ShipMapper";

	// 출하 조회
	@Override
	public List<ShipVO> getSHList() throws Exception{
		logger.debug("출하 조회 성공");
		return sqlSession.selectList(NAMESPACE+".getSHList");
	}
	
	
	

}