package com.rg.jobs;

import com.rg.constant.RedisConstant;
import com.rg.utils.QiniuUtils;
import org.springframework.beans.factory.annotation.Autowired;
import redis.clients.jedis.JedisPool;

import java.util.Set;

public class ClearImgJob {
    @Autowired
    private JedisPool jedisPool;

    public void clearImg(){
        //根据Redis中保存的两个set集合进行差值计算,获得垃圾图片名称集合
        Set <String> set = jedisPool.getResource().sdiff(RedisConstant.SETMEAL_PIC_RESOURCES, RedisConstant.SETMEAL_PIC_DB_RESOURCES);
        if(set!=null){
            for (String fileName : set) {
                //删除七牛云服务器上的图片
                QiniuUtils.deleteFileFromQiniu(fileName);
                //从redis集合中删除图片名称
                jedisPool.getResource().srem(RedisConstant.SETMEAL_PIC_RESOURCES, fileName);
                System.out.println("清理垃圾图片...");
            }
        }
    }
}