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

	@Override
	public List<ItemVO> getItemList() throws Exception {
		logger.debug("DAO - getItemList()");
		return sqlSession.selectList(NAMESPACE + ".itemList");
	}	
	
	@Override
	public List<ItemVO> getItemList(ItemVO vo) throws Exception {
		logger.debug("DAO - getItemList(ItemVO vo)");
		return sqlSession.selectList(NAMESPACE + ".itemListPage", vo);
	}

	@Override
	public Integer getItemCount(ItemVO vo) throws Exception {
		logger.debug("DAO - getItemCount(ItemVO vo)");
		return sqlSession.selectOne(NAMESPACE + ".getItemCount", vo);
	}

	@Override
	public void insertItem(ItemVO vo) throws Exception {
		logger.debug("DAO - insertItem(ItemVO vo)");
		sqlSession.insert(NAMESPACE + ".insertItem", vo);
	}

	@Override
	public int getItemTypeCount(ItemVO vo) throws Exception {
		logger.debug("DAO - getItemCount(ItemVO vo)");
		return sqlSession.selectOne(NAMESPACE + ".getItemTypeCount", vo);
	}

	@Override
	public int updateItem(ItemVO vo) throws Exception {
		logger.debug("DAO - updateItem(ItemVO vo)");
		return sqlSession.update(NAMESPACE + ".updateItem", vo);
	}

	@Override
	public void deleteItem(ItemVO vo) {
		logger.debug("DAO - deleteItem(int itemid)");
		sqlSession.update(NAMESPACE + ".deleteItem", vo);
	}

}