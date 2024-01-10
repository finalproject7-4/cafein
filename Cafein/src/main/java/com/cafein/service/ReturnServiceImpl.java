package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.Criteria;
import com.cafein.domain.ItemVO;
import com.cafein.domain.ProduceVO;
import com.cafein.domain.ReturnVO;
import com.cafein.persistence.ReturnDAO;

@Service
public class ReturnServiceImpl implements ReturnService {

	
	private static final Logger logger = LoggerFactory.getLogger(ReturnServiceImpl.class);
	
	@Inject
	private ReturnDAO rdao;

	@Override
	public List<ReturnVO> searchReturns(Criteria cri) throws Exception {
		
		return rdao.searchReturns(cri);
	}

	@Override
	public List<ReturnVO> searchReturnsByCondition(ReturnVO rvo,Criteria cri) throws Exception {

		return rdao.searchReturnsByCondition(rvo,cri);
	}

	@Override
	public int returnCount(ReturnVO rvo) throws Exception {
		
		return rdao.getReturnCount(rvo);
	}

	@Override
	public void returnRegist(ReturnVO rvo) throws Exception {
		
		rdao.insertReturn(rvo);
	}

	@Override
	public List<ItemVO> itList() throws Exception {
		return rdao.itList();
	}
	
	@Override
	public int returnModify(ReturnVO rvo) throws Exception {
		
		return rdao.updateReturn(rvo);
	}

	@Override
	public void returnDelete(int rvo) throws Exception {
		
		rdao.deleteReturn(rvo);
	}

	
	@Override 
	public void addReturn(int returnid) throws Exception {
	  
		rdao.addReturn(returnid); 
	}

	@Override
	public void refundDate(String returnCode) throws Exception {

		rdao.refundDate(returnCode);
	}

	@Override
	public int returnPageCnt(ReturnVO rvo) throws Exception {
		
		return rdao.returnPageCnt(rvo);
	}

	@Override
	public int returnAllCnt() throws Exception {
		
		return rdao.returnAllCnt();
	}

	@Override
	public List<ReturnVO> returnListExcel(ReturnVO rvo) throws Exception {
		
		return rdao.returnListExcel(rvo);
	}
	
	
	
	
	
	
	
}
