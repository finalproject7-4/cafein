package com.cafein.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.cafein.domain.SalesVO;
import com.cafein.persistence.SalesDAO;

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
//	@Override
//	public List<SalesVO> AllPOList() throws Exception{
//		logger.debug("S :AllPOList()");
//		return sdao.getPOList();
//	}
	
	//페이징
	@Override
	public List<SalesVO> POList(SalesVO svo) throws Exception {
		logger.debug("Service - POList(SalesVO svo)");
		return sdao.getPOList(svo);
	}
	

	/*수주등록 - 납품처 */
	@Override
	public List<SalesVO> registCli() throws Exception {
		logger.debug("S :registCli()");
		return sdao.registCli();
	}

	/*수주등록 - 품목 */
	@Override
	public List<SalesVO> registItem() throws Exception {
		logger.debug("S :registItem()");
		return sdao.registItem();
	}

	/*수주코드 생성-코드*/
	@Override
	public String pocode(SalesVO svo) throws Exception {
		logger.debug("S : pocode(SalesVO svo)");
		return sdao.getPOCode(svo);
	}
	/*수주코드 생성-개수*/
	@Override
	public int poCount(SalesVO svo) throws Exception {
		logger.debug("S : poCount(SalesVO svo)");
		return sdao.getPOCount(svo);
	}

	//수주수정
	@Override
	public int POModify(SalesVO svo) throws Exception {
		logger.debug("S : POModify(int poid)");
		return sdao.updatePO(svo);
	}
	
	//납품서
	@Override
	public List<SalesVO> receiptList() throws Exception {
		logger.debug("S :receiptList()");
		return sdao.getReceiptList();
	}

	//엑셀
	@Override
	public List<SalesVO> POPrint() throws Exception {
		logger.debug("S :POPrint()");
		return sdao.getPOPrint();
	}

	//수주상태 취소
	@Override
	public int updatePOstate(SalesVO svo) throws Exception {
		logger.debug("S :updatePOstate(svo)");
		return sdao.updatePOstate(svo);
	}

	//수주상태 진행
	@Override
	public int ingUpdate(SalesVO svo) throws Exception {
		logger.debug("S :ingUpdate(svo)");
		return sdao.ingUpdate(svo);
	}

	//수주 총개수
	@Override
	public int countPO(SalesVO svo) throws Exception {
		logger.debug("S : countPO(SalesVO svo)");
		return sdao.countPO(svo);
	}
	//리스트출력
	@Override
	public List<SalesVO> POListExcel(SalesVO svo) throws Exception {
		// TODO Auto-generated method stub
		return sdao.selectPOListExcel(svo);
	}

	//수주상태-대기
	@Override
	public List<SalesVO> stopState() throws Exception {
		logger.debug("S :stopState()");
		return sdao.stopState();
	}

	//납품서 출력
	@Override
	public SalesVO getReceiptByPoid(int poid) throws Exception {
		logger.debug("S :getReceiptByPoid(poid)");
		return sdao.getReceiptByPoid(poid);
	}
	
	
	

	
	
	
	
	
	


	

}
