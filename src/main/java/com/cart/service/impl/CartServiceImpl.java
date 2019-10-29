package com.cart.service.impl;

import com.cart.dao.ProductMapper;
import com.cart.entity.Cart;
import com.cart.entity.Item;
import com.cart.entity.Product;
import com.cart.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Service
public class CartServiceImpl implements CartService {
    @Autowired
    private ProductMapper productMapper;

    @Override
    public void add(Cart cart, Integer id) {
        List<Item> items = cart.getItems();

        //是否购买过当前商品，默认没有
        boolean flag = false;

        //判断是否购买过该id对应的商品
        for(Item item : items){
            //是
            if(item.getProduct().getId().equals(id)){
                //修改对应明细的数量:+1
                item.setNum(item.getNum() + 1);
                //修改对应明细的总价:+单价
                item.setTotalPrice(item.getTotalPrice() + item.getProduct().getPrice());
                //修改当前购物车总价:+单价
                cart.setTotalPrice(cart.getTotalPrice() + item.getProduct().getPrice());

                flag = true;
            }
        }

        //否
        if(!flag){
            //创建新的Item，设置数据
            Item item = new Item();
            item.setNum(1);
            Product product = productMapper.selectById(id);
            item.setProduct(product);
            item.setTotalPrice(product.getPrice());
            //添加到当前购物车，修改当前购物车总价:+单价
            items.add(item);
            cart.setTotalPrice(cart.getTotalPrice() + product.getPrice());
        }
    }

    @Override
    public void removeItemByProductId(Cart cart, Integer productId) {
        List<Item> items = cart.getItems();
        Iterator<Item> it = items.iterator();
        while(it.hasNext()){
            Item item = it.next();
            if(item.getProduct().getId().equals(productId)){
                it.next();
            }
            return;
        }
    }

    @Override
    public Map<String, String> modifyItemNumByProductId(Cart cart, Integer productId, Integer num) {
        List<Item> items = cart.getItems();
        Iterator<Item> it = items.iterator();
        Map<String, String> map = new HashMap<>();
        while(it.hasNext()){
            Item item = it.next();
            if(item.getProduct().getId().equals(productId)){
               item.setNum(num);
               cart.setTotalPrice(cart.getTotalPrice() -  item.getTotalPrice() + item.getProduct().getPrice() * num);
               item.setTotalPrice(item.getProduct().getPrice() * num);
                map.put("itemTotalPrice", item.getTotalPrice() + "");
                map.put("cartTotalPrice", cart.getTotalPrice() + "");
                return map;
            }
        }

        return map;
    }
}
