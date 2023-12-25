package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafein.domain.QualityVO;

@Repository
public class QualityDAOImpl implements QualityDAO {
	
	private static final String NAMESPACE = "com.cafein.mapper.qualityMapper";

	@Inject
	private SqlSession sqlSession;

	// 품질 관리 목록 (생산 / 반품)
	@Override
	public List<QualityVO> selectQualityList() throws Exception{
	
		return sqlSession.selectList(NAMESPACE + ".selectQualityList");
	}
	
	// 품질 관리 목록 검색 버튼 (생산 / 반품)
	@Override
	public List<QualityVO> selectQualityListSearchBtn(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectQualityListSearchBtn", vo);
	}
	
	// 품질 관리 목록 검색 버튼 개수 확인 (생산 / 반품)
	@Override
	public Integer selectQualityListSearchBtnCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectQualityListSearchBtnCount", vo);
	}

	// 검수 입력 (생산)
	@Override
	public int updateProduceAudit(QualityVO vo) throws Exception{
		return sqlSession.update(NAMESPACE + ".updateProduceAudit", vo);
	}

	// 검수 입력 - 완료 (생산)
	@Override
	public int updateProduceAuditFull(QualityVO vo) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.update(NAMESPACE + ".updateProduceAuditFull", vo);
	}
	
	// 검수 - 합격 / 불합격 (생산)
	@Override
	public int updateProduceQualityCheck(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(NAMESPACE + ".updateProduceQualityCheck", vo);
	}
	
	// 검수ID 입력 (반품 테이블)
	@Override
	public void updateReturnsQualityid(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(NAMESPACE + ".updateReturnsQualityid", vo);
	}

	// 검수 입력 (반품)
	@Override
	public int updateReturnAudit(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(NAMESPACE + ".updateReturnAudit", vo);
	}

	// 검수 입력 - 완료 (반품)
	@Override
	public int updateReturnAuditFull(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(NAMESPACE + ".updateReturnAuditFull", vo);
	}
	
	// 불량 현황 등록 (생산 / 반품)
	@Override
	public int insertDefects(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(NAMESPACE + ".insertDefects", vo);
	}
	
	// 불량 현황 목록 (생산 / 반품)
	@Override
	public List<QualityVO> selectDefectsList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectDefectsList");
	}
	
	// 불량 현황 목록 검색 버튼 (생산 / 반품)
	@Override
	public List<QualityVO> selectDefectsListSearchBtn(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectDefectsListSearchBtn", vo);
	}
	
	// 불량 현황 목록 검색 버튼 개수 확인 (생산 / 반품)
	@Override
	public Integer selectDefectsListSearchBtnCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectDefectsListSearchBtnCount", vo);
	}
	
	// 재고 등록 여부 업데이트
	// StockDAO 참고
	
	// 반품 등록 여부 업데이트
	@Override
	public void updateRegisterDefect(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(NAMESPACE + ".updateRegisterDefect", vo);	
	}


	
	
	

	
	
	
	

	
	
	
	
	
	
	
	
	
	
	

}
