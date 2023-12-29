package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.Criteria;
import com.cafein.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.cafein.mapper.MemberMapper";

	@Override
	public void insertMember(MemberVO vo) throws Exception {
		logger.debug(" DAO : 직원 등록 insertMember(MemberVO vo) ");
		sqlSession.insert(NAMESPACE + ".insertMember", vo);
	}
	
	@Override
	public List<MemberVO> getMemberList(int page) throws Exception {
		logger.debug(" DAO : 직원 목록 조회 getMemberList(int page) ");

		page = (page - 1) *10;
		return sqlSession.selectList(NAMESPACE + ".getMemberList", page);
	}
	
	@Override
	public List<MemberVO> getMemberList(Criteria cri) throws Exception {
		logger.debug(" DAO : 직원 목록 조회 getMemberList(Criteria cri) ");
		return sqlSession.selectList(NAMESPACE + ".getMemberList", cri);
	}
	
	@Override
	public int getMemberCount() throws Exception {
		logger.debug(" DAO : 총 직원 수 조회 getMemberCount() ");
		return sqlSession.selectOne(NAMESPACE + ".countMember");
	}
	
	@Override
	public MemberVO getMember(int memberid) throws Exception {
		logger.debug(" DAO : 직원 정보 조회 getMember(int memberid) ");
		return sqlSession.selectOne(NAMESPACE + ".getMember", memberid);
	}

	@Override
	public int updateMember(MemberVO vo) throws Exception {
		logger.debug(" DAO : 직원 정보 수정 updateMember(MemberVO vo) ");
		return sqlSession.update(NAMESPACE + ".updateMember", vo);
	}

	@Override
	public int deleteMember(MemberVO vo) throws Exception {
		logger.debug(" DAO : 직원 정보 삭제(비활성화) deleteMember(MemberVO vo) ");
		return sqlSession.update(NAMESPACE + ".deleteMember", vo);
	}
	

	
	
	


	
	

}


























