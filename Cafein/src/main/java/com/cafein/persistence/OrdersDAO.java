package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.OrdersVO;

public interface OrdersDAO {

	// 발주 목록
	public List<OrdersVO> getOrdersList() throws Exception;
	
}
