package com.cafein.service;

import java.util.List;

import com.cafein.domain.ReceiveVO;
import com.cafein.domain.ReleasesVO;

public interface ReleasesService {
	
	// 출고 목록
	public List<ReleasesVO> releasesList() throws Exception;
	
}
