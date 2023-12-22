package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.QualityVO;

public interface QualityDAO {
	
	// 품질 관리 목록 (생산 / 반품)
	public List<QualityVO> selectQualityList() throws Exception;

	// 검수 폼 출력 (생산)
	public QualityVO selectProduceInfo(int produceid) throws Exception;
	
	// 검수 입력 (생산)
	public int updateProduceAudit(QualityVO vo) throws Exception;
	
	// 검수 입력 - 완료 (생산)
	public int updateProduceAuditFull(QualityVO vo) throws Exception;
	
	// 검수 - 합격 / 불합격 (생산)
	public int updateProduceQualityCheck(QualityVO vo) throws Exception;
	
	// 검수 폼 출력 (반품)
	public QualityVO selectReturnInfo(int returnid) throws Exception;
	
	// 검수 입력 (반품)
	public int updateReturnAudit(QualityVO vo) throws Exception;
	
	// 검수 입력 - 완료 (반품)
	public int updateReturnAuditFull(QualityVO vo) throws Exception;
	
	// 불량 현황 목록 (생산 / 반품)
	public List<QualityVO> selectDefectsList() throws Exception;
	
	// 불량 현황 폼 출력 (생산 / 반품)
	public QualityVO selectDefectInfo(int qualityid) throws Exception;
	
	// 불량 현황 등록 (생산 / 반품)
	public int insertDefects(QualityVO vo) throws Exception;
	
	// 불량 현황 중복 확인 (생산 / 반품)
	public Integer selectDupilcateDefects(int qualityid) throws Exception;
}
