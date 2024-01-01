package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.SalesVO;
import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;

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

	// 출하 등록
	@Override
	public void registSH(ShipVO svo) throws Exception {
		logger.debug(" DAO : registSH(ShipVO svo)");
		sqlSession.insert(NAMESPACE+".registSH",svo);
	}

	// 출하 등록 - 작업 지시 코드
	@Override
	public List<WorkVO> registWC() throws Exception {
		logger.debug("DAO : 출하 조회/작업지시코드");
		return sqlSession.selectList(NAMESPACE+".wcList");
	}

	// 작업 지시 조회
	@Override
	public List<WorkVO> getWKList() throws Exception {
		logger.debug("작업 지시 조회 성공");
		return sqlSession.selectList(NAMESPACE+".getWKList");
	}

	// 작업 지시 등록
	@Override
	public void registWK(WorkVO wvo) throws Exception {
		logger.debug(" DAO : registWK(WorkVO wvo)");
		sqlSession.insert(NAMESPACE+".registWK",wvo);
	}
	
	// 작업 지시 등록 - 수주 코드
	@Override
	public List<WorkVO> registPC() throws Exception {
		logger.debug("DAO : 작업지시 조회/수주코드");
		return sqlSession.selectList(NAMESPACE+".pcList");
	}
	
	// 작업 지시 코드 생성
	@Override
	public int getWKCount(WorkVO wvo) throws Exception {
		logger.debug("DAO : getWorkCount(WorkVO wvo)");
		return sqlSession.selectOne(NAMESPACE + ".getWKCount", wvo);
	}
	
	// 작업 지시 수정
	@Override
	public int updateWK(WorkVO wvo) throws Exception {
		logger.debug("DAO : WKModify(WorkVO wvo)");
		return sqlSession.selectOne(NAMESPACE + ".updateWK", wvo);
	}

	// 실적 조회
	@Override
	public List<WorkVO> getPFList() throws Exception {
		logger.debug("실적 조회 성공");
		return sqlSession.selectList(NAMESPACE+".getPFList");
	}

	@Override
	public void registPF(WorkVO wvo) throws Exception {
		logger.debug(" DAO : registPF(WorkVO wvo)");
		sqlSession.insert(NAMESPACE+".registPF",wvo);
	}
	
	

}