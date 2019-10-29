package com.cart.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Set;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Order implements Serializable {
    private Integer id;
    private String no;
    private Double totalPrice;
    private User user;

    private Set<Item> items;
}
