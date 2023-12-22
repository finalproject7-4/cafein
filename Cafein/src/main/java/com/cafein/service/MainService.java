package com.cafein.service;

import com.cafein.domain.MemberVO;

public interface MainService {

	// 로그인 처리 동작
	public MemberVO memberLogin(MemberVO vo) throws Exception;
	
}
