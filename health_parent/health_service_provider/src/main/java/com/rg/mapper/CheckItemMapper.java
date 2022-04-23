package com.rg.mapper;

import com.github.pagehelper.Page;
import com.rg.pojo.CheckItem;

import java.util.List;

public interface CheckItemMapper {
    public void add(CheckItem checkItem);
    public Page<CheckItem> selectByCondition(String queryString);//使用Mybatis的分页插件,最后结果必须封装在Page中
    public Integer findCountByCheckItemId(Integer id);
    public void deleteById(Integer id);
    public CheckItem findById(Integer id);
    public void edit(CheckItem checkItem);
    public List<CheckItem> findAll();
}
