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
import org.springframework.security.access.prepost.PreAuthorize;
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

    @RequestMapping("/upload")
    public Result upload(@RequestParam("imgFile")MultipartFile imgFile){
        System.out.println(imgFile);
        String originalFilename = imgFile.getOriginalFilename();//原始文件名
        String extention = originalFilename.substring(originalFilename.lastIndexOf("."));
        String fileName = UUID.randomUUID().toString()+extention;//XXX.jpg
        //将文件上传到七牛云服务器
        try {
            QiniuUtils.upload2Qiniu(imgFile.getBytes(),fileName);
            //将文件加入到redis的一个 图片上传集合中.
            jedisPool.getResource().sadd(RedisConstant.SETMEAL_PIC_RESOURCES,fileName);
        } catch (IOException e) {
            e.printStackTrace();
            return new Result(false, MessageConstant.PIC_UPLOAD_FAIL);
        }
        return new Result(true,MessageConstant.PIC_UPLOAD_SUCCESS,fileName);
    }

    //新增套餐
    @PreAuthorize("hasAuthority('SETMEAL_ADD')")
    @RequestMapping("/add")
    public Result add(@RequestBody SetMeal setMeal, Integer[] checkgroupIds){
        try {
            setMealService.add(setMeal,checkgroupIds);
            return new Result(true,MessageConstant.ADD_SETMEAL_SUCCESS);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,MessageConstant.ADD_SETMEAL_FAIL);
        }
    }

    //分页查询
    @PreAuthorize("hasAuthority('SETMEAL_QUERY')")
    @RequestMapping("/findPage")
    public PageResult findPage(@RequestBody QueryPageBean queryPageBean){
        return setMealService.findPage(queryPageBean);
    }

    @PreAuthorize("hasAuthority('SETMEAL_EDIT')")
    @RequestMapping("/findCheckGroupIdsBySetMealId")
    public Result findCheckGroupIdsBySetMealId(Integer id){
        try {
            System.out.println("123456");
            List<Integer> list = setMealService.findCheckGroupIdsBySetMealId(id);
            return new Result(true,MessageConstant.QUERY_SETMEAL_SUCCESS,list);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,MessageConstant.QUERY_SETMEAL_FAIL);
        }
    }

    //编辑套餐
    @PreAuthorize("hasAuthority('SETMEAL_EDIT')")
    @RequestMapping("/edit")
    public Result edit(@RequestBody SetMeal setMeal, Integer[] checkgroupIds){
        try {
            setMealService.edit(setMeal,checkgroupIds);
            return new Result(true,MessageConstant.EDIT_SETMEAL_SUCCESS);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,MessageConstant.EDIT_SETMEAL_FAIL);
        }
    }

    @RequestMapping("/deleteById")
    @PreAuthorize("hasAuthority('SETMEAL_DELETE')")
    public Result deleteById(Integer id){
        try {
            System.out.println(id);
            System.out.println("123456");
            setMealService.deleteById(id);
            return new Result(true,MessageConstant.DELETE_SETMEAL_SUCCESS);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,MessageConstant.DELETE_SETMEAL_FAIL);
        }

    }










}
