package com.cafein.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.TestVO;
import com.cafein.persistence.TestDAO;

@Service
public class TestServiceImpl implements TestService {

	private static final Logger logger = LoggerFactory.getLogger(TestServiceImpl.class);

	@Inject
	private TestDAO tdao;

	@Override
	public void memberJoin(TestVO vo) {
		logger.debug("TEST 메서드 호출");
		tdao.insertMember(vo);

	}

	@Override
	public TestVO memberLogin(TestVO vo) {
		logger.debug("Service - 로그인 처리 memberLogin(MemberVo vo) ");
		return tdao.selectLoginMember(vo);
	}

}
