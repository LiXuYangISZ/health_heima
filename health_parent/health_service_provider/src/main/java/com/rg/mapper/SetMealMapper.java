package com.rg.mapper;


import com.github.pagehelper.Page;
import com.rg.pojo.SetMeal;

import java.util.List;
import java.util.Map;

public interface SetMealMapper {

     List<Integer> findCheckGroupIdsBySetMealId(Integer id);
    void add(SetMeal setMeal);

    void AddChekcGroupAndSetMeal(Map<String, Integer> map);

    Page<SetMeal> findByCondition(String queryString);

    void edit(SetMeal setMeal);

    void deleteAssociation(Integer id);

    List<SetMeal> findAllSetMeal();

    void deleteSetMeal(Integer id);

    SetMeal findById(Integer id);

    List<Map<String, Object>> findSetMealCount();
}
