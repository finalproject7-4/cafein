package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.ProduceVO;
import com.cafein.domain.ReturnVO;
import com.cafein.persistence.ReturnDAO;

@Service
public class ReturnServiceImpl implements ReturnService {

	
	private static final Logger logger = LoggerFactory.getLogger(ReturnServiceImpl.class);
	
	@Inject
	private ReturnDAO rdao;

	@Override
	public List<ReturnVO> searchReturns() throws Exception {
		
		return rdao.searchReturns();
	}

	@Override
	public List<ReturnVO> searchReturnsByCondition(ReturnVO rvo) throws Exception {

		return rdao.searchReturnsByCondition(rvo);
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
	public List<ProduceVO> prList() throws Exception {

		return rdao.prList();
	}

	@Override
	public int returnModify(ReturnVO rvo) throws Exception {
		
		return rdao.updateReturn(rvo);
	}
	
	
	
	

	/*
	 * @Override public List<ReturnVO> searchReturns() throws Exception {
	 * 
	 * return rdao.searchReturns(); }
	 * 
	 * @Override public List<ReturnVO> searchReturnsByCondition(ReturnVO rvo) throws
	 * Exception {
	 * 
	 * return rdao.searchReturnsByCondition(rvo); }
	 * 
	 * @Override public int returnCount(ReturnVO rvo) throws Exception {
	 * 
	 * return rdao.getReturnCount(rvo); }
	 * 
	 * @Override public void returnRegist(ReturnVO rvo) throws Exception {
	 * 
	 * rdao.insertReturn(rvo); }
	 * 
	 * @Override public List<ProduceVO> prList() throws Exception {
	 * 
	 * 
	 * return rdao.prList(); }
	 * 
	 * @Override public int returnModify(ReturnVO rvo) throws Exception {
	 * 
	 * return rdao.updateReturn(rvo); }
	 */
	
	

	

	
	
	
	
	
	
	
}
