package com.rg.mapper;

import com.rg.pojo.User;

public interface UserMapper {
    public User findByUsername(String username);
}
