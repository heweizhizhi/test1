package com.cart.service.impl;

import com.cart.consts.Constants;
import com.cart.dao.UserMapper;
import com.cart.entity.User;
import com.cart.exception.DuplicateUsernameException;
import com.cart.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT, rollbackFor = Exception.class, timeout = 10)
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public User login(String username, String password) {
        return userMapper.selectByUsernameAndPassword(username, password);
    }

    @Override
    public void regist(User user) throws DuplicateUsernameException {
        //判断用户名是否已存在
        User userx = userMapper.selectByUsername(user.getUsername());

        if(userx != null){
            throw new DuplicateUsernameException("用户名已存在!");
        }

        //设置用户的默认头像
        user.setImage(Constants.DEFAULT_USER_HEAD_IMAGE);

        //保存
        userMapper.insert(user);
    }
}
