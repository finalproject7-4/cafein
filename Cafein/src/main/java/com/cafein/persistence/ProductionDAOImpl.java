package com.cafein.persistence;


import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.BomVO;
import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.QualityVO;
import com.cafein.domain.ReleasesVO;
import com.cafein.domain.RoastedbeanVO;

@Repository

public class ProductionDAOImpl implements ProductionDAO {
	
	
	private static final Logger logger = LoggerFactory.getLogger(ProductionDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.cafein.mapper.ProductionMapper";

	
	// AJAX 생산지시 목록조회 메서드
	@Override
	public List<ProduceVO> getProduceListAJAX(ProduceVO vo) throws Exception{
		logger.debug("DAO - 생산지시 목록 조회 getProduceList() 실행!");
		logger.debug("produceList : "+ vo.getStartDate());
		logger.debug("DAO - vo end : "+ vo.getEndDate());
		
		return sqlSession.selectList(NAMESPACE+".getProduceListAJAX", vo);
	}
	
	
	// 엑셀 출력용 생산지시 목록 조회
	@Override
	public List<ProduceVO> getExcelDownProduceList(ProduceVO vo) throws Exception {
		logger.debug("DAO - 엑셀 출력용 리스트 출력");
		return sqlSession.selectList(NAMESPACE+".getExcelDownProduceList", vo);
	}


	// 생산지시 글 개수 확인
	@Override
	public Integer AJAXcountProduceList(ProduceVO vo) throws Exception {
		logger.debug("DAO - 작업지시 수량 몇개? ");
		return sqlSession.selectOne(NAMESPACE+".AJAXcountProduceList", vo);
	}

	// BOM 목록 조회 메서드
	@Override
	public List<BomVO> getBomList() throws Exception {
		logger.debug("DAO - 생산지시 목록 조회 getBomList() 실행!");
		return sqlSession.selectList(NAMESPACE+".getBomList");
	}
	
	// 생산지시 등록
	@Override
	public void insertProducePlan(ProduceVO vo) throws Exception {
		logger.debug("DAO - 생산지시 등록 regProduce() 실행!");
		
		sqlSession.insert(NAMESPACE+".insertProducePlan", vo);
		
	}
	
	// BOM 등록
	@Override
	public void insertBom(BomVO vo) throws Exception {
		logger.debug("DAO -  BOM 등록 insertBom() 실행!");
		
		sqlSession.insert(NAMESPACE+".insertBom", vo);
		
	}
	
	
	// BOM 등록되지 않은 품목 조회
	@Override
	public List<ItemVO> getNewItem() throws Exception {
		logger.debug("DAO -  BOM 등록안된 품목 getNewItem() 실행!");
		
		return sqlSession.selectList(NAMESPACE+".getNewItem");
		
	}


	// 품목 리스트 조회
	@Override
	public List<ItemVO> getItemList() throws Exception {
		logger.debug("DAO - 품목 리스트 조회 getItemList() 실행!");
		
		return sqlSession.selectList(NAMESPACE+".getItemList");
	}

	// 생산 상태 업데이트
	@Override
	public void updateProduceState(ProduceVO vo) throws Exception {
		logger.debug("DAO - 생산 상태 변경 updateProduceState() 실행!");
		
		sqlSession.update(NAMESPACE+".updateProduceState", vo);
		
	}
	
	
	// 생산 공정과정 업데이트(블렌딩 -> 로스팅)
	@Override
	public void updateProduceProcessRoasting(ProduceVO vo) throws Exception {
		logger.debug("DAO - 생산 공정 과정 로스팅! 변경 updateProduceProcess() 실행!");
		
		sqlSession.update(NAMESPACE+".updateProcessRoasting", vo);
		
	}


	// 생산 공정과정 업데이트 (로스팅 -> 포장)
	@Override
	public void updateProduceProcess(ProduceVO vo) throws Exception {
		logger.debug("DAO - 생산 공정 과정 포장! 변경 updateProduceProcess() 실행!");
		
		sqlSession.update(NAMESPACE+".updateProcess", vo);
		
	}


	// 포장공정 완료된 제품 roastedbean 목록에 추가
	@Override
	public void insertRoastedbean(RoastedbeanVO vo) throws Exception {
		logger.debug("DAO - 로스팅제품 업데이트 실행!");
		
		sqlSession.update(NAMESPACE+".insertRoastedbean", vo);
	}
	
	
	// 대기중인 블렌딩 공정 작업지시 삭제
	@Override
	public void deleteProducePlan(ProduceVO vo) throws Exception {
		logger.debug("DAO - 블렌딩 작업 삭제!");
		
		sqlSession.delete(NAMESPACE+".deleteProducePlan", vo);
		
	}


	// 로스팅 온도값 조회
	@Override
	public int getRoastingTemper(ProduceVO vo) throws Exception {
		logger.debug("DAO - 로스팅제품 온도 체크 실행!");
		
		return sqlSession.selectOne(NAMESPACE+".getRoastingTemper", vo);
	}


	// 로스팅 제품 조회
	@Override
	public List<RoastedbeanVO> getRoastedList(RoastedbeanVO vo) throws Exception {
		logger.debug("DAO - 로스팅 완료 제품 목록 조회!");
		
		return sqlSession.selectList(NAMESPACE+".getRoastedbeanList", vo);
	}


	// 로스팅 목록 글개수 조회
	@Override
	public Integer countRoastedbean(RoastedbeanVO vo) throws Exception {
		logger.debug("DAO - 로스팅 리스트 개수 조회!");
		
		return sqlSession.selectOne(NAMESPACE+".countRoastedbean", vo);
	}


	// 블렌딩 작업 생산 들어가면 품질 리스트 데이터 삽입
	@Override
	public void regQualityList(QualityVO vo) throws Exception {
		logger.debug("DAO - 블렌딩 생산 시작됐으니 품질 리스트도 업데이트!");
		
		sqlSession.insert(NAMESPACE+".regQualityList", vo);
		
	}


	// 블렌딩 -> 로스팅으로 작업 전환시 생성될 신규 품질 데이터
	@Override
	public void regRoastingQualityList(QualityVO vo) throws Exception {
		logger.debug("DAO - 블렌딩 완료! 로스팅 작업 시작해서 신규 품질 데이터 삽입!");
		
		sqlSession.insert(NAMESPACE+".regRoastingQualityList", vo);
	}
	
	// 로스팅 -> 포장으로 작업 전환시 생성될 신규 품질 데이터
	@Override
	public void regPackingQualityList(QualityVO vo) throws Exception {
		logger.debug("DAO - 로스팅 완료! 포장 작업 시작해서 신규 품질 데이터 삽입!");
		
		sqlSession.insert(NAMESPACE+".regPackingQualityList", vo);
	}


	// 생산지시 등록과 동시에 출고 등록
	@Override
	public void insertReleasesList(ReleasesVO vo) throws Exception {
		logger.debug("DAO - 생산등록해서 출고등록도 한다!");
		
		sqlSession.insert(NAMESPACE+".insertReleasesList",vo);
		
	}


	// 생산코드 생성 메서드
	@Override
	public Integer getProducecodeCount(String datePart) throws Exception {
		logger.debug("DAO - 생산 코드 생성!");
		return sqlSession.insert(NAMESPACE+".getProducecodeCount", datePart);
	}


	// 출고지시리스트 대기 -> 완료로 변경
	@Override
	public void updateCompletRelease(ProduceVO vo) throws Exception {
		logger.debug("DAO - 출고상태 완료로 변경!");
		
		sqlSession.update(NAMESPACE+".updateCompletRelease", vo);
		
	}


	// 재고리스트 업데이트 (사용 수량 차감)
	@Override
	public void updateStockList(ProduceVO vo) throws Exception {
		logger.debug("DAO - 재고리스트 업데이트");
		
		sqlSession.update(NAMESPACE + ".updateStockList", vo);
	}
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	


	
	


	
	

	

	
}
