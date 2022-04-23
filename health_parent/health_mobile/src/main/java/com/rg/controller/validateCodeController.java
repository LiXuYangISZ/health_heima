package com.rg.controller;

import com.alibaba.druid.sql.dialect.oracle.ast.OracleDataTypeIntervalYear;
import com.rg.constant.MessageConstant;
import com.rg.constant.RedisMessageConstant;
import com.rg.entity.Result;
import com.rg.utils.MailUtils;
import com.rg.utils.ValidateCodeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import redis.clients.jedis.JedisPool;

/**
 * 验证码操作
 */
@RestController
@RequestMapping("/validateCode")
public class validateCodeController {
    @Autowired
    private JedisPool jedisPool;
    //用户在线体检预约发送验证码
    @RequestMapping("/send4Order")
    public Result send4Order(String email){
        //随机生成四位数字验证码
        Integer validateCode = ValidateCodeUtils.generateValidateCode(6);
        //给用户发送验证码
        String text = "您好 <font color=orange>"+email+"</font>"+"!<br/>" +
                "欢迎注册美年大健康,请将验证码填写到注册页面.<br/>" +
                "验证码:"+validateCode.toString();
        String title = "美年大健康 | 注册 美年大健康 邮箱验证";
        try {
            MailUtils.sendMail(email,text,title);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(true, MessageConstant.SEND_VALIDATECODE_FAIL);
        }
        //将验证码保存到redis五分钟
        jedisPool.getResource().setex(email + RedisMessageConstant.SENDTYPE_ORDER, 300, validateCode.toString());
        return new Result(true, MessageConstant.SEND_VALIDATECODE_SUCCESS);
    }

    //send4Login
    @RequestMapping("/send4Login")
    public Result send4Login(String email){
        //随机生成四位数字验证码
        Integer validateCode = ValidateCodeUtils.generateValidateCode(6);
        //给用户发送验证码
        String text = "您好 <font color=orange>"+email+"</font>"+"!<br/>" +
                "欢迎登录传智健康,请将验证码填写到登录页面.<br/>" +
                "验证码:"+validateCode.toString();
        String title = "传智健康 | 登录 传智健康 邮箱验证";
        try {
            MailUtils.sendMail(email,text,title);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(true, MessageConstant.SEND_VALIDATECODE_FAIL);
        }
        //将验证码保存到redis五分钟
        jedisPool.getResource().setex(email + RedisMessageConstant.SENDTYPE_LOGIN, 300, validateCode.toString());
        return new Result(true, MessageConstant.SEND_VALIDATECODE_SUCCESS);
    }
}
