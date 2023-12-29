package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.ItemVO;
import com.cafein.persistence.ItemDAO;

@Service
public class ItemServiceImpl implements ItemService {

	private static final Logger logger = LoggerFactory.getLogger(ItemServiceImpl.class);

	@Inject
	private ItemDAO idao;
	
	@Override
	public List<ItemVO> itemList(ItemVO vo) throws Exception {
		logger.debug("Service - itemList(ItemVO vo)");
		return idao.getItemList(vo);
	}

	@Override
	public Integer itemCount(ItemVO vo) throws Exception {
		logger.debug("Service - itemTotalCount(ItemVO vo)");
		return idao.getItemCount(vo);
	}

	@Override
	public void itemRegist(ItemVO vo) throws Exception {
		logger.debug("Service - itemRegist(ItemVO vo)");
		idao.insertItem(vo);
	}

	@Override
	public int itemtypeCount(ItemVO vo) throws Exception {
		logger.debug("Service - itemtypeCount(ItemVO vo)");
		return idao.getItemTypeCount(vo);
	}

}
