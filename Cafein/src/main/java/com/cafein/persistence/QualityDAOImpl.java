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
	
	// 품질 관리 목록 검색 버튼 (자재)
	@Override
	public List<QualityVO> selectMaterialQualityListSearchBtn(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectMaterialQualityListSearchBtn", vo);
	}
	
	// 품질 관리 목록 검색 버튼 개수 확인 (자재)
	@Override
	public Integer selectMaterialQualityListSearchBtnCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectMaterialQualityListSearchBtnCount", vo);
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
	
	// 불량 현황 목록 검색 버튼 (자재)
	@Override
	public List<QualityVO> selectMaterialDefectsListSearchBtn(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectMaterialDefectsListSearchBtn", vo);
	}
	
	// 불량 현황 목록 검색 버튼 개수 조회 (자재)
	@Override
	public Integer selectMaterialDefectsListSearchBtnCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectMaterialDefectsListSearchBtnCount", vo);
	}
	
	// 재고 등록 여부 업데이트
	// StockDAO 참고
	
	// 반품 등록 여부 업데이트
	@Override
	public void updateRegisterDefect(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(NAMESPACE + ".updateRegisterDefect", vo);	
	}

	// 품질 관리 엑셀용 출력 목록 조회 (생산 + 반품)
	@Override
	public List<QualityVO> selectQualityListSearchBtnExcel(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectQualityListSearchBtnExcel", vo);
	}

	// 품질 관리 엑셀용 출력 목록 조회 (자재)
	@Override
	public List<QualityVO> selectMaterialQualityListSearchBtnExcel(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectMaterialQualityListSearchBtnExcel", vo);
	}

	// 불량 현황 엑셀용 출력 목록 조회 (생산 + 반품)
	@Override
	public List<QualityVO> selectDefectsListSearchBtnExcel(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectDefectsListSearchBtnExcel", vo);
	}

	// 불량 현황 엑셀용 출력 목록 조회 (자재)
	@Override
	public List<QualityVO> selectMaterialDefectsListSearchBtnExcel(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectMaterialDefectsListSearchBtnExcel", vo);
	}

	// roastedBean 검수, 불량 처리 (포장)
	@Override
	public void updateRoastedBeanDefect(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(NAMESPACE + ".updateRoastedBeanDefect", vo);
	}

	// 품질 관리 토스트 데이터 조회 (생산 + 반품)
	@Override
	public QualityVO selectProductQualityToast() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".productQualityToast");
	}

	// 품질 관리 토스트 데이터 조회 (자재)
	@Override
	public QualityVO selectMaterialQualityToast() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".materialQualityToast");
	}

	// 반품 번호 생성 (원자재)
	@Override
	public String createMotReturnCode() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".motReturnCode");
	}

	// 반품 번호 생성 (부자재)
	@Override
	public String createSatReturnCode() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".satReturnCode");
	}

	// 반품 입력 (원자재)
	@Override
	public void insertMotReturns(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(NAMESPACE + ".insertReturnsMOT", vo);
	}

	// 반품 입력 (부자재)
	@Override
	public void insertSatReturns(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(NAMESPACE + ".insertReturnsSAT", vo);
	}

	
	
	
	

	
	
	
	

	
	
	
	
	
	
	
	
	
	
	

}
