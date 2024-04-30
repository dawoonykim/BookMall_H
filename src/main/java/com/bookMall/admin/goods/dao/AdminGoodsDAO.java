package com.bookMall.admin.goods.dao;

import com.bookMall.goods.vo.GoodsVO;
import com.bookMall.goods.vo.ImageFileVO;
import org.springframework.dao.DataAccessException;

import java.util.List;
import java.util.Map;

public interface AdminGoodsDAO {
    public int insertNewGoods(Map newGoodsMap) throws DataAccessException;

    public void insertGoodsImageFile(List<ImageFileVO> imageFileList) throws DataAccessException;

    public List<GoodsVO> selectNewGoodsList(Map condMap) throws DataAccessException;

    public GoodsVO selectGoodsDetail(int goodsId) throws DataAccessException;

    public List selectGoodsImageFileList(int goodsId) throws DataAccessException;
}
