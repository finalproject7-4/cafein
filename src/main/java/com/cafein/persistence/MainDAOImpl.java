package com.cafein.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.MemberVO;

@Repository
public class MainDAOImpl implements MainDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(MainDAOImpl.class);

	@Inject
	private SqlSession sqlSession;
	
	// mapper 위치정보
	private static final String NAMESPACE ="com.cafein.mapper.MainMapper";

	@Override
	public MemberVO selectLoginMember(MemberVO vo) {
		logger.debug("DAO - selectLoginMember(MemberVO vo)");
		return sqlSession.selectOne(NAMESPACE + ".loginMember", vo);
	}



}
