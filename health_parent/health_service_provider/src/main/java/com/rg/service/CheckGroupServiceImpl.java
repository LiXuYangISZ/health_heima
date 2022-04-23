package com.rg.service;

import com.alibaba.dubbo.config.annotation.Service;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.rg.entity.PageResult;
import com.rg.entity.QueryPageBean;
import com.rg.mapper.CheckGroupMapper;
import com.rg.pojo.CheckGroup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

// 检查组服务
@Service(interfaceClass = CheckGroupService.class) //对外暴露服务
@Transactional //开启事务
public class CheckGroupServiceImpl implements CheckGroupService{

    @Autowired
    private CheckGroupMapper checkGroupMapper;

    @Override
    public void add(CheckGroup checkGroup, Integer[] checkitemIds) {
        //新增检查组
        checkGroupMapper.add(checkGroup);
        //设置检查组和检查项的多对对关联关系,操作t_checkgroup_checkitem表
        setCheckGroupAndCheckItem(checkGroup, checkitemIds);

    }

    //分页查询
    @Override
    public PageResult findPage(QueryPageBean queryPageBean) {
        Integer currentPage = queryPageBean.getCurrentPage();
        Integer pageSize = queryPageBean.getPageSize();
        String queryString = queryPageBean.getQueryString();
        //解决一个小bug:当在当前页搜索非当前页的内容时,出现查找不到的情况..
        if(queryString!=null && queryString.length()>0){
            currentPage = 1;
        }
        //使用Mybatis助手进行分页查询
        PageHelper.startPage(currentPage,pageSize);
        Page<CheckGroup> page =  checkGroupMapper.findByCondition(queryString);
        return new PageResult(page.getTotal(),page.getResult());
    }

    @Override
    public CheckGroup findById(Integer id) {
        return checkGroupMapper.findById(id);
    }

    //根据检查组id查询所有的检查项id
    @Override
    public List <Integer> findCheckItemIdsByCheckGroupId(Integer id) {
        return checkGroupMapper.findCheckItemIdsByCheckGroupId(id);
    }

    //编辑检查组信息,同时需要关联检查项
    @Override
    public void edit(CheckGroup checkGroup, Integer[] checkitemIds) {
        //修改检查组基本信息,操作检查组t_checkgroup表
        checkGroupMapper.edit(checkGroup);
        //清理当前检查组关联的检查项,操作中间关系表t_checkgroup_checkitem表
        checkGroupMapper.deleteAssociation(checkGroup.getId());
        //重新建立当前检查组和检查项的关联关系
        setCheckGroupAndCheckItem(checkGroup, checkitemIds);
    }

    //查询所有的检查组
    @Override
    public List <CheckGroup> findAll() {
        return checkGroupMapper.findAll();
    }

    //设置检查组和检查项的关联关系
    public void setCheckGroupAndCheckItem(CheckGroup checkGroup, Integer[] checkitemIds) {
        if (checkitemIds != null && checkitemIds.length > 0) {
            for (Integer checkitemId : checkitemIds) {
                Map <String, Integer> map = new HashMap <>();
                map.put("checkitem_id", checkitemId);
                map.put("checkgroup_id", checkGroup.getId());
                checkGroupMapper.setCheckGroupAndCheckItem(map);
            }
        }
    }


}
