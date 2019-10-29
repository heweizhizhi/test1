package com.cart.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class User implements Serializable {
    private Integer id;
    private String nickName;
    private String username;
    private String password;
    private String phone;
    private String address;
    private String image;
}
