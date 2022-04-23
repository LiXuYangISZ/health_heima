package com.rg.service;

import com.rg.entity.PageResult;
import com.rg.entity.QueryPageBean;
import com.rg.pojo.SetMeal;

import java.util.List;
import java.util.Map;

public interface SetMealService {
    void add(SetMeal setMeal, Integer[] checkgroupIds);

    PageResult findPage(QueryPageBean queryPageBean);

    List<Integer> findCheckGroupIdsBySetMealId(Integer id);

    void edit(SetMeal setMeal, Integer[] checkgroupIds);

    List<SetMeal> findAllSetMeal();

    void deleteById(Integer id);

    SetMeal findById(Integer id);

    List<Map<String, Object>> findSetMealCount();

}
