package com.rg.service;

import com.alibaba.dubbo.config.annotation.Service;
import com.rg.mapper.PermissionMapper;
import com.rg.mapper.RoleMapper;
import com.rg.mapper.UserMapper;
import com.rg.pojo.Permission;
import com.rg.pojo.Role;
import com.rg.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;

@Service(interfaceClass = UserService.class)
@Transactional
public class UserServiceImpl implements UserService{

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private PermissionMapper permissionMapper;

    //根据用户名查询数据库获取用户信息和关联的角色信息,同时需要查询角色关联的权限信息
    public User findByUsername(String username) {
        User user  = userMapper.findByUsername(username);//查询用户基本信息,不包含用户的角色
        if(user==null){
            return null;
        }
        Integer userId = user.getId();
        //根据用户id查询对应的角色
        Set<Role> roles = roleMapper.findByUserId(userId);
        for (Role role : roles) {
            Integer roleId = role.getId();
            //根据角色ID查询关联的权限
            Set<Permission> permissions = permissionMapper.findByRoleId(roleId);
            role.setPermissions(permissions);//让角色关联权限
        }
        user.setRoles(roles);//让用户关联角色
        return user;
    }
}
