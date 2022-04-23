package com.rg.service;

import com.rg.pojo.User;

public interface UserService {
    User findByUsername(String username);
}
