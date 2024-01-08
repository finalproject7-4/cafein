package com.cafein.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.MemberVO;
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

	// 출하 조회 (페이징)
	@Override
	public List<ShipVO> getSHList(ShipVO svo) throws Exception{
		logger.debug("출하 조회 성공");
		return sqlSession.selectList(NAMESPACE+".getSHList",svo);
	}
	
	// 총 개수
	@Override
	public int countSH(ShipVO svo) throws Exception {
		logger.debug("DAO : countSH(svo)");
		return sqlSession.selectOne(NAMESPACE+".countSH",svo);
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
	
	// 출하 등록 - 재고량
	@Override
	public List<WorkVO> registST() throws Exception {
		logger.debug("DAO : 출하 조회/작업지시코드");
		return sqlSession.selectList(NAMESPACE+".stList");
	}
	
	// 출하 등록 - 멤버 코드
	@Override
	public List<ShipVO> registMC() throws Exception {
		logger.debug("DAO : 출하 멤버코드");
		return sqlSession.selectList(NAMESPACE+".mcList");
	}

	// 출하 코드생성
	@Override
	public int getSHCount(ShipVO svo) throws Exception {
		logger.debug("DAO : getShipCount(ShipVO svo)");
		return sqlSession.selectOne(NAMESPACE + ".getSHCount", svo);
	}
	
	// 출하 검색 
	@Override
	public List<ShipVO> searchSHList(Map<String, Object> searchParams) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".searchSHList", searchParams);
	}
	
	// 출하 수정
	@Override
	public int updateSH(ShipVO svo) throws Exception {
		logger.debug("DAO : SHModify(ShipVO svo)");
		return sqlSession.update(NAMESPACE + ".updateSH", svo);
	}
	
	
	
	

	// 작업 지시 조회
	@Override
	public List<WorkVO> getWKList(WorkVO wvo) throws Exception {
		logger.debug("작업 지시 조회 성공");
		return sqlSession.selectList(NAMESPACE+".getWKList",wvo);
	}
	
	// 총 개수
	@Override
	public int countWK(WorkVO wvo) throws Exception {
		logger.debug("DAO : countWK(wvo)");
		return sqlSession.selectOne(NAMESPACE+".countWK",wvo);
	}
	
//	// 작업 지시 검색
//	@Override
//	public List<WorkVO> searchWKList(String keyword) throws Exception {
//	    return sqlSession.selectList(NAMESPACE + ".searchWKList", keyword);
//	}



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
		return sqlSession.update(NAMESPACE + ".updateWK", wvo);
	}

	// 작업 지시 삭제
	@Override
	public void deleteWK(WorkVO wvo) throws Exception {
		logger.debug("DAO - deleteWK(WorkVO wvo)");
		sqlSession.delete(NAMESPACE + ".deleteWK", wvo);
	}

	
	
	
	// 실적 조회
	@Override
	public List<WorkVO> getPFList(WorkVO wvo) throws Exception {
		logger.debug("실적 조회 성공");
		return sqlSession.selectList(NAMESPACE+".getPFList",wvo);
	}
	
	// 총 개수
	@Override
	public int countPF(WorkVO wvo) throws Exception {
		logger.debug("DAO : countPF(wvo)");
		return sqlSession.selectOne(NAMESPACE+".countPF",wvo);
	}

	// 실적 수정
	@Override
	public int updatePF(WorkVO wvo) throws Exception {
		logger.debug("DAO : PFModify(WorkVO wvo)");
		return sqlSession.update(NAMESPACE + ".updatePF", wvo);
	}

	
	

}