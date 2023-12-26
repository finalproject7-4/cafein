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
	
	// 품질 관리 목록 검색 버튼 (생산 / 반품)
	@Override
	public List<QualityVO> qualityListSearchBtn(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectQualityListSearchBtn(vo);
	}
	
	// 품질 관리 목록 검색 버튼 개수 조회 (생산 / 반품)
	@Override
	public Integer qualityListSearchBtnCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectQualityListSearchBtnCount(vo);
	}
	
	// 품질 관리 목록 검색 버튼 (자재)
	@Override
	public List<QualityVO> materialQualityListSearchBtn(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectMaterialQualityListSearchBtn(vo);
	}
	
	// 품질 관리 목록 검색 버튼 개수 조회 (자재)
	@Override
	public Integer materialQualityListSearchBtnCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectMaterialQualityListSearchBtnCount(vo);
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
	
	// 검수ID 입력 (반품 테이블)
	@Override
	public void returnsQualityid(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		qdao.updateReturnsQualityid(vo);
		
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
	
	// 불량 현황 등록 (생산 / 반품)
	@Override
	public int produceReturnDefects(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.insertDefects(vo);
	}
	
	// 불량 현황 목록 (생산 / 반품)
	@Override
	public List<QualityVO> defectsList() throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectDefectsList();
	}
	
	// 불량 현황 목록 검색 버튼 (생산 / 반품)
	@Override
	public List<QualityVO> defectsListSearchBtn(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectDefectsListSearchBtn(vo);
	}

	// 불량 현황 목록 검색 버튼 개수 확인 (생산 / 반품)
	@Override
	public Integer defectsListSearchBtnCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectDefectsListSearchBtnCount(vo);
	}
	
	// 불량 현황 목록 검색 버튼 (자재)
	@Override
	public List<QualityVO> materialDefectsListSearchBtn(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectMaterialDefectsListSearchBtn(vo);
	}
	
	// 불량 현황 목록 검색 버튼 개수 확인 (자재)
	@Override
	public Integer materialDefectsListSearchBtnCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return qdao.selectMaterialDefectsListSearchBtnCount(vo);
	}
	
	// 재고 등록 여부 업데이트
	// StockService 참고
	
	// 반품 등록 여부 업데이트
	@Override
	public void registerDefectY(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		qdao.updateRegisterDefect(vo);
		
	}



	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
