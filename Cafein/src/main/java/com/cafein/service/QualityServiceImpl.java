package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.QualityVO;
import com.cafein.persistence.QualityDAO;

@Service
public class QualityServiceImpl implements QualityService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(QualityServiceImpl.class);

	@Inject
	private QualityDAO qdao;

	
	// 품질 관리 목록 (생산 / 반품)
	@Override
	public List<QualityVO> qualityList() throws Exception{

		return qdao.selectQualityList();
	}

	// 검수 폼 출력 (생산)
	@Override
	public QualityVO produceInfo(int produceid) throws Exception{
		// TODO Auto-generated method stub
		return qdao.selectProduceInfo(produceid);
	}

	// 검수 입력 (생산)
	@Override
	public int produceAudit(QualityVO vo) throws Exception{
		// TODO Auto-generated method stub
		return qdao.updateProduceAudit(vo);
	}

	// 검수 입력 - 완료 (생산)
	@Override
	public int productAuditFull(QualityVO vo) throws Exception{
		// TODO Auto-generated method stub
		return qdao.updateProduceAuditFull(vo);
	}
	
	// 검수 - 합격 / 불합격 (생산)
	@Override
	public int productQualityCheck(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.updateProduceQualityCheck(vo);
	}

	// 검수 폼 출력 (반품)
	@Override
	public QualityVO returnInfo(int returnid) throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectReturnInfo(returnid);
	}

	// 검수 입력 (반품)
	@Override
	public int returnAudit(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.updateReturnAudit(vo);
	}

	// 검수 입력 - 완료 (반품)
	@Override
	public int returnAuditFull(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.updateReturnAuditFull(vo);
	}
	
	// 불량 현황 목록 (생산 / 반품)
	@Override
	public List<QualityVO> defectsList() throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectDefectsList();
	}
	
	// 불량 현황 폼 출력 (생산 / 반품)
	@Override
	public QualityVO defectInfo(int qualityid) throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectDefectInfo(qualityid);
	}

	// 불량 현황 등록 (생산 / 반품)
	@Override
	public int produceReturnDefects(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.insertDefects(vo);
	}

	// 불량 현황 중복 확인 (생산 / 반품)
	@Override
	public Integer duplicateDefects(int qualityid) throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectDupilcateDefects(qualityid);
	}
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
