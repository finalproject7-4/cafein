package com.cafein.service;

import java.util.List;

import com.cafein.domain.QualityVO;

public interface QualityService {
	
	// 품질 관리 목록 (생산 / 반품)
	public List<QualityVO> qualityList() throws Exception;
	
	// 품질 관리 목록 검색 버튼 (생산 / 반품)
	public List<QualityVO> qualityListSearchBtn(QualityVO vo) throws Exception;

	// 품질 관리 목록 검색 버튼 개수 조회 (생산 / 반품)
	public Integer qualityListSearchBtnCount(QualityVO vo) throws Exception;
	
	// 품질 관리 목록 검색 버튼 (자재)
	public List<QualityVO> materialQualityListSearchBtn(QualityVO vo) throws Exception;
	
	// 품질 관리 목록 검색 버튼 개수 조회 (자재)
	public Integer materialQualityListSearchBtnCount(QualityVO vo) throws Exception;
	
	// 검수 입력 (생산)
	public int produceAudit(QualityVO vo) throws Exception;
	
	// 검수 입력 - 완료 (생산)
	public int productAuditFull(QualityVO vo) throws Exception;
	
	// 검수 - 합격 / 불합격 (생산)
	public int productQualityCheck(QualityVO vo) throws Exception;
	
	// 검수ID 입력 (반품 테이블)
	public void returnsQualityid(QualityVO vo) throws Exception;
	
	// 검수 입력 (반품)
	public int returnAudit(QualityVO vo) throws Exception;
	
	// 검수 입력 - 완료 (반품)
	public int returnAuditFull(QualityVO vo) throws Exception;
	
	// 불량 현황 등록 (생산 / 반품)
	public int produceReturnDefects(QualityVO vo) throws Exception;
	
	// 불량 현황 목록 (생산 / 반품)
	public List<QualityVO> defectsList() throws Exception;
	
	// 불량 현황 목록 검색 버튼 (생산 / 반품)
	public List<QualityVO> defectsListSearchBtn(QualityVO vo) throws Exception;
	
	// 불량 현황 목록 검색 버튼 개수 확인 (생산 / 반품)
	public Integer defectsListSearchBtnCount(QualityVO vo) throws Exception;
	
	// 불량 현황 목록 검색 버튼 (자재)
	public List<QualityVO> materialDefectsListSearchBtn(QualityVO vo) throws Exception;
	
	// 불량 현황 목록 검색 버튼 개수 조회 (자재)
	public Integer materialDefectsListSearchBtnCount(QualityVO vo) throws Exception;	
	
	// 재고 등록 여부 업데이트
	// stockService 참고
	
	// 반품 등록 여부 업데이트
	public void registerDefectY(QualityVO vo) throws Exception;
	
	// 품질 관리 엑셀용 출력 목록 조회 (생산 + 반품)
	public List<QualityVO> qualityListSearchBtnExcel(QualityVO vo) throws Exception;
	
	// 품질 관리 엑셀용 출력 목록 조회 (자재)
	public List<QualityVO> materialQualityListSearchBtnExcel(QualityVO vo) throws Exception;

	// 불량 현황 엑셀용 출력 목록 조회 (생산 + 반품)
	public List<QualityVO> defectsListSearchBtnExcel(QualityVO vo) throws Exception;
	
	// 불량 현황 엑셀용 출력 목록 조회 (자재)
	public List<QualityVO> materialDefectsListSearchBtnExcel(QualityVO vo) throws Exception;

	// roastedBean 검수, 불량 처리 (포장)
	public void roastedBeanDefect(QualityVO vo) throws Exception;
	
	// 품질 관리 토스트 데이터 조회 (생산 + 반품)
	public QualityVO productQualityToast() throws Exception;
	
	// 품질 관리 토스트 데이터 조회 (자재)
	public QualityVO materialQualityToast() throws Exception;
	
	// 반품 번호 생성 (원자재)
	public String motReturnCode() throws Exception;
	
	// 반품 번호 생성 (부자재)
	public String satReturnCode() throws Exception;
	
	// 반품 입력 (원자재)
	public void motReturns(QualityVO vo) throws Exception;
	
	// 반품 입력 (부자재)
	public void satReturns(QualityVO vo) throws Exception;
}
