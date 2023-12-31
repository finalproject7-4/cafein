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

	// 검수 폼 출력 (생산)
	@Override
	public QualityVO selectProduceInfo(int produceid) throws Exception{
		return sqlSession.selectOne(NAMESPACE + ".selectProduceInfo", produceid);
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

	// 검수 폼 출력 (반품)
	@Override
	public QualityVO selectReturnInfo(int returnid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectReturnInfo", returnid);
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
	
	// 불량 현황 목록 (생산 / 반품)
	@Override
	public List<QualityVO> selectDefectsList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectDefectsList");
	}
	
	// 불량 현황 폼 출력 (생산 / 반품)
	@Override
	public QualityVO selectDefectInfo(int qualityid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectDefects", qualityid);
	}

	// 불량 현황 등록 (생산 / 반품)
	@Override
	public int insertDefects(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(NAMESPACE + ".insertDefects", vo);
	}

	// 불량 현황 중복 확인 (생산 / 반품)
	@Override
	public Integer selectDupilcateDefects(int qualityid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectDupilcateDefects", qualityid);
	}

	
	
	
	

	
	
	
	
	
	
	
	
	
	
	

}
