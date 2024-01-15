package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ItemVO;

public interface ItemDAO {

	// 품목 목록
	public List<ItemVO> selectItemList() throws Exception;	
	
	// 품목 목록 (페이징)
	public List<ItemVO> selectItemList(ItemVO vo) throws Exception;
	
	// 품목 목록 총 개수 계산
	public Integer selectItemCount(ItemVO vo) throws Exception;
	
	// 품목 유형에 따른 총 개수 계산
	public int selectItemTypeCount(ItemVO vo) throws Exception;
	
	// 품목 등록
	public void insertItem(ItemVO vo) throws Exception;

	// 품목 수정
	public int updateItem(ItemVO vo) throws Exception;

	// 품목 삭제 (비활성화)
	public void deleteItem(ItemVO vo) throws Exception;

	// 품목 목록 (엑셀 파일 다운로드)
	public List<ItemVO> selectItemListExcel(ItemVO vo) throws Exception;
	
}
