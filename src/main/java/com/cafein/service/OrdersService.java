package com.cafein.service;

import java.util.List;

import com.cafein.domain.OrdersVO;

public interface OrdersService {
	
	// 발주 목록
	public List<OrdersVO> ordersList() throws Exception;
	
}
