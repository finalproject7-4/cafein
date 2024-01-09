package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.OrdersVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;

public interface MaterialDAO {

	// 발주 목록 (페이징)
	public List<OrdersVO> selectOrdersList(OrdersVO vo) throws Exception;

	// 발주 목록 (모달)
	public List<OrdersVO> selectOrdersList() throws Exception;

	// 발주 목록 총 개수
	public Integer selectOrdersCount(OrdersVO vo) throws Exception;

	// 발주 등록
	public void insertOrder(OrdersVO vo) throws Exception;

	// 발주코드 개수 계산 (중복코드 생성 방지)
	public Integer selectOrderscodeCount(String datePart) throws Exception;

	// 발주 수정
	public int updateOrder(OrdersVO vo) throws Exception;
	
	// 발주 삭제
	public void deleteOrder(OrdersVO vo) throws Exception;	
	
	// 발주 목록 (엑셀 파일 다운로드)
	public List<OrdersVO> selectOrderListExcel(OrdersVO vo) throws Exception;

	// 입고 목록 (페이징)
	public List<ReceiveVO> selectReceiveList(ReceiveVO vo) throws Exception;

	// 입고 목록 총 개수
	public Integer selectReceiveCount(ReceiveVO vo) throws Exception;

	// 창고 목록 (모달)
	public List<ReceiveVO> selectStorageList() throws Exception;

	// 입고코드 개수 계산 (중복코드 생성 방지)
	public Integer selectReceivecodeCount(String datePart) throws Exception;

	// 입고 등록
	public void insertReceive(ReceiveVO vo) throws Exception;

	// 입고 수정
	public int updateReceive(ReceiveVO vo) throws Exception;

	// 입고 완료 -> 품질관리로 이동
	public void insertQuality(ReceiveVO vo) throws Exception;
	
	// 입고 삭제
	public void deleteReceive(ReceiveVO vo) throws Exception;

	// 입고 목록 목록 (엑셀 파일 다운로드)
	public List<ReceiveVO> selectReceiveListExcel(ReceiveVO vo) throws Exception;

	// 출고 목록 (페이징)
	public List<ReleasesVO> selectReleasesList(ReleasesVO vo) throws Exception;

	// 출고 목록 총 개수
	public Integer selectReleasesCount(ReleasesVO vo) throws Exception;

	// 출고코드 개수 계산 (중복코드 생성 방지)
	public Integer selectReleasecodeCount(String datePart) throws Exception;

	// 출고 목록 (엑셀 파일 다운로드)
	public List<ReleasesVO> selectReleaseListExcel(ReleasesVO vo) throws Exception;

	// 재고 목록 (모달)
	public List<ReleasesVO> selectStockList() throws Exception;

	// 출고 수정
	public int updateRelease(ReleasesVO vo) throws Exception;

	// 출고상태 완료 -> 재고관리 출고 데이터 등록
	public void updateStockQuantity(ReleasesVO v) throws Exception;

}
