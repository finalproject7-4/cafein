package com.cafein.service;

import java.util.List;
import java.util.Map;

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
	public List<ItemVO> itemList() throws Exception {
		logger.debug("Service - itemList()");
		return idao.getItemList();
	}

	@Override
	public List<ItemVO> searchItemList(Map map) throws Exception {
		logger.debug("Service - searchItemList(Map map)");
		return idao.searchItemList(map);
	}

	@Override
	public void itemRegist(ItemVO vo) throws Exception {
		logger.debug("Service - itemRegist(ItemVO vo)");
		idao.insertItem(vo);
	}

	@Override
	public int itemCount(ItemVO vo) throws Exception {
		logger.debug("Service - itemCount(ItemVO vo)");
		return idao.getItemCount(vo);
	}

}
