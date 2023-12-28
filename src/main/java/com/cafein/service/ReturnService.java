package com.cafein.service;

import java.util.List;

import com.cafein.domain.ReturnVO;

public interface ReturnService {

	List<ReturnVO> searchReturns() throws Exception;
	 List<ReturnVO> searchReturnsByCondition(ReturnVO condition) throws Exception;
}