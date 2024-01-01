package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ItemVO;

public interface ItemDAO {

	// 품목 목록
	public List<ItemVO> getItemList() throws Exception;	
	
	// 품목 목록 (페이징)
	public List<ItemVO> getItemList(ItemVO vo) throws Exception;
	
	// 품목 목록 총 개수 계산
	public Integer getItemCount(ItemVO vo) throws Exception;
	
	// 품목 유형에 따른 총 개수 계산
	public int getItemTypeCount(ItemVO vo) throws Exception;
	
	// 품목 등록
	public void insertItem(ItemVO vo) throws Exception;

	// 품목 수정
	public int updateItem(ItemVO vo) throws Exception;
	
}
