package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.OrdersVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;

public interface MaterialDAO {

	// 발주 목록 (페이징)
	public List<OrdersVO> getOrdersList(OrdersVO vo) throws Exception;

	// 발주 목록 (모달)
	public List<OrdersVO> getOrdersList() throws Exception;

	// 발주 목록 총 개수
	public Integer gerOrdersCount(OrdersVO vo) throws Exception;

	// 발주 등록
	public void insertOrder(OrdersVO vo) throws Exception;

	// 발주코드 개수 계산 (중복코드 생성 방지)
	public Integer getOrderscodeCount(String datePart) throws Exception;

	// 발주 수정
	public int updateOrder(OrdersVO vo) throws Exception;
	
	// 발주 삭제
	public void deleteOrder(OrdersVO vo) throws Exception;	

	// 입고 목록 (페이징)
	public List<ReceiveVO> getReceiveList(ReceiveVO vo) throws Exception;

	// 입고 목록 총 개수
	public Integer getReceiveCount(ReceiveVO vo) throws Exception;

	// 창고 목록 (모달)
	public List<ReceiveVO> getStorageList() throws Exception;

	// 입고코드 개수 계산 (중복코드 생성 방지)
	public Integer getReceivecodeCount(String datePart) throws Exception;

	// 입고 등록
	public void insertReceive(ReceiveVO vo) throws Exception;

	// 입고 완료 -> 품질관리로 이동
	public void insertQuality(ReceiveVO vo) throws Exception;

	// 입고 수정
	public int updateReceive(ReceiveVO vo) throws Exception;

	// 입고 삭제
	public void deleteReceive(ReceiveVO vo) throws Exception;

	// 출고 목록 (페이징)
	public List<ReleasesVO> getReleasesList(ReleasesVO vo) throws Exception;

	// 출고 목록 총 개수
	public Integer getReleasesCount(ReleasesVO vo) throws Exception;



}
