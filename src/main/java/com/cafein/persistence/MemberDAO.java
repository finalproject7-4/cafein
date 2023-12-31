package com.cafein.persistence;

import java.util.List;

import com.cafein.domain.MemberVO;

public interface MemberDAO {
	
	// 직원 등록 동작
	public void insertMember(MemberVO vo) throws Exception;
	
	// 직원 목록 조회
	public List<MemberVO> getMemberList() throws Exception;
	
	// 직원 정보 조회
	public MemberVO getMember(int memberid) throws Exception;
	
	// 직원 정보 수정
	public int updateMember(MemberVO vo) throws Exception;
	
	// 직원 정보 삭제
	public int deleteMember(MemberVO vo) throws Exception;
	
	

}
