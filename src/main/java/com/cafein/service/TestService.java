package com.cafein.service;

import com.cafein.domain.TestVO;

public interface TestService {
	
	//test
	public void memberJoin(TestVO vo);
	
	// 로그인 처리 동작
		public TestVO memberLogin(TestVO vo);
}
