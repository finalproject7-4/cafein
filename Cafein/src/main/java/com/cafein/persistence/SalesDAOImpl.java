package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.ClientVO;
import com.cafein.domain.SalesVO;

@Repository
public class SalesDAOImpl implements SalesDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SalesDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	// mapper 위치정보
	private static final String NAMESPACE ="com.cafein.mapper.SalesMapper";

	// 수주 등록
	@Override
	public void registPO(SalesVO svo) throws Exception{
		logger.debug(" DAO : registPO(SalesVO svo)");
		sqlSession.insert(NAMESPACE+".registPO",svo);
	}
	
	// 수주 조회
	@Override
	public List<SalesVO> getPOList() throws Exception{
		logger.debug("수주조회");
		return sqlSession.selectList(NAMESPACE+".getPOList");
	}

	// 수주 등록-납품처
	@Override
	public List<SalesVO> registCli() throws Exception {
		logger.debug("수주조회-납품처");
		return sqlSession.selectList(NAMESPACE+".cliList");
	}

	// 수주 등록-품목
	@Override
	public List<SalesVO> registItem() throws Exception {
		logger.debug("수주조회-품목");
		return sqlSession.selectList(NAMESPACE+".iList");
	}

	
	
	

	
	

}
