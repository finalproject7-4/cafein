package com.cafein.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.MemberVO;
import com.cafein.persistence.MainDAO;

@Service
public class MainServiceImpl implements MainService {

	private static final Logger logger = LoggerFactory.getLogger(MainServiceImpl.class);

	@Inject
	private MainDAO mdao;

	@Override
	public MemberVO memberLogin(MemberVO vo) throws Exception {
		logger.debug(" Service - memberLogin(MemberVO vo) 호출 ");
		return mdao.selectLoginMember(vo);
	}


}
