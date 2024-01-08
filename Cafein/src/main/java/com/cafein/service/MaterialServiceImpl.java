package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.OrdersVO;
import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;
import com.cafein.persistence.MaterialDAO;

@Service
public class MaterialServiceImpl implements MaterialService {

	private static final Logger logger = LoggerFactory.getLogger(MaterialServiceImpl.class);

	@Inject
	private MaterialDAO materdao;
	
	// 발주 목록 (페이징)
	@Override
	public List<OrdersVO> ordersList(OrdersVO vo) throws Exception {
		logger.debug("Service - ordersList(OrdersVO vo)");
		return materdao.selectOrdersList(vo);
	}

	// 발주 목록 (모달)
	@Override
	public List<OrdersVO> ordersList() throws Exception {
		logger.debug("Service - ordersList()");
		return materdao.selectOrdersList();
	}	
	
	// 발주 목록 총 개수
	@Override
	public Integer ordersCount(OrdersVO vo) throws Exception {
		logger.debug("Service - ordersCount(OrdersVO vo)");
		return materdao.selectOrdersCount(vo);
	}

	// 발주 등록
	@Override
	public void orderRegist(OrdersVO vo) throws Exception {
		logger.debug("Service - orderRegist(OrdersVO vo)");
		materdao.insertOrder(vo);
	}

	// 발주코드 개수 계산 (중복코드 생성 방지)
	@Override
	public Integer orderscodeCount(String datePart) throws Exception {
		logger.debug("Service - orderscodeCount(String datePart)");
		return materdao.selectOrderscodeCount(datePart);
	}

	// 발주 수정
	@Override
	public int orderModify(OrdersVO vo) throws Exception {
		logger.debug("Service - orderModify(OrdersVO vo)");
		return materdao.updateOrder(vo);
	}
	
	// 발주 삭제
	@Override
	public void orderDelete(OrdersVO vo) throws Exception {
		logger.debug("Service - orderDelete(OrdersVO vo)");
		materdao.deleteOrder(vo);
	}
	
	// 발주 목록 (엑셀 파일 다운로드)
	@Override
	public List<OrdersVO> orderListExcel(OrdersVO vo) throws Exception {
		logger.debug("Service - orderListExcel(OrdersVO vo)");
		return materdao.selectOrderListExcel(vo);
	}	

	// 입고 목록 (페이징)
	@Override
	public List<ReceiveVO> receiveList(ReceiveVO vo) throws Exception {
		logger.debug("Service - receiveList(ReceiveVO vo)");
		return materdao.selectReceiveList(vo);
	}

	// 입고 목록 총 개수
	@Override
	public Integer receiveCount(ReceiveVO vo) throws Exception {
		logger.debug("Service - receiveCount(ReceiveVO vo)");
		return materdao.selectReceiveCount(vo);
	}

	// 창고 목록 (모달)
	@Override
	public List<ReceiveVO> storageList() throws Exception {
		logger.debug("Service - storageList()");
		return materdao.selectStorageList();
	}

	// 입고코드 개수 계산 (중복코드 생성 방지)
	@Override
	public Integer receivecodeCount(String datePart) throws Exception {
		logger.debug("Service - receivecodeCount(String datePart)");
		return materdao.selectReceivecodeCount(datePart);
	}

	// 입고 등록
	@Override
	public void receiveRegist(ReceiveVO vo) throws Exception {
		logger.debug("Service - receiveRegist(ReceiveVO vo)");
		materdao.insertReceive(vo);
	}

	// 입고 수정
	@Override
	public int receiveModify(ReceiveVO vo) throws Exception {
		logger.debug("Service - receiveModify(ReceiveVO vo)");
		return materdao.updateReceive(vo);
	}
	
	// 입고상태 완료 -> 품질관리로 입고수량 처리
	@Override
	public void qualityRegist(ReceiveVO vo) throws Exception {
		logger.debug("Service - qualityRegist(ReceiveVO vo)");
		materdao.insertQuality(vo);
	}	

	// 입고 삭제
	@Override
	public void receiveDelete(ReceiveVO vo) throws Exception {
		logger.debug("Service - receiveDelete(ReceiveVO vo)");
		materdao.deleteReceive(vo);
	}	

	// 입고 목록 (엑셀 파일 다운로드)
	@Override
	public List<ReceiveVO> receiveListExcel(ReceiveVO vo) throws Exception {
		logger.debug("Service - receiveListExcel(ReceiveVO vo)");
		return materdao.selectReceiveListExcel(vo);
	}	
	
	// 출고 목록 (페이징)
	@Override
	public List<ReleasesVO> releasesList(ReleasesVO vo) throws Exception {
		logger.debug("Service - releasesList(ReleasesVO vo)");
		return materdao.selectReleasesList(vo);
	}

	// 출고 목록 총 개수
	@Override
	public Integer releasesCount(ReleasesVO vo) throws Exception {
		logger.debug("Service - releaseCount(ReleasesVO vo)");
		return materdao.selectReleasesCount(vo);
	}

	// 출고코드 개수 계산 (중복코드 생성 방지)
	@Override
	public Integer releasecodeCount(String datePart) throws Exception {
		logger.debug("Service - releasecodeCount(String datePart)");
		return materdao.selectReleasecodeCount(datePart);
	}

	// 출고 목록 (엑셀 파일 다운로드)
	@Override
	public List<ReleasesVO> releaseListExcel(ReleasesVO vo) throws Exception {
		logger.debug("Service - releaseListExcel(ReleasesVO vo)");
		return materdao.selectReleaseListExcel(vo);
	}
	
}
