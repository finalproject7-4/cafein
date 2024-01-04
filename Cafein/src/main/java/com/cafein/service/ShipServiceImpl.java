package com.cafein.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.SalesVO;
import com.cafein.domain.ShipVO;
import com.cafein.domain.WorkVO;
import com.cafein.persistence.ShipDAO;

@Service
public class ShipServiceImpl implements ShipService {

	private static final Logger logger = LoggerFactory.getLogger(ShipServiceImpl.class);

	@Inject
	private ShipDAO shdao;
	
	// 출하 조회
	@Override
	public List<ShipVO> AllSHList() throws Exception{
		logger.debug("AllSHList()");
		return shdao.getSHList();
	}

	// 출하 등록
	@Override
	public void registSH(ShipVO svo) throws Exception {
		logger.debug("registSHList 메서드 호출");
		shdao.registSH(svo);
		
	}
	
	// 출하등록 - 작업지시코드
	@Override
	public List<WorkVO> registWC() throws Exception {
		logger.debug("S :registWC()");
		return shdao.registWC();
	}
	
	// 출하 등록 - 재고량
	@Override
	public List<WorkVO> registST() throws Exception {
		logger.debug("S :registST()");
		return shdao.registST();
	}
	
	// 출하 코드 생성
	@Override
	public int shCount(ShipVO svo) throws Exception {
		logger.debug("S : shCount(ShipVO svo)");
		return shdao.getSHCount(svo);
	}
	
	// 출하 검색
	@Override
	public List<ShipVO> searchSHList(Map<String, Object> searchParams) throws Exception {
		logger.debug("searchSHList()");
	    return shdao.searchSHList(searchParams);
	}
	
	
	

	// 작업 지시 조회
	@Override
	public List<WorkVO> AllWKList() throws Exception {
		logger.debug("AllWKList()");
		return shdao.getWKList();
	}
	
//	// 작업 지시 검색
//	@Override
//	public List<WorkVO> searchWKList(String keyword) throws Exception {
//		    logger.debug("searchWKList()");
//		    return shdao.searchWKList(keyword);
//		}


	// 작업 지시 등록
	@Override
	public void registWK(WorkVO wvo) throws Exception {
		logger.debug("registWKList 메서드 호출");
		shdao.registWK(wvo);
	}

	// 작업 지시 등록 - 수주코드
	@Override
	public List<WorkVO> registPC() throws Exception {
		logger.debug("S :registPC()");
		return shdao.registPC();
	}

	// 작업 지시 코드 생성
	@Override
	public int wkCount(WorkVO wvo) throws Exception {
		logger.debug("S : wkCount(WorkVO wvo)");
		return shdao.getWKCount(wvo);
	}
	
	// 작업 지시 수정
	@Override
	public int WKModify(WorkVO wvo) throws Exception {
		logger.debug("S : WKModify(int workid)");
		return shdao.updateWK(wvo);
	}

	// 실적 조회
	@Override
	public List<WorkVO> AllPFList() throws Exception {
		logger.debug("AllPFList()");
		return shdao.getPFList();
	}

	// 실적 등록
	@Override
	public void registPF(WorkVO wvo) throws Exception {
		logger.debug("registPFList 메서드 호출");
		shdao.registWK(wvo);
	}



}