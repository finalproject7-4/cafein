package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cafein.domain.QualityVO;
import com.cafein.persistence.StockDAO;

@Service
public class StockServiceImpl implements StockService {
	
	@Inject
	private StockDAO sdao;

	// 재고 목록 조회 검색 버튼 (생산 [포장] + 반품)
	@Override
	public List<QualityVO> stockList(QualityVO vo) throws Exception{
		// TODO Auto-generated method stub
		return sdao.selectStockList(vo);
	}
	
	// 재고 목록 조회 검색 버튼 개수 조회 (생산 [포장] + 반품)
	@Override
	public Integer stockListCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sdao.selectStockListCount(vo);
	}

	// 재고 목록 조회 검색 버튼 (자재)
	@Override
	public List<QualityVO> materialStockList(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sdao.selectMaterialStockList(vo);
	}
	
	// 재고 목록 조회 검색 버튼 개수 조회 (자재)
	@Override
	public Integer materialStockListCount(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sdao.selectMatrialStockListCount(vo);
	}
	
	// roastedbean - LOT번호 조회
	@Override
	public String roastedbeanLotNum(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sdao.selectRoastedBeanLotNum(vo);
	}
	
	// receive - LOT번호 조회
	@Override
	public String receiveLotNum(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sdao.selectReceiveLotNum(vo);
	}

	// 재고 입력 (생산 [포장] + 반품)
	@Override
	public int newStock(QualityVO vo) throws Exception{
		// TODO Auto-generated method stub
		return sdao.insertStockList(vo);
	}

	// 재고 등록 중복 확인 (생산 [포장] + 반품)
	@Override
	public Integer duplicateStock(int qualityid) throws Exception {
		// TODO Auto-generated method stub
		return sdao.selectDuplicateStock(qualityid);
	}

	// 재고량 변경 (생산 [포장] + 반품)
	@Override
	public int stockQuantity(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sdao.updateStockQuantity(vo);
	}
	
	// 창고 목록 조회 (생산 [포장] + 반품)
	@Override
	public List<QualityVO> storageList() throws Exception {
		// TODO Auto-generated method stub
		return sdao.selectStorageList();
	}
	
	// 창고 목록 조회 (원자재)
	@Override
	public List<QualityVO> rawmaterialStorageList() throws Exception {
		// TODO Auto-generated method stub
		return sdao.selectRawMaterialStorageList();
	}

	// 창고 목록 조회 (부자재)
	@Override
	public List<QualityVO> submaterialStorageList() throws Exception {
		// TODO Auto-generated method stub
		return sdao.selectSubMaterialStorageList();
	}

	// 창고 변경 (생산 [포장] + 반품)
	@Override
	public int stockStorage(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sdao.updateStockStorage(vo);
	}

	// 재고 등록 여부 업데이트
	@Override
	public void registerStockY(QualityVO vo) throws Exception {
		// TODO Auto-generated method stub
		sdao.updateRegisterStock(vo);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
