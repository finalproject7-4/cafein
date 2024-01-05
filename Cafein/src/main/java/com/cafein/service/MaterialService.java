package com.cafein.service;

import java.util.List;

import com.cafein.domain.OrdersVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;

public interface MaterialService {
	
	// 발주 목록 (페이징)
	public List<OrdersVO> ordersList(OrdersVO vo) throws Exception;

	// 발주 목록 (모달)
	public List<OrdersVO> ordersList() throws Exception;
	
	// 발주 목록 총 개수
	public Integer ordersCount(OrdersVO vo) throws Exception;

	// 발주 등록
	public void orderRegist(OrdersVO vo) throws Exception;

	// 발주코드 개수 계산 (중복코드 생성 방지)
	public Integer orderscodeCount(String datePart) throws Exception;

	// 발주 수정
	public int orderModify(OrdersVO vo) throws Exception;

	// 발주 삭제
	public void orderDelete(OrdersVO vo) throws Exception;
	
	// 입고 목록 (페이징)
	public List<ReceiveVO> receiveList(ReceiveVO vo) throws Exception;

	// 입고 목록 총 개수
	public Integer receiveCount(ReceiveVO vo) throws Exception;

	// 창고 목록 (모달)
	public List<ReceiveVO> storageList() throws Exception;

	// 입고코드 개수 계산 (중복코드 생성 방지)
	public Integer receivecodeCount(String datePart) throws Exception;

	// 입고 등록
	public void receiveRegist(ReceiveVO vo) throws Exception;

	// 입고 완료 -> 품질관리로 이동
	public void moveQuality(ReceiveVO vo) throws Exception;

	// 입고 수정
	public int receiveModify(ReceiveVO vo) throws Exception;

	// 입고 삭제
	public void receiveDelete(ReceiveVO vo) throws Exception;
	
	// 출고 목록 (페이징)
	public List<ReleasesVO> releasesList(ReleasesVO vo) throws Exception;

	// 출고 목록 총 개수
	public Integer releasesCount(ReleasesVO vo) throws Exception;

	
}
