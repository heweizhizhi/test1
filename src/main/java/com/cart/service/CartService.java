package com.cart.service;

import com.cart.entity.Cart;

import java.util.Map;

public interface CartService {
    public void add(Cart cart, Integer id);

    public void removeItemByProductId(Cart cart, Integer productId);

    public Map<String, String> modifyItemNumByProductId(Cart cart, Integer productId, Integer num);
}
