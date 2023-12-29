package com.cafein.service;

import java.util.List;

import com.cafein.domain.BomVO;
import com.cafein.domain.Criteria;
import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;

public interface ProductionService {
	
	// 생산지시목록 조회
	public List<ProduceVO> getProduceList(ProduceVO vo) throws Exception;

	
	// 생산지시 글 개수 확인
	public int getProdueCount() throws Exception;
	
	// BOM 목록 조회
	public List<BomVO> getBomList() throws Exception;
	
	// 생산지시 등록
	public void regProduce(ProduceVO vo) throws Exception;
	
	// BOM 등록
	public void regBom(BomVO vo) throws Exception;
	
	// BOM 등록되지 않은 품목 조회
		public List<ItemVO> getNewItem() throws Exception;
	
	// 품목 아이템 목록 조회
	public List<ItemVO> getItemList() throws Exception;
	

}
