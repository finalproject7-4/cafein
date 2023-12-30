package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.OrdersVO;

public interface OrdersDAO {

	// 발주 목록
	public List<OrdersVO> getOrdersList(OrdersVO vo) throws Exception;

	// 발주 목록 총 개수
	public Integer gerOrdersCount(OrdersVO vo) throws Exception;

	// 발주 등록
	public void insertOrder(OrdersVO vo) throws Exception;

	
}
