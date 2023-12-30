package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.OrdersVO;
import com.cafein.persistence.OrdersDAO;

@Service
public class OrdersServiceImpl implements OrdersService {

	private static final Logger logger = LoggerFactory.getLogger(OrdersServiceImpl.class);

	@Inject
	private OrdersDAO odao;
	
	@Override
	public List<OrdersVO> ordersList(OrdersVO vo) throws Exception {
		logger.debug("Service - ordersList(OrdersVO vo)");
		return odao.getOrdersList(vo);
	}

	@Override
	public Integer ordersCount(OrdersVO vo) throws Exception {
		logger.debug("Service - ordersCount(OrdersVO vo)");
		return odao.gerOrdersCount(vo);
	}

	@Override
	public void orderRegist(OrdersVO vo) throws Exception {
		logger.debug("Service - orderRegist(OrdersVO vo)");
		odao.insertOrder(vo);
	}

}
