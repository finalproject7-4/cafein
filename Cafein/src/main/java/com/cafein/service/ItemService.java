package com.cafein.service;

import java.util.List;
import java.util.Map;

import com.cafein.domain.ItemVO;

public interface ItemService {
	
	// 품목 목록
	public List<ItemVO> itemList() throws Exception;
	
	// 품목 검색
	public List<ItemVO> searchItemList(Map map) throws Exception;
	
	// 품목별 총 개수 계산
	public int itemCount(ItemVO vo) throws Exception;
	
	// 품목 등록
	public void itemRegist(ItemVO vo) throws Exception;
	
}
