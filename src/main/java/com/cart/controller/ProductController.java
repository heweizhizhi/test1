package com.cart.controller;

import com.cart.consts.Constants;
import com.cart.entity.Cart;
import com.cart.entity.Product;
import com.cart.entity.ProductType;
import com.cart.entity.User;
import com.cart.service.ProductService;
import com.cart.service.ProductTypeService;
import com.cart.vo.Condition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.util.List;

@Controller
@RequestMapping("/product")
@SessionAttributes({"user", "cart"}) //TODO:后期删除
public class ProductController {

    @Autowired
    private ProductTypeService productTypeService;
    @Autowired
    private ProductService productService;

    @RequestMapping({"/showMain", "findByCondition"})
    public String showMain(Condition condition, Model model){
        model.addAttribute("user", new User()); //TODO:后期删除
        model.addAttribute("cart", new Cart()); //TODO:后期删除

        if(condition.getProductTypeId() == null){
            condition.setProductTypeId(Constants.ALL_PRODUCT_TYPES);
        }

        List<Product> products = productService.findByCondition(condition);
        model.addAttribute("products", products);

        List<ProductType> productTypes = productTypeService.findAll();

        model.addAttribute("products", products);
        model.addAttribute("productTypes", productTypes);

        //model.addAttribute("condition", condition);

        return "main";
    }

}
