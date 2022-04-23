package com.rg.mapper;

import com.rg.pojo.Role;

import java.util.Set;

public interface RoleMapper {
    Set<Role> findByUserId(Integer userId);
}
