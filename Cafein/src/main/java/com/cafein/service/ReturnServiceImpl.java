package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

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
	public List<ReturnVO> searchReturnsByCondition(ReturnVO condition) throws Exception {
		
		return rdao.searchReturnsByCondition(condition);
	}

	@Override
	public int returnCount(ReturnVO vo) throws Exception {
		
		return rdao.getReturnCount(vo);
	}

	@Override
	public void returnRegist(ReturnVO vo) throws Exception {
		
		/* rdao.insertReturn(vo); */
	}

	
	

	

	
	
	
	
	
	
	
}
