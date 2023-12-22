package com.cafein.persistence;

import com.cafein.domain.MemberVO;

public interface MainDAO {
	
	// 로그인
	public MemberVO selectLoginMember(MemberVO vo);
	
	

}
