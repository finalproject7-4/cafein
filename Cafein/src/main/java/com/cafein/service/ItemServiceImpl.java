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
	
	// 품목 목록
	@Override
	public List<ItemVO> itemList() throws Exception {
		logger.debug("Service - itemList()");
		return idao.selectItemList();
	}	
	
	// 품목 목록 (페이징)
	@Override
	public List<ItemVO> itemList(ItemVO vo) throws Exception {
		logger.debug("Service - itemList(ItemVO vo)");
		return idao.selectItemList(vo);
	}

	// 품목 목록 총 개수
	@Override
	public Integer itemCount(ItemVO vo) throws Exception {
		logger.debug("Service - itemTotalCount(ItemVO vo)");
		return idao.selectItemCount(vo);
	}
	
	// 품목 유형에 따른 총 개수	
	@Override
	public int itemtypeCount(ItemVO vo) throws Exception {
		logger.debug("Service - itemtypeCount(ItemVO vo)");
		return idao.selectItemTypeCount(vo);
	}

	// 품목 등록
	@Override
	public void itemRegist(ItemVO vo) throws Exception {
		logger.debug("Service - itemRegist(ItemVO vo)");
		idao.insertItem(vo);
	}

	// 품목 수정
	@Override
	public int itemModify(ItemVO vo) throws Exception {
		logger.debug("Service - itemModify(ItemVO vo)");
		return idao.updateItem(vo);
	}

	// 품목 삭제 (비활성화)
	@Override
	public void itemDelete(ItemVO vo) throws Exception {
		logger.debug("Service - itemDelete(int itemid)");
		idao.deleteItem(vo);
	}

	// 품목 목록 (엑셀 파일 다운로드)
	@Override
	public List<ItemVO> itemListExcel(ItemVO vo) throws Exception {
		logger.debug("Serviece - itemListExcel(ItemVO vo)");
		return idao.selectItemListExcel(vo);
	}

}
