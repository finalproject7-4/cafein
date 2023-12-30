package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.OrdersVO;

@Repository
public class OrdersDAOImpl implements OrdersDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(OrdersDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.cafein.mapper.OrdersMapper";
	
	@Override
	public List<OrdersVO> getOrdersList(OrdersVO vo) throws Exception {
		logger.debug("DAO - getOrdersList(OrdersVO vo)");
		return sqlSession.selectList(NAMESPACE + ".ordersListPage", vo);
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

}
