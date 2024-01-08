package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.MemberVO;
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
	public int maxMemberCode(MemberVO vo) throws Exception {
		logger.debug(" Service : 최신 등록된 직원의 직원 코드 확인 maxMemberCode(int membercode) ");
		return mdao.getMaxMemberCode(vo);
	}

	@Override
	public List<MemberVO> memberPageList(MemberVO vo) throws Exception {
		logger.debug(" Service : 직원 목록 조회 memberPageList(MemberVO vo) ");
		return mdao.getMemberPageList(vo);
	}

	@Override
	public Integer totalMemberCount(MemberVO vo) throws Exception {
		logger.debug(" Service : 총 직원 수 조회 totalMemberCount(MemberVO vo) ");
		return mdao.getMemberCount(vo);
	}

	@Override
	public List<MemberVO> memberList() throws Exception {
		logger.debug(" Service : 직원 정보를 list에 담아오는 동작 memberList() ");
		return mdao.getMemberList();
	}

	@Override
	public MemberVO memberInfo(int memberid) throws Exception {
		logger.debug(" Service : 직원 정보 조회 memberInfo(int memberid) ");
		return mdao.getMember(memberid);
	}

	@Override
	public int memberUpdate(MemberVO vo) throws Exception {
		logger.debug(" Service : 직원 정보 수정 memberUpdate(MemberVO vo) ");
		return mdao.updateMember(vo);
	}

	@Override
	public int memberDelete(MemberVO vo) throws Exception {
		logger.debug(" Service : 직원 정보 비활성화 memberDelete(MemberVo vo) ");
		return mdao.deleteMember(vo);
	}
	

}