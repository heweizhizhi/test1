package com.cart.dao;

import com.cart.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    public User selectByUsernameAndPassword(@Param("username") String username, @Param("password") String password);

    public User selectByUsername(String username);

    public void insert(User user);
}
