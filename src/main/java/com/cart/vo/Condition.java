package com.cart.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Condition {
    private Double minPrice;
    private Double maxPrice;
    private Integer productTypeId;
}
