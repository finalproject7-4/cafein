package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.OrdersVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;

@Repository
public class MaterialDAOImpl implements MaterialDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(MaterialDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.cafein.mapper.MaterialMapper";
	
	// 발주 목록 (페이징)
	@Override
	public List<OrdersVO> selectOrdersList(OrdersVO vo) throws Exception {
		logger.debug("DAO - selectOrdersList(OrdersVO vo)");
		return sqlSession.selectList(NAMESPACE + ".selectOrdersList", vo);
	}
	
	// 발주 목록 (모달)
	@Override
	public List<OrdersVO> selectOrdersList() throws Exception {
		logger.debug("DAO - selectOrdersList()");
		return sqlSession.selectList(NAMESPACE + ".selectOrdersListModal");
	}	

	// 발주 목록 총 개수
	@Override
	public Integer selectOrdersCount(OrdersVO vo) throws Exception {
		logger.debug("DAO - selectOrdersCount(OrdersVO vo)");
		return sqlSession.selectOne(NAMESPACE + ".selectOrdersCount", vo);
	}

	// 발주 등록
	@Override
	public void insertOrder(OrdersVO vo) throws Exception {
		logger.debug("DAO - insertOrder(OrdersVO vo)");
		sqlSession.insert(NAMESPACE + ".insertOrder", vo);
	}

	// 발주코드 개수 계산 (중복코드 생성 방지)
	@Override
	public Integer selectOrderscodeCount(String datePart) throws Exception {
		logger.debug("DAO - selectOrderscodeCount(String datePart)");
		return sqlSession.selectOne(NAMESPACE + ".selectOrderscodeCount", datePart);
	}

	// 발주 수정
	@Override
	public int updateOrder(OrdersVO vo) throws Exception {
		logger.debug("DAO - updateOrder(OrdersVO vo)");
		return sqlSession.update(NAMESPACE + ".updateOrder", vo);
	}
	
	// 발주 삭제
	@Override
	public void deleteOrder(OrdersVO vo) throws Exception {
		logger.debug("DAO - deleteOrder(OrdersVO vo)");
		sqlSession.delete(NAMESPACE + ".deleteOrder", vo);
	}
	
	// 발주 목록 (엑셀 파일 다운로드)
	@Override
	public List<OrdersVO> selectOrderListExcel(OrdersVO vo) throws Exception {
		logger.debug("DAO - selectOrderListExcel(OrdersVO vo)");
		return sqlSession.selectList(NAMESPACE + ".selectOrderListExcel", vo);
	}	

	// 입고 목록 (페이징)
	@Override
	public List<ReceiveVO> selectReceiveList(ReceiveVO vo) throws Exception {
		logger.debug("DAO - selectReceiveList(ReceiveVO vo)");
		return sqlSession.selectList(NAMESPACE + ".selectReceiveList", vo);
	}

	// 입고 목록 총 개수
	@Override
	public Integer selectReceiveCount(ReceiveVO vo) throws Exception {
		logger.debug("DAO - selectReceiveCount(ReceiveVO vo)");
		return sqlSession.selectOne(NAMESPACE + ".selectReceiveCount", vo);
	}

	// 창고 목록 (모달)
	@Override
	public List<ReceiveVO> selectStorageList() throws Exception {
		logger.debug("DAO - selectStorageList()");
		return sqlSession.selectList(NAMESPACE + ".selectStorageList");
	}

	// 입고코드 개수 계산 (중복코드 생성 방지)
	@Override
	public Integer selectReceivecodeCount(String datePart) throws Exception {
		logger.debug("DAO - selectReceivecodeCount(String datePart)");
		return sqlSession.selectOne(NAMESPACE + ".selectReceivecodeCount", datePart);
	}

	// 입고 등록
	@Override
	public void insertReceive(ReceiveVO vo) throws Exception {
		logger.debug("DAO - insertReceive(ReceiveVO vo)");
		sqlSession.insert(NAMESPACE + ".insertReceive", vo);
	}

	// 입고 수정
	@Override
	public int updateReceive(ReceiveVO vo) throws Exception {
		logger.debug("DAO - updateReceive(ReceiveVO vo)");
		return sqlSession.update(NAMESPACE + ".updateReceive", vo);
	}

	// 입고상태 완료 -> 품질관리로 입고수량 처리
	@Override
	public void insertQuality(ReceiveVO vo) throws Exception {
		logger.debug("DAO - insertQuality(ReceiveVO vo)");
		sqlSession.insert(NAMESPACE + ".insertQuality", vo);
	}
	
	// 입고 삭제
	@Override
	public void deleteReceive(ReceiveVO vo) throws Exception {
		logger.debug("DAO - deleteReceive(ReceiveVO vo)");
		sqlSession.delete(NAMESPACE + ".deleteReceive", vo);
	}	

	// 입고 목록 (엑셀 파일 다운로드)
	@Override
	public List<ReceiveVO> selectReceiveListExcel(ReceiveVO vo) throws Exception {
		logger.debug("DAO - selectReceiveListExcel(ReceiveVO vo)");
		return sqlSession.selectList(NAMESPACE + ".selectReceiveListExcel", vo);
	}	
	
	// 출고 목록 (페이징)
	@Override
	public List<ReleasesVO> selectReleasesList(ReleasesVO vo) throws Exception {
		logger.debug("DAO - selectReleasesList(ReleasesVO vo");
		return sqlSession.selectList(NAMESPACE + ".selectReleasesList", vo);
	}

	// 출고 목록 총 개수
	@Override
	public Integer selectReleasesCount(ReleasesVO vo) throws Exception {
		logger.debug("DAO - selectReleasesCount(ReleasesVO vo)");
		return sqlSession.selectOne(NAMESPACE + ".selectReleasesCount", vo);
	}

	// 출고코드 개수 계산 (중복코드 생성 방지)
	@Override
	public Integer selectReleasecodeCount(String datePart) throws Exception {
		logger.debug("DAO - selectReleasecodeCount(String datePart)");
		return sqlSession.selectOne(NAMESPACE + ".selectReleasecodeCount", datePart);
	}

	// 출고 목록 (엑셀 파일 다운로드)
	@Override
	public List<ReleasesVO> selectReleaseListExcel(ReleasesVO vo) throws Exception {
		logger.debug("DAO - selectReleaseListExcel(ReleasesVO vo)");
		return sqlSession.selectList(NAMESPACE + ".selectReleaseListExcel", vo);
	}
	
}
