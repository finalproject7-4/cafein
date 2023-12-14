package com.cafein.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.TestVO;


@Repository
public class TestDAOImpl implements TestDAO {
	
	
	private static final Logger logger = LoggerFactory.getLogger(TestDAOImpl.class);
	@Inject
	private SqlSession sqlSession;
	
	// mapper 위치정보
	private static final String NAMESPACE ="com.cafein.mapper.TestMapper";

	@Override
	public void insertMember(TestVO vo) {
		logger.debug("회원가입 테스트");
		sqlSession.insert(NAMESPACE + ".insertMember", vo);
		
		
	}
	
	@Override
	public TestVO selectLoginMember(TestVO vo) {
		logger.debug(" DAO - 로그인 처리 selectloginMember(MemberVO vo) ");
		
		TestVO resultVO
			= sqlSession.selectOne(NAMESPACE+".loginMember",vo);
		logger.debug("결과:"+resultVO);
		
		return resultVO;
	}
	
	
	
	
	
	
	

}
