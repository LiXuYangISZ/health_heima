package com.rg.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.rg.constant.MessageConstant;
import com.rg.constant.RedisMessageConstant;
import com.rg.entity.Result;
import com.rg.pojo.Order;
import com.rg.service.OrderService;
import com.rg.utils.MailUtils;
import jdk.nashorn.internal.ir.CatchNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import redis.clients.jedis.JedisPool;

import java.util.Map;

/**
 * 体检预约的处理
 */
@RestController
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private JedisPool jedisPool;

    @Reference
    private OrderService orderService;
    @RequestMapping("/submit")
    public Result  submit(@RequestBody Map map) {

        String email = (String) map.get("email");
        //从redis中获取要保存的验证码
        String validateCodeInRedis = jedisPool.getResource().get(email + RedisMessageConstant.SENDTYPE_ORDER);
        String validateCode = (String) map.get("validateCode");
        //将用户输入的验证码和redis中保存的验证码进行比对
        if (validateCodeInRedis != null && validateCode != null && validateCode.equals(validateCodeInRedis)) {
            //如果比对成功,调用服务完成预约业务处理
            map.put("orderType", Order.ORDERTYPE_WEIXIN);//设置预约类型,分为微信预约,电话预约
            Result result = null;
            Map orderInfo = null;
            try {
                result = orderService.order(map);//加上try..catch放在预约失败.
                //预约成功,查询预约的详情,并在邮件中进行显示.
                orderInfo = orderService.findById((Integer) result.getData());
            } catch (Exception e) {
                e.printStackTrace();
                return new Result(false, MessageConstant.ORDERSETTING_FAIL);
            }
            if (result.isFlag()) {
                //预约成功,可以为用户发送邮件

                try {
                    String text = "您好 <font color=orange>" + email + "</font>!<br/>" +
                            "恭喜你使用美年大健康公众号预约成功!<br/>" +
                            "具体预约信息如下:<br/>"+
                            "体检人:"+(String) orderInfo.get("member")+"<br/>"+
                            "体检套餐:"+(String) orderInfo.get("setmeal")+"<br/>"+
                            "体检日期:"+(String) orderInfo.get("orderDate")+"<br/>"+
                            "预约类型:"+(String) orderInfo.get("orderType")+"<br/>"
                            ;
                    String title = "美年大健康 | 预约成功 邮箱提醒";
                    MailUtils.sendMail(email, text, title);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            return result;

        } else {
            //如果比对不成功,返回结果给页面
            return new Result(false, MessageConstant.VALIDATECODE_ERROR);
        }

    }

    //根据id查询预约信息
    @RequestMapping("/findById")
    public Result findById(Integer id){
        try {
            Map map = orderService.findById(id);  //当页面中的数据没有和pojo中的类对应时可以采用map.
            return new Result(true,MessageConstant.QUERY_ORDER_SUCCESS,map);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,MessageConstant.QUERY_ORDER_FAIL);
        }
    }
}
