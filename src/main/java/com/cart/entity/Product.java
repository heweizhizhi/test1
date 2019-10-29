package com.cart.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Product implements Serializable {
    private Integer id;
    private String name;
    //BigDecimal
    private Double price;
    private String image;
    private String desc;

    private ProductType productType;
}
