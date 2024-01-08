package com.cafein.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.cafein.domain.ItemVO;

@Repository
public class ItemDAOImpl implements ItemDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.cafein.mapper.ItemMapper";

	// 품목 목록
	@Override
	public List<ItemVO> selectItemList() throws Exception {
		logger.debug("DAO - selectItemList()");
		return sqlSession.selectList(NAMESPACE + ".selectItemList");
	}	
	
	// 품목 목록 (페이징)
	@Override
	public List<ItemVO> selectItemList(ItemVO vo) throws Exception {
		logger.debug("DAO - selectItemList(ItemVO vo)");
		return sqlSession.selectList(NAMESPACE + ".selectItemListPage", vo);
	}

	// 품목 목록 총 개수
	@Override
	public Integer selectItemCount(ItemVO vo) throws Exception {
		logger.debug("DAO - selectItemCount(ItemVO vo)");
		return sqlSession.selectOne(NAMESPACE + ".selectItemCount", vo);
	}

	// 품목 유형에 따른 총 개수
	@Override
	public int selectItemTypeCount(ItemVO vo) throws Exception {
		logger.debug("DAO - selectItemCount(ItemVO vo)");
		return sqlSession.selectOne(NAMESPACE + ".selectItemTypeCount", vo);
	}

	// 품목 등록
	@Override
	public void insertItem(ItemVO vo) throws Exception {
		logger.debug("DAO - insertItem(ItemVO vo)");
		sqlSession.insert(NAMESPACE + ".insertItem", vo);
	}

	// 품목 수정
	@Override
	public int updateItem(ItemVO vo) throws Exception {
		logger.debug("DAO - updateItem(ItemVO vo)");
		return sqlSession.update(NAMESPACE + ".updateItem", vo);
	}

	// 품목 삭제 (비활성화)
	@Override
	public void deleteItem(ItemVO vo) {
		logger.debug("DAO - deleteItem(int itemid)");
		sqlSession.update(NAMESPACE + ".deleteItem", vo);
	}

	// 품목 목록 (엑셀 파일 다운로드)
	@Override
	public List<ItemVO> selectItemListExcel(ItemVO vo) throws Exception {
		logger.debug("DAO - selectItemListExcel(ItemVO vo)");
		return sqlSession.selectList(NAMESPACE + ".selectItemListExcel", vo);
	}

}