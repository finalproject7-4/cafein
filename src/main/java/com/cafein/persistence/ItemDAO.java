package com.cafein.persistence;

import java.util.List;
import java.util.Map;

import com.cafein.domain.ItemVO;

public interface ItemDAO {

	// 품목 목록
	public List<ItemVO> getItemList() throws Exception;
	
	// 품목 검색
	public List<ItemVO> searchItemList(Map map) throws Exception;
	
}
