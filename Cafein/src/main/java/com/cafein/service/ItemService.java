package com.cafein.service;

import java.util.List;

import com.cafein.domain.ItemVO;

public interface ItemService {
	
	// 품목 목록
	public List<ItemVO> itemList() throws Exception;
	
	// 품목 목록 (페이징)
	public List<ItemVO> itemList(ItemVO vo) throws Exception;
	
	// 품목 목록 총 개수
	public Integer itemCount(ItemVO vo) throws Exception;
	
	// 품목 유형에 따른 총 개수
	public int itemtypeCount(ItemVO vo) throws Exception;
	
	// 품목 등록
	public void itemRegist(ItemVO vo) throws Exception;

	// 품목 수정
	public int itemModify(ItemVO vo) throws Exception;

	// 품목 삭제 (비활성화)
	public void itemDelete(ItemVO vo) throws Exception;
	
}
