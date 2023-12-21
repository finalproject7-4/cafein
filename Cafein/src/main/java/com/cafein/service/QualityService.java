package com.cafein.service;

import java.util.List;

import com.cafein.domain.QualityVO;

public interface QualityService {
	
	// 품질 관리 목록 (생산 / 반품)
	public List<QualityVO> qualityList() throws Exception;
	
	// 검수 폼 출력 (생산)
	public QualityVO produceInfo(int produceid) throws Exception;
	
	// 검수 입력 (생산)
	public int produceAudit(QualityVO vo) throws Exception;
	
	// 검수 입력 - 완료 (생산)
	public int productAuditFull(QualityVO vo) throws Exception;
	
	// 검수 - 합격 / 불합격 (생산)
	public int productQualityCheck(QualityVO vo) throws Exception;
	
	// 검수 폼 출력 (반품)
	public QualityVO returnInfo(int returnid) throws Exception;
	
	// 검수 입력 (생산)
	public int returnAudit(QualityVO vo) throws Exception;
	
	// 검수 입력 - 완료 (생산)
	public int returnAuditFull(QualityVO vo) throws Exception;
	
	// 불량 현황 목록 (생산 / 반품)
	public List<QualityVO> defectsList() throws Exception;
	
	// 불량 현황 폼 출력 (생산 / 반품)
	public QualityVO defectInfo(int qualityid) throws Exception;
	
	// 불량 현황 등록 (생산 / 반품)
	public int produceReturnDefects(QualityVO vo) throws Exception;
	
	// 불량 현황 중복 확인 (생산 / 반품)
	public Integer duplicateDefects(int qualityid) throws Exception;

}
