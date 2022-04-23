package com.rg.mapper;

import com.github.pagehelper.Page;
import com.rg.pojo.CheckGroup;

import java.util.List;
import java.util.Map;

public interface CheckGroupMapper {
    public void add(CheckGroup checkGroup);

    public void setCheckGroupAndCheckItem(Map <String, Integer> map);

    //根据条件进行查询
    Page<CheckGroup> findByCondition(String queryString);

    CheckGroup findById(Integer id);

    List<Integer> findCheckItemIdsByCheckGroupId(Integer id);

    void edit(CheckGroup checkGroup);

    void deleteAssociation(Integer id);

    List<CheckGroup> findAll();
}
