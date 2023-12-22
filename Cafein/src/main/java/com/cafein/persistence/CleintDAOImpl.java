package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.ClientVO;

@Repository
public class CleintDAOImpl implements ClientDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(CleintDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.cafein.mapper.ClientMapper";

	@Override
	public void insertClient(ClientVO vo) {
		logger.debug(" DAO : 거래처 등록 insertClient(ClientVO vo) ");
		sqlSession.insert(NAMESPACE + ".insertClient", vo);
	}

	@Override
	public List<ClientVO> getClientList() throws Exception {
		logger.debug(" DAO : 거래처 목록 조회 getClientList() ");
		return sqlSession.selectList(NAMESPACE + ".getClientList");
	}
	
	

}


























