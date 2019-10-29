package com.cart.service;

import com.cart.entity.User;
import com.cart.exception.DuplicateUsernameException;

public interface UserService {
    public User login(String username, String password);

    public void regist(User user) throws DuplicateUsernameException;
}
