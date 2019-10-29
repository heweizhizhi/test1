package com.cart.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Cart implements Serializable {
    private Double totalPrice = 0.0;
    private List<Item> items = new ArrayList<>();
}
