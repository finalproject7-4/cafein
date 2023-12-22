package com.cafein.service;

import java.util.List;

import com.cafein.domain.ClientVO;
import com.cafein.domain.MemberVO;

public interface MemberService {
	
	// 직원 정보 등록 동작
	public void memberJoin(MemberVO vo) throws Exception;
	
	// 로그인 처리 동작
	public MemberVO memberLogin(MemberVO vo) throws Exception;
	
	// 직원 목록 가져오기 동작
	public List<MemberVO> memberListAll() throws Exception;
	
	// 특정 직원 정보 조회 동작
	public MemberVO memberInfo(int memberid) throws Exception;
	
	// 특정 직원 정보 수정 동작
	public void memberUpdate(MemberVO vo) throws Exception;
	
	// 특정 직원 정보 삭제 동작
	public void memberDelete(MemberVO vo) throws Exception;

}
