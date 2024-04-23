package com.bookMall.admin.goods.service;

import com.bookMall.admin.goods.dao.AdminGoodsDAO;
import com.bookMall.goods.vo.GoodsVO;
import com.bookMall.goods.vo.ImageFileVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service("adminGoodsServiceImpl")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminGoodsServiceImpl implements AdminGoodsService {

    @Autowired
    private AdminGoodsDAO adminGoodsDAO;

    @Override
    public int addNewGoods(Map newGoodsMap) throws Exception {
        int goodsId = adminGoodsDAO.insertNewGoods(newGoodsMap);
        ArrayList<ImageFileVO> imageFileList = (ArrayList<ImageFileVO>) newGoodsMap.get("imageFileList");
        for (ImageFileVO imageFileVO : imageFileList) {
            imageFileVO.setGoodsId(goodsId);
        }
        adminGoodsDAO.insertGoodsImageFile(imageFileList);
        return goodsId;
    }

    @Override
    public List<GoodsVO> listNewGoods(Map condMap) throws Exception {
        return adminGoodsDAO.selectNewGoodsList(condMap);
    }
}
