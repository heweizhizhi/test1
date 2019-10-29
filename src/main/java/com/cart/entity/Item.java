package com.cart.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Item implements Serializable {
    private Integer id;
    private Product product;
    private Integer num;
    private Double totalPrice;
    private Date createTime;

    private Order order;
}
