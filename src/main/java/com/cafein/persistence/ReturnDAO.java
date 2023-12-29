package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ReturnVO;

public interface ReturnDAO {
	
	 List<ReturnVO> searchReturns() throws Exception;
	 
	 List<ReturnVO> searchReturnsByCondition(ReturnVO condition) throws Exception;
}