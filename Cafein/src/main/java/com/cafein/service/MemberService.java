package com.cafein.service;

import java.util.List;

import com.cafein.domain.MemberVO;

public interface MemberService {
	
	// 직원 정보 등록 동작
	public void memberJoin(MemberVO vo) throws Exception;
	
	// 최신 등록된 직원의 직원 코드 확인
	public int maxMemberCode(MemberVO vo) throws Exception;
	
	// 직원 목록 조회 (페이징)
	public List<MemberVO> memberPageList(MemberVO vo) throws Exception;
	
	// 총 직원 수 조회
	public Integer totalMemberCount(MemberVO vo) throws Exception;
	
	// 직원 정보를 list에 담아오는 동작
	public List<MemberVO> memberList() throws Exception;
	
	// 특정 직원 정보 조회 동작
	public MemberVO memberInfo(int memberid) throws Exception;
	
	// 특정 직원 정보 수정 동작
	public int memberUpdate(MemberVO vo) throws Exception;
	
	// 특정 직원 정보 삭제 동작
	public int memberDelete(MemberVO vo) throws Exception;


}