package com.cafein.persistence;

import com.cafein.domain.TestVO;

public interface TestDAO {
	
	// test
	public void insertMember(TestVO vo);
	
	public TestVO selectLoginMember(TestVO vo);
	

}
