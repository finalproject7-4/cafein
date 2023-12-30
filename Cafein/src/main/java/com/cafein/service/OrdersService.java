package com.cafein.service;

import java.util.List;

import com.cafein.domain.OrdersVO;

public interface OrdersService {
	
	// 발주 목록 (페이징)
	public List<OrdersVO> ordersList(OrdersVO vo) throws Exception;

	// 발주 목록 총 개수
	public Integer ordersCount(OrdersVO vo) throws Exception;

	// 발주 등록
	public void orderRegist(OrdersVO vo) throws Exception;
	
}
