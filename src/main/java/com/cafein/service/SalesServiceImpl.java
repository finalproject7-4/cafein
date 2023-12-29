package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.ClientVO;
import com.cafein.domain.SalesVO;
import com.cafein.domain.TestVO;
import com.cafein.persistence.SalesDAO;
import com.cafein.persistence.TestDAO;

@Service
public class SalesServiceImpl implements SalesService {

	private static final Logger logger = LoggerFactory.getLogger(SalesServiceImpl.class);

	@Inject
	private SalesDAO sdao;

	/*수주등록*/
	@Override
	public void registPO(SalesVO svo) throws Exception{
		logger.debug("registPOList 메서드 호출");
		sdao.registPO(svo);
	}

	/*수주조회*/
	@Override
	public List<SalesVO> AllPOList() throws Exception{
		logger.debug("AllPOList()");
		return sdao.getPOList();
	}

	/*수주등록 - 납품처 */
	@Override
	public List<SalesVO> registCli() throws Exception {
		logger.debug("registCli()");
		return sdao.registCli();
	}

	/*수주등록 - 품목 */
	@Override
	public List<SalesVO> registItem() throws Exception {
		logger.debug("registItem()");
		return sdao.registItem();
	}
	
	


	

}
