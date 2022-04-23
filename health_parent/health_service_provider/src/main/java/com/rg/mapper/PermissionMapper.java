package com.rg.mapper;

import com.rg.pojo.Permission;

import java.util.Set;

public interface PermissionMapper {
    Set<Permission> findByRoleId(Integer roleId);
}
