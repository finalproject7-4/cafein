package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.ReleasesVO;

public interface ReleasesDAO {

	// 출고 목록
	public List<ReleasesVO> getReleasesList() throws Exception;
	
}
