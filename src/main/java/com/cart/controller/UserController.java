package com.cart.controller;

import com.cart.entity.Cart;
import com.cart.entity.Product;
import com.cart.entity.ProductType;
import com.cart.entity.User;
import com.cart.exception.DuplicateUsernameException;
import com.cart.service.ProductService;
import com.cart.service.ProductTypeService;
import com.cart.service.UserService;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/doLogin")
    public String doLogin(String username, String password, String code, HttpServletRequest request, HttpSession session){
        //验证码验证
        String originCode = (String) session.getAttribute("code");
        if(!originCode.equalsIgnoreCase(code)){
            request.setAttribute("msg", "验证码错误");
            return "redirect:/product//product/showMain";
        }

        User user = userService.login(username, password);

        //用户登录成功时，为用户创建购物车
        //注销登录、提交订单时，清空购车
        if(user != null){
            session.setAttribute("user", user);
            Cart cart = new Cart();
            session.setAttribute("cart", cart);
        }else {
            request.setAttribute("msg", "用户名或密码错误");
        }

        return "redirect:/product/showMain";
    }

    @RequestMapping("/quit")
    public String quit(HttpSession session){
        session.invalidate();
        return "redirect:/product/showMain";
    }

    @RequestMapping("/doRegist")
    public String doRegist(User user, HttpServletRequest request){
        try {
            userService.regist(user);
        } catch (DuplicateUsernameException e) {
            request.setAttribute("msg", e.getMessage());
        }
        return "redirect:/product/showMain";
    }

    @RequestMapping("/generateCode")
    public void generateCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Random random=new Random();
        //在内存中创建画图板
        BufferedImage image=new BufferedImage(70,23,BufferedImage.TYPE_INT_RGB);

        //获得画笔
        Graphics graphics=image.getGraphics();

        //设置画笔颜色
        graphics.setColor(new Color(random.nextInt(256),random.nextInt(256),random.nextInt(256)));

        //画一个带填充色的矩形作为背景颜色
        graphics.fillRect(0, 0, 70, 30);

        //设置画笔颜色
        graphics.setColor(new Color(random.nextInt(256),random.nextInt(256),random.nextInt(256)));

        //设置字体
        graphics.setFont(new Font("Courier New", Font.BOLD+Font.ITALIC,18));

        //生成一个5位的随机字符串，字符串中包括[a-z][0-9]
        String s="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        StringBuffer code=new StringBuffer();
        for (int i = 0; i < 5; i++) {
            code.append(s.charAt(random.nextInt(s.length())));
        }

        //将code写到图片上
        graphics.drawString(code.toString(), 6, 16);
        request.getSession().setAttribute("code", code.toString());

        System.out.println(code);
        //将图片发送给客户端
        OutputStream out=response.getOutputStream();

        //将图片压缩成JPEG格式写入out中
        JPEGImageEncoder encoder= JPEGCodec.createJPEGEncoder(out);
        encoder.encode(image);
    }
}
