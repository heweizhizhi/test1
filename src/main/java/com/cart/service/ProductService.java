package com.cart.service;

import com.cart.entity.Product;
import com.cart.vo.Condition;

import java.util.List;

public interface ProductService {
    public List<Product> findAll();

    public List<Product> findByCondition(Condition condition);
}
