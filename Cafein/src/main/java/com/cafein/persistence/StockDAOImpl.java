package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.QualityVO;

@Repository
public class StockDAOImpl implements StockDAO {
	
	
	private static final Logger logger = LoggerFactory.getLogger(StockDAOImpl.class);
	
	private static final String NAMESPACE = "com.cafein.mapper.stockMapper";
	
	@Inject
	private SqlSession sqlSession;

	// 재고 목록 조회 (생산 [포장] + 반품)
	@Override
	public List<QualityVO> selectStockList() throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectStockList");
	}
	
	
	// roastedbean - LOT번호 조회
	@Override
	public String selectRoastedBeanLotNum(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectRoastedBeanLotNum", vo);
	}
	
	// receive - LOT번호 조회
	@Override
	public String selectReceiveLotNum(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectReceiveLotNum", vo);
	}
	
	// 재고 입력
	@Override
	public int insertStockList(QualityVO vo) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.insert(NAMESPACE + ".insertStock", vo);
	}


	// 재고 등록 중복 확인 (생산 [포장] + 반품)
	@Override
	public Integer selectDuplicateStock(int qualityid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectDupilcateStock", qualityid);
	}

	// 재고량 변경 (생산 [포장] + 반품)
	@Override
	public int updateStockQuantity(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(NAMESPACE + ".updateStockQuantity", vo);
	}

	// 창고 목록 조회 (생산 [포장] + 반품)
	@Override
	public List<QualityVO> selectStorageList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectStorageList");
	}

	// 창고 변경 (생산 [포장] + 반품)
	@Override
	public int updateStockStorage(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(NAMESPACE + ".updateStockStorage", vo);
	}

	// 재고 등록 여부 업데이트
	@Override
	public void updateRegisterStock(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(NAMESPACE + ".updateRegisterStock", vo);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
