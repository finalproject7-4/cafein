package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.QualityVO;

@Repository
public class StockDAOImpl implements StockDAO {
	
	
	private static final Logger logger = LoggerFactory.getLogger(StockDAOImpl.class);
	
	private static final String NAMESPACE = "com.cafein.mapper.stockMapper";
	
	@Inject
	private SqlSession sqlSession;

	// 재고 목록 조회 검색 버튼 (생산 [포장] + 반품)
	@Override
	public List<QualityVO> selectStockList(QualityVO vo) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectStockList", vo);
	}
	
	// 재고 목록 조회 검색 버튼 개수 조회 (생산 [포장] + 반품)
	@Override
	public Integer selectStockListCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectStockListCount", vo);
	}
	
	// 재고 목록 조회 검색 버튼 (자재)
	@Override
	public List<QualityVO> selectMaterialStockList(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectMaterialStockList", vo);
	}
	
	// 재고 목록 조회 검색 버튼 개수 조회 (자재)
	@Override
	public Integer selectMatrialStockListCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectMaterialStockListCount", vo);
	}

	// roastedbean - LOT번호 조회
	@Override
	public String selectRoastedBeanLotNum(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectRoastedBeanLotNum", vo);
	}
	
	// receive - LOT번호 조회
	@Override
	public String selectReceiveLotNum(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectReceiveLotNum", vo);
	}
	
	// 재고 입력
	@Override
	public int insertStockList(QualityVO vo) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.insert(NAMESPACE + ".insertStock", vo);
	}

	// 재고 등록 중복 확인 (생산 [포장] + 반품)
	@Override
	public Integer selectDuplicateStock(int qualityid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectDupilcateStock", qualityid);
	}

	// 재고량 변경 (생산 [포장] + 반품)
	@Override
	public int updateStockQuantity(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(NAMESPACE + ".updateStockQuantity", vo);
	}

	// 창고 목록 조회 (생산 [포장] + 반품)
	@Override
	public List<QualityVO> selectStorageList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectStorageList");
	}
	
	// 창고 목록 조회 (원자재)
	@Override
	public List<QualityVO> selectRawMaterialStorageList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectRawMaterialStorageList");
	}

	// 창고 목록 조회 (부자재)
	@Override
	public List<QualityVO> selectSubMaterialStorageList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectSubMaterialStorageList");
	}

	// 창고 변경 (생산 [포장] + 반품)
	@Override
	public int updateStockStorage(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(NAMESPACE + ".updateStockStorage", vo);
	}

	// 재고 등록 여부 업데이트
	@Override
	public void updateRegisterStock(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(NAMESPACE + ".updateRegisterStock", vo);
		
	}
	
	// 재고 토스트 데이터 (생산 [포장] + 반품)
	@Override
	public QualityVO selectProductStockToast() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".productStockToast");
	}
	
	// 재고 토스트 데이터 (자재)
	@Override
	public QualityVO selectMaterialStockToast() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".materialStockToast");
	}

	// 재고 엑셀용 출력 목록 조회 (생산 [포장] + 반품)
	@Override
	public List<QualityVO> selectStockListExcel(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectStockListExcel", vo);
	}

	// 재고 엑셀용 출력 목록 조회 (자재)
	@Override
	public List<QualityVO> selectMaterialStockListExcel(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectMaterialStockListExcel", vo);
	}
	
	// roastedBean 테이블 조회
	@Override
	public QualityVO selectRoastedBean(String lotnumber) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectRoastedBean", lotnumber);
	}

	// roastedBean - lotnumber 테이블 조회
	@Override
	public List<QualityVO> selectRoastedBeanLot(int produceid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectRoastedBeanLot", produceid);
	}
	
	// receive 테이블 조회
	@Override
	public QualityVO selectReceiveInfo(String receiveid) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".selectReceiveInfo", receiveid);
	}

	// produceid로 roastedBean LOT 조회 후 입력 (포장)
	@Override
	public void insertNormalRoastedBeanLot(int produceid) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(NAMESPACE + ".insertNormalRoastedBeanLot", produceid);
	}

	// receiveid로 receive LOT 조회 후 입력 (자재)
	@Override
	public void insertNormalRoastedBeanLotMat(int receiveid) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(NAMESPACE + ".insertNormalRoastedBeanLotMat", receiveid);
	}
	
	// 정상 LOT 번호 조회
	@Override
	public List<QualityVO> selectNormalLot(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectNormalLot", vo);
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
