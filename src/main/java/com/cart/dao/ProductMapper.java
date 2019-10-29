package com.cart.dao;

import com.cart.entity.Product;
import com.cart.vo.Condition;

import java.util.List;

public interface ProductMapper {
    public List<Product> selectAll();

    public List<Product> selectByCondition(Condition condition);

    public Product selectById(Integer id);
}
