package com.cart.service.impl;

import com.cart.dao.ProductMapper;
import com.cart.entity.Product;
import com.cart.service.ProductService;
import com.cart.vo.Condition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductMapper productMapper;

    @Override
    public List<Product> findAll() {
        return productMapper.selectAll();
    }

    @Override
    public List<Product> findByCondition(Condition condition) {
        return productMapper.selectByCondition(condition);
    }
}
