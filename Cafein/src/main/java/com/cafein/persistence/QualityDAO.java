package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.QualityVO;

public interface QualityDAO {
	
	// 품질 관리 목록 (생산 / 반품)
	public List<QualityVO> selectQualityList() throws Exception;
	
	// 품질 관리 목록 검색 버튼 (생산 / 반품)
	public List<QualityVO> selectQualityListSearchBtn(QualityVO vo) throws Exception;
	
	// 품질 관리 목록 검색 버튼 개수 확인 (생산 / 반품)
	public Integer selectQualityListSearchBtnCount(QualityVO vo) throws Exception;
	
	// 품질 관리 목록 검색 버튼 (자재)
	public List<QualityVO> selectMaterialQualityListSearchBtn(QualityVO vo) throws Exception;
	
	// 품질 관리 목록 검색 버튼 개수 확인 (자재)
	public Integer selectMaterialQualityListSearchBtnCount(QualityVO vo) throws Exception;
	
	// 검수 입력 (생산)
	public int updateProduceAudit(QualityVO vo) throws Exception;
	
	// 검수 입력 - 완료 (생산)
	public int updateProduceAuditFull(QualityVO vo) throws Exception;
	
	// 검수 - 합격 / 불합격 (생산)
	public int updateProduceQualityCheck(QualityVO vo) throws Exception;
	
	// 검수ID 입력 (반품 테이블)
	public void updateReturnsQualityid(QualityVO vo) throws Exception;
	
	// 검수 입력 (반품)
	public int updateReturnAudit(QualityVO vo) throws Exception;
	
	// 검수 입력 - 완료 (반품)
	public int updateReturnAuditFull(QualityVO vo) throws Exception;
	
	// 불량 현황 목록 (생산 / 반품)
	public List<QualityVO> selectDefectsList() throws Exception;
	
	// 불량 현황 목록 검색 버튼 (생산 / 반품)
	public List<QualityVO> selectDefectsListSearchBtn(QualityVO vo) throws Exception;
	
	// 불량 현황 목록 검색 버튼 개수 확인 (생산 / 반품)
	public Integer selectDefectsListSearchBtnCount(QualityVO vo) throws Exception;
	
	// 불량 현황 목록 검색 버튼 (자재)
	public List<QualityVO> selectMaterialDefectsListSearchBtn(QualityVO vo) throws Exception;
	
	// 불량 현황 목록 검색 버튼 개수 확인 (자재)
	public Integer selectMaterialDefectsListSearchBtnCount(QualityVO vo) throws Exception;
	
	// 불량 현황 등록 (생산 / 반품)
	public int insertDefects(QualityVO vo) throws Exception;
	
	// 재고 등록 여부 업데이트
	// StockDAO 참고
	
	// 반품 등록 여부 업데이트
	public void updateRegisterDefect(QualityVO vo) throws Exception;
	
	// 품질 관리 엑셀용 출력 목록 조회 (생산 + 반품)
	public List<QualityVO> selectQualityListSearchBtnExcel(QualityVO vo) throws Exception;

	// 품질 관리 엑셀용 출력 목록 조회 (자재)
	public List<QualityVO> selectMaterialQualityListSearchBtnExcel(QualityVO vo) throws Exception;

	// 불량 현황 엑셀용 출력 목록 조회 (생산 + 반품)
	public List<QualityVO> selectDefectsListSearchBtnExcel(QualityVO vo) throws Exception;
	
	// 불량 현황 엑셀용 출력 목록 조회 (자재)
	public List<QualityVO> selectMaterialDefectsListSearchBtnExcel(QualityVO vo) throws Exception;

	// roastedBean 검수, 불량 처리 (포장)
	public void updateRoastedBeanDefect(QualityVO vo) throws Exception;
	
	// 품질 관리 토스트 데이터 조회 (생산 + 반품)
	public QualityVO selectProductQualityToast() throws Exception;
	
	// 품질 관리 토스트 데이터 조회 (자재)
	public QualityVO selectMaterialQualityToast() throws Exception;
	
	// 반품 번호 생성 (원자재)
	public String createMotReturnCode() throws Exception;
	
	// 반품 번호 생성 (부자재)
	public String createSatReturnCode() throws Exception;
	
	// 반품 입력 (원자재)
	public void insertMotReturns(QualityVO vo) throws Exception;
	
	// 반품 입력 (부자재)
	public void insertSatReturns(QualityVO vo) throws Exception;
	
}
