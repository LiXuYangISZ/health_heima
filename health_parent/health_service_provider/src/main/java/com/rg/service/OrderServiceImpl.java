package com.rg.service;

import com.alibaba.dubbo.config.annotation.Service;
import com.rg.constant.MessageConstant;
import com.rg.entity.Result;
import com.rg.mapper.MemberMapper;
import com.rg.mapper.OrderMapper;
import com.rg.mapper.OrderSettingMapper;
import com.rg.pojo.Member;
import com.rg.pojo.Order;
import com.rg.pojo.OrderSetting;
import com.rg.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 预约服务类(用户使用的)
 */
@Service(interfaceClass = OrderService.class)
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderSettingMapper orderSettingMapper;

    @Autowired
    private MemberMapper memberMapper;
    @Override
    public Result order(Map map) throws Exception {
        /**

         * 5、预约成功，更新当日的已预约人数
         */
        //1、检查用户所选择的预约日期是否已经提前进行了预约设置，如果没有设置则无法进行预约
        String orderDate = (String) map.get("orderDate");

         //获取当天的预约情况.
        OrderSetting orderSetting = orderSettingMapper.findByOrderDate(DateUtils.parseString2Date(orderDate));

        if(orderSetting==null){
            //指定日期没有进行预约设置,无法完成体检预约
            return new Result(false, MessageConstant.SELECTED_DATE_CANNOT_ORDER);
        }

        //2、检查用户所选择的预约日期是否已经约满，如果已经约满则无法预约
        int number = orderSetting.getNumber();
        int reservations = orderSetting.getReservations();
        if(reservations>=number){
            //已经约满,无法预约
            return new Result(false,MessageConstant.ORDER_FULL);
        }

        //3、检查用户是否重复预约（同一个用户在同一天预约了同一个套餐），如果是重复预约则无法完成再次预约
        String email = (String) map.get("email");//获取用户页面的手机号
        Member member = memberMapper.findByEmail(email);//从会员表中查询该用户的信息(只要预约过就会被插入一条该记录.)
        if(member!=null){
            //判断是否在重复预约
            Integer memberId = member.getId();//会员ID
            Date order_Date= DateUtils.parseString2Date(orderDate);//预约日期
            String setmealId = (String) map.get("setmealId");//套餐ID
            Order order = new Order(memberId, order_Date, Integer.parseInt(setmealId));
            //根据条件进行查询
            List <Order> list = orderMapper.findByCondition(order);
            if(list!=null&&list.size()>0){
                //说明用户在重复预约,无法完成再次预约
                return new Result(false, MessageConstant.HAS_ORDERED);
            }
        }else {
            //4、检查当前用户是否为会员，如果是会员则进行(上述是否重复预约判断后)完成预约，如果不是会员则自动完成注册并进行预约
            member = new Member();
            member.setName((String) map.get("name"));
            member.setEmail(email);
            member.setIdCard((String) map.get("idCard"));
            member.setSex((String) map.get("sex"));
            member.setRegTime(new Date());
            memberMapper.add(member);//自动完成会员注册
        }
        //5、进行预约，更新当日的已预约人数,告诉用户预约成功!
        Order order = new Order();
        order.setMemberId(member.getId());
        order.setOrderDate(DateUtils.parseString2Date(orderDate));//预约日期
        order.setOrderType((String) map.get("orderType"));
        order.setOrderStatus(Order.ORDERSTATUS_NO);//到诊状态
        order.setSetmealId(Integer.parseInt((String) map.get("setmealId")) );
        orderMapper.add(order);
        orderSetting.setReservations(orderSetting.getReservations()+1);//约约人数加1
        orderSettingMapper.editReservationsByOrderDate(orderSetting);

        return new Result(true,MessageConstant.ORDER_SUCCESS,order.getId());
    }

    @Override
    public Map findById(Integer id) throws Exception {
        Map map = orderMapper.findById4Detail(id);
        if(map!=null){
            //处理日期格式
            Date orderDate = (Date) map.get("orderDate");
            map.put("orderDate", DateUtils.parseDate2String(orderDate));
        }
        return map;
    }
}
