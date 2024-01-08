package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.ItemVO;
import com.cafein.domain.SalesVO;

@Repository
public class SalesDAOImpl implements SalesDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SalesDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	// mapper 위치정보
	private static final String NAMESPACE ="com.cafein.mapper.SalesMapper";

	// 수주 등록
	@Override
	public void registPO(SalesVO svo) throws Exception{
		logger.debug(" DAO : registPO(SalesVO svo)");
		sqlSession.insert(NAMESPACE+".registPO",svo);
	}
	
	// 수주 조회
//	@Override
//	public List<SalesVO> getPOList() throws Exception{
//		logger.debug("DAO : 수주조회");
//		return sqlSession.selectList(NAMESPACE+".getPOList");
//	}

	//페이징
	@Override
	public List<SalesVO> getPOList(SalesVO svo) throws Exception {
		logger.debug("DAO : getPOList(SalesVO svo)");
		return sqlSession.selectList(NAMESPACE+".POListPage",svo);
	}

	// 수주 등록-납품처
	@Override
	public List<SalesVO> registCli() throws Exception {
		logger.debug("DAO : 수주조회-납품처");
		return sqlSession.selectList(NAMESPACE+".cliList");
	}

	// 수주 등록-품목
	@Override
	public List<SalesVO> registItem() throws Exception {
		logger.debug("DAO : 수주조회-품목");
		return sqlSession.selectList(NAMESPACE+".iList");
	}

	// 수주코드 생성
	@Override
	public int getPOCount(SalesVO svo) throws Exception {
		logger.debug("DAO : getItemCount(SalesVO svo)");
		return sqlSession.selectOne(NAMESPACE + ".getPOCount", svo);
	}

	//수주수정
	@Override
	public int updatePO(SalesVO svo) throws Exception {
		logger.debug("DAO : POModify(SalesVO svo)");
		return sqlSession.update(NAMESPACE + ".updatePO", svo);
	}
	
	//납품서
	@Override
	public List<SalesVO> getReceiptList() throws Exception {
		logger.debug("DAO : getReceiptList()");
		return sqlSession.selectList(NAMESPACE+".getReceiptList");
	}

	//엑셀
	@Override
	public List<SalesVO> getPOPrint() throws Exception {
		logger.debug("DAO : getPOPrint()");
		return sqlSession.selectList(NAMESPACE+".getPOList");
	}

	//수주상태취소
	@Override
	public int updatePOstate(SalesVO svo) throws Exception {
		logger.debug("DAO : updatePOstate(svo)");
		return sqlSession.update(NAMESPACE+".cancelPOState",svo);
	}

	//수주상태 진행
	@Override
	public int ingUpdate(SalesVO svo) throws Exception {
		logger.debug("DAO : ingUpdate(svo)");
		return sqlSession.update(NAMESPACE+".ingPOState",svo);
	}

	//총개수
	@Override
	public int countPO(SalesVO svo) throws Exception {
		logger.debug("DAO : countPO(svo)");
		return sqlSession.selectOne(NAMESPACE+".countPO",svo);
	}

	//리스트출력
	@Override
	public List<SalesVO> selectPOListExcel(SalesVO svo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".selectPOListExcel", svo);
	}
	//수주상태-대기
	@Override
	public List<SalesVO> stopState() throws Exception {
		logger.debug("DAO : 수주조회");
		return sqlSession.selectList(NAMESPACE+".stop");
	}

	//납품서출력
	@Override
	public SalesVO getReceiptByPoid(int poid) throws Exception {
		logger.debug("DAO : 수주조회");
		return sqlSession.selectOne(NAMESPACE+".receipt", poid);
	}
	
	
	
	
	
	

	
	

}
