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
	
	@Override
	public List<OrdersVO> ordersList(OrdersVO vo) throws Exception {
		logger.debug("Service - ordersList(OrdersVO vo)");
		return materdao.getOrdersList(vo);
	}

	@Override
	public List<OrdersVO> ordersList() throws Exception {
		logger.debug("Service - ordersList()");
		return materdao.getOrdersList();
	}	
	
	@Override
	public Integer ordersCount(OrdersVO vo) throws Exception {
		logger.debug("Service - ordersCount(OrdersVO vo)");
		return materdao.gerOrdersCount(vo);
	}

	@Override
	public void orderRegist(OrdersVO vo) throws Exception {
		logger.debug("Service - orderRegist(OrdersVO vo)");
		materdao.insertOrder(vo);
	}

	@Override
	public Integer orderscodeCount(String datePart) throws Exception {
		logger.debug("Service - orderscodeCount(String datePart)");
		return materdao.getOrderscodeCount(datePart);
	}

	@Override
	public int orderModify(OrdersVO vo) throws Exception {
		logger.debug("Service - orderModify(OrdersVO vo)");
		return materdao.updateOrder(vo);
	}
	
	@Override
	public void orderDelete(OrdersVO vo) throws Exception {
		logger.debug("Service - orderDelete(OrdersVO vo)");
		materdao.deleteOrder(vo);
	}

	@Override
	public List<ReceiveVO> receiveList(ReceiveVO vo) throws Exception {
		logger.debug("Service - receiveList(ReceiveVO vo)");
		return materdao.getReceiveList(vo);
	}

	@Override
	public Integer receiveCount(ReceiveVO vo) throws Exception {
		logger.debug("Service - receiveCount(ReceiveVO vo)");
		return materdao.getReceiveCount(vo);
	}

	@Override
	public List<ReceiveVO> storageList() throws Exception {
		logger.debug("Service - storageList()");
		return materdao.getStorageList();
	}

	@Override
	public Integer receivecodeCount(String datePart) throws Exception {
		logger.debug("Service - receivecodeCount(String datePart)");
		return materdao.getReceivecodeCount(datePart);
	}

	@Override
	public void receiveRegist(ReceiveVO vo) throws Exception {
		logger.debug("Service - receiveRegist(ReceiveVO vo)");
		materdao.insertReceive(vo);
	}

	@Override
	public int receiveModify(ReceiveVO vo) throws Exception {
		logger.debug("Service - receiveModify(ReceiveVO vo)");
		return materdao.updateReceive(vo);
	}

	@Override
	public void receiveDelete(ReceiveVO vo) throws Exception {
		logger.debug("Service - receiveDelete(ReceiveVO vo)");
		materdao.deleteReceive(vo);
	}	
	
	@Override
	public List<ReleasesVO> releasesList(ReleasesVO vo) throws Exception {
		logger.debug("Service - releasesList(ReleasesVO vo)");
		return materdao.getReleasesList(vo);
	}

	@Override
	public Integer releasesCount(ReleasesVO vo) throws Exception {
		logger.debug("Service - releaseCount(ReleasesVO vo)");
		return materdao.getReleasesCount(vo);
	}

	
}
