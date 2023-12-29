package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.ClientVO;
import com.cafein.domain.Criteria;

@Repository
public class ClientDAOImpl implements ClientDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ClientDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.cafein.mapper.ClientMapper";

	@Override
	public void insertClient(ClientVO vo) {
		logger.debug(" DAO : 거래처 등록 insertClient(ClientVO vo) ");
		sqlSession.insert(NAMESPACE + ".insertClient", vo);
	}

	@Override
	public List<ClientVO> getClientListPage(int page) throws Exception {
		logger.debug(" DAO : 거래처 목록 조회 getClientListPage(int page) ");
		
		page = (page - 1) *10;
		return sqlSession.selectList(NAMESPACE + ".getClientListPage", page);
	}
	
	@Override
	public List<ClientVO> getClientListPage(Criteria cri) throws Exception {
		logger.debug(" DAO : 거래처 목록 조회 getClientListPage(Criteria cri) ");
		return sqlSession.selectList(NAMESPACE + ".getClientListPage", cri);
	}
	
	@Override
	public List<ClientVO> getClientList() throws Exception {
		logger.debug(" DAO : 거래처 정보를 list에 담아오는 동작 getClientList() ");
		return sqlSession.selectList(NAMESPACE + ".getClientList");
	}
	
	@Override
	public int getClientCount() throws Exception {
		logger.debug(" DAO : 총 거래처 수 조회 getClientCount() ");
		return sqlSession.selectOne(NAMESPACE + ".countClient");
	}
	
	@Override
	public ClientVO getClient(int clientid) throws Exception {
		logger.debug(" DAO : 거래처 정보 조회 getClient(int clientid) ");
		return sqlSession.selectOne(NAMESPACE + ".getClient", clientid);
	}

	@Override
	public int updateClient(ClientVO vo) throws Exception {
		logger.debug(" DAO : 거래처 정보 수정 updateClient(ClientVO vo) ");
		return sqlSession.update(NAMESPACE + ".updateClient", vo);
	}

	@Override
	public int deleteClient(ClientVO vo) throws Exception {
		logger.debug(" DAO : 거래처 정보 삭제(비활성화) deleteClient(ClientVO vo) ");
		return sqlSession.update(NAMESPACE + ".deleteClient", vo);
	}

}


























