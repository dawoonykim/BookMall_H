package com.bookMall.cart.service;

import com.bookMall.cart.vo.CartVO;

import java.util.List;
import java.util.Map;

public interface CartService {
    public boolean findCartGoods(CartVO cartVO) throws Exception;

    public void addGoodsInCart(CartVO cartVO) throws Exception;

    public Map<String, List> myCartList(CartVO cartVO) throws Exception;

    public void removeCartGoods(int cartId) throws Exception;

    public boolean modifyCartQty(CartVO cartVO) throws Exception;
}
