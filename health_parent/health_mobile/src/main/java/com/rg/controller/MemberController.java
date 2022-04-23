package com.rg.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.alibaba.fastjson.JSON;
import com.rg.constant.MessageConstant;
import com.rg.constant.RedisMessageConstant;
import com.rg.entity.Result;
import com.rg.pojo.Member;
import com.rg.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import redis.clients.jedis.JedisPool;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.Map;

@RestController
@RequestMapping("/member")
public class MemberController {

    @Reference
    private MemberService memberService;

    @Autowired
    private JedisPool jedisPool;

    @RequestMapping("/login")
    public Result login(HttpServletResponse response, @RequestBody Map map){

        String email = (String) map.get("email");
        String validateCode = (String) map.get("validateCode");
        //从Redis中获取保存的验证码
        String validateCodeInRedis = jedisPool.getResource().get(email + RedisMessageConstant.SENDTYPE_LOGIN);
        //验证验证码
        if(validateCodeInRedis!=null && validateCode!=null && validateCode.equals(validateCodeInRedis)){
            //验证码输入正确.进行登录
            Member member = memberService.findByEmail(email);
            if(member==null){
                //不是会员,自动完成注册(自动将当前用户信息保存到会员表)
                member.setRegTime(new Date());
                member.setEmail(email);
                memberService.add(member);
            }
            //想客户端浏览器写入Cookie,内容为手机号 ???很蒙圈...
            Cookie cookie = new Cookie("login_member_email", email);
            cookie.setPath("/");
            cookie.setMaxAge(60*60*24*30);
            response.addCookie(cookie);
            //保存会员信息到Redis中,因为之后可能需要用..
            String json = JSON.toJSON(member).toString();
            jedisPool.getResource().setex(email, 60 * 30, json);
            return new Result(true, MessageConstant.LOGIN_SUCCESS);

        }else {
            //验证码输入粗欧文
            return new Result(false, MessageConstant.VALIDATECODE_ERROR);
        }

    }

}
