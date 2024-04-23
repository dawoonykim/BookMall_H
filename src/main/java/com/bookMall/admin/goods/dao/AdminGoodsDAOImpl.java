package com.bookMall.admin.goods.dao;

import com.bookMall.goods.vo.GoodsVO;
import com.bookMall.goods.vo.ImageFileVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository("adminGoodsDAOImpl")
public class AdminGoodsDAOImpl implements AdminGoodsDAO{

    @Autowired
    private SqlSession session;
    @Override
    public int insertNewGoods(Map newGoodsMap) throws DataAccessException {
        session.insert("mapper.admin.goods.insertNewGoods", newGoodsMap);
        return Integer.parseInt((String) newGoodsMap.get("goodsId"));
    }

    @Override
    public void insertGoodsImageFile(List fileList) throws DataAccessException {
        for (int i = 0; i < fileList.size(); i++) {
            ImageFileVO imageFileVO = (ImageFileVO) fileList.get(i);
            session.insert("mapper.admin.goods.insertGoodsImageFile");
        }
    }


    @Override
    public List<GoodsVO> selectNewGoodsList(Map condMap) throws DataAccessException {
        ArrayList<GoodsVO> goodsList = (ArrayList) session.selectList("mapper.admin.goods.selectNewGoodsList", condMap);
        return goodsList;
    }

}
