package com.rg.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.rg.constant.MessageConstant;
import com.rg.constant.RedisConstant;
import com.rg.entity.PageResult;
import com.rg.entity.QueryPageBean;
import com.rg.entity.Result;
import com.rg.pojo.SetMeal;
import com.rg.service.SetMealService;
import com.rg.utils.QiniuUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import redis.clients.jedis.JedisPool;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * 体检套餐管理
 */
@RestController
@RequestMapping("/setMeal")
public class SetMealController {

    @Autowired
    private JedisPool jedisPool;

    @Reference
    private SetMealService setMealService;


    //分页查询
    @RequestMapping("/findAllSetMeal")
    public Result findAllSetMeal(){
        try {
            List<SetMeal> list =  setMealService.findAllSetMeal();
            return new Result(true, MessageConstant.GET_SETMEAL_LIST_SUCCESS, list);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false, MessageConstant.GET_SETMEAL_LIST_FAIL);
        }
    }

    //通过id查询套餐的详情
    @RequestMapping("/findById")
    public Result findById(Integer id){
        try {
            SetMeal setMeal =  setMealService.findById(id);
            return new Result(true, MessageConstant.QUERY_SETMEAL_SUCCESS, setMeal);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false, MessageConstant.QUERY_SETMEAL_FAIL);
        }
    }





}
