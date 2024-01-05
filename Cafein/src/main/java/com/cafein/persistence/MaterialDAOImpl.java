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
	
	@Override
	public List<OrdersVO> getOrdersList(OrdersVO vo) throws Exception {
		logger.debug("DAO - getOrdersList(OrdersVO vo)");
		return sqlSession.selectList(NAMESPACE + ".ordersList", vo);
	}
	
	@Override
	public List<OrdersVO> getOrdersList() throws Exception {
		logger.debug("DAO - getOrdersList()");
		return sqlSession.selectList(NAMESPACE + ".getOrdersList");
	}	

	@Override
	public Integer gerOrdersCount(OrdersVO vo) throws Exception {
		logger.debug("DAO - gerOrdersCount(OrdersVO vo)");
		return sqlSession.selectOne(NAMESPACE + ".getOrdersCount", vo);
	}

	@Override
	public void insertOrder(OrdersVO vo) throws Exception {
		logger.debug("DAO - insertOrder(OrdersVO vo)");
		sqlSession.insert(NAMESPACE + ".insertOrder", vo);
	}

	@Override
	public Integer getOrderscodeCount(String datePart) throws Exception {
		logger.debug("DAO - getOrderscodeCount(String datePart)");
		return sqlSession.selectOne(NAMESPACE + ".getOrderscodeCount", datePart);
	}

	@Override
	public int updateOrder(OrdersVO vo) throws Exception {
		logger.debug("DAO - updateOrder(OrdersVO vo)");
		return sqlSession.update(NAMESPACE + ".updateOrder", vo);
	}
	
	@Override
	public void deleteOrder(OrdersVO vo) throws Exception {
		logger.debug("DAO - deleteOrder(OrdersVO vo)");
		sqlSession.delete(NAMESPACE + ".deleteOrder", vo);
	}	

	@Override
	public List<ReceiveVO> getReceiveList(ReceiveVO vo) throws Exception {
		logger.debug("DAO - getReceiveList(ReceiveVO vo)");
		return sqlSession.selectList(NAMESPACE + ".getReceiveList", vo);
	}

	@Override
	public Integer getReceiveCount(ReceiveVO vo) throws Exception {
		logger.debug("DAO - getReceiveCount(ReceiveVO vo)");
		return sqlSession.selectOne(NAMESPACE + ".getReceiveCount", vo);
	}

	@Override
	public List<ReceiveVO> getStorageList() throws Exception {
		logger.debug("DAO - getStorageList()");
		return sqlSession.selectList(NAMESPACE + ".getStorageList");
	}

	@Override
	public Integer getReceivecodeCount(String datePart) throws Exception {
		logger.debug("DAO - getReceivecodeCount(String datePart)");
		return sqlSession.selectOne(NAMESPACE + ".getReceivecodeCount", datePart);
	}

	@Override
	public void insertReceive(ReceiveVO vo) throws Exception {
		logger.debug("DAO - insertReceive(ReceiveVO vo)");
		sqlSession.insert(NAMESPACE + ".insertReceive", vo);
	}

	@Override
	public int updateReceive(ReceiveVO vo) throws Exception {
		logger.debug("DAO - updateReceive(ReceiveVO vo)");
		return sqlSession.update(NAMESPACE + ".updateReceive", vo);
	}
	
	@Override
	public void deleteReceive(ReceiveVO vo) throws Exception {
		logger.debug("DAO - deleteReceive(ReceiveVO vo)");
		sqlSession.delete(NAMESPACE + ".deleteReceive", vo);
	}	

	@Override
	public List<ReleasesVO> getReleasesList(ReleasesVO vo) throws Exception {
		logger.debug("DAO - getReleasesList(ReleasesVO vo");
		return sqlSession.selectList(NAMESPACE + ".getReleasesList", vo);
	}

	@Override
	public Integer getReleasesCount(ReleasesVO vo) throws Exception {
		logger.debug("DAO - getReleasesCount(ReleasesVO vo)");
		return sqlSession.selectOne(NAMESPACE + ".getReleasesCount", vo);
	}

	@Override
	public void insertQuality(ReceiveVO vo) throws Exception {
		logger.debug("DAO - insertQuality(ReceiveVO vo)");
		sqlSession.insert(NAMESPACE + ".insertQuality", vo);
	}
	
	
}
