package com.cart.controller;

import com.cart.dao.ProductMapper;
import com.cart.entity.Cart;
import com.cart.entity.Item;
import com.cart.entity.Product;
import com.cart.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/private/cart")
@SessionAttributes("cart")
public class CartController {
    @Autowired
    private CartService cartService;

    //商品添加到购物车
    @RequestMapping("/add")
    public void add(Integer id, HttpSession session, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain;charset=utf-8");
        PrintWriter writer = response.getWriter();
        Cart cart = (Cart) session.getAttribute("cart");

        try {
            cartService.add(cart, id);
            writer.write("添加成功");
        } catch (Exception e) {
            writer.write("添加失败");
            e.printStackTrace();
        }
    }

    @RequestMapping("/clear")
    public String clear(HttpSession session){
        session.setAttribute("cart", new Cart());
        return "redirect:/private/cart/showCart";
    }

    @RequestMapping("/removeById")
    public void removeById(Integer productId, HttpServletResponse response, Cart cart) throws IOException{
        response.setContentType("text/plain;charset=utf-8");
        PrintWriter writer = response.getWriter();

        try {
            cartService.removeItemByProductId(cart, productId);
            writer.write("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            writer.write("删除失败");
        }
    }

    @RequestMapping("/modifyItemNumByProductId")
    @ResponseBody
    public Map<String, String> modifyItemNumByProductId(Integer productId, Integer num, Cart cart, HttpServletResponse response) throws IOException {
        response.setContentType("text/json;charset=utf-8");
        Map<String, String> map = new HashMap<>();
        try {
            map = cartService.modifyItemNumByProductId(cart, productId, num);
            map.put("message","修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("message","修改失败!");
        }
        return map;
    }
}
