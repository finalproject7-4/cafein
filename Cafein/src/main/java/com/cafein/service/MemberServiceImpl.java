package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.ClientVO;
import com.cafein.domain.MemberVO;
import com.cafein.persistence.ClientDAO;
import com.cafein.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Inject
	private MemberDAO mdao;

	@Override
	public void memberJoin(MemberVO vo) throws Exception {
		logger.debug(" Service : 직원 등록 memberJoin(MemberVO vo) ");
		mdao.insertMember(vo);
	}

	@Override
	public MemberVO memberLogin(MemberVO vo) throws Exception {
		logger.debug(" Service : 직원 로그인 처리 memberLogin(MemberVO vo) ");
		return mdao.selectLoginMember(vo);
	}

	@Override
	public List<MemberVO> memberListAll() throws Exception {
		logger.debug(" Service : 직원 목록 조회 memberListAll() ");
		return mdao.getMemberList();
	}

	@Override
	public MemberVO memberInfo(int memberid) throws Exception {
		logger.debug(" Service : 회원 정보 조회 memberInfo(int memberid) ");
		return mdao.getMember(memberid);
	}

	@Override
	public void memberUpdate(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void memberDelete(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	
	
	
	
	
	
	

}
