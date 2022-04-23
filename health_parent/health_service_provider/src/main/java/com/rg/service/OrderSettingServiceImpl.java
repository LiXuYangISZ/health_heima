package com.rg.service;

import com.alibaba.dubbo.config.annotation.Service;
import com.rg.mapper.OrderSettingMapper;
import com.rg.pojo.OrderSetting;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 体检预约设置服务类(后台人员使用的)
 */
@Service(interfaceClass = OrderSettingService.class)
@Transactional
public class OrderSettingServiceImpl implements OrderSettingService {

    @Autowired
    private OrderSettingMapper orderSettingMapper;

    @Override
    public void add(List <OrderSetting> data) {
        if (data != null && data.size() > 0) {

            for (OrderSetting orderSetting : data) {
                //判断当前日期是否已经进行了预约设置
                long count = orderSettingMapper.findCountByOrderDate(orderSetting.getOrderDate());
                if (count > 0) {
                    //已经进行了预约设置,执行更新操作
                    orderSettingMapper.editNumberByOrderDate(orderSetting);
                } else {
                    //没有进行预约设置,进行插入操作
                    orderSettingMapper.add(orderSetting);
                }

            }
        }

    }

    @Override
    public List <Map> getOrderSettingByMonth(String date) {
        String begin = date + "-1";
        String end = date + "-31";
        Map <String, String> map = new HashMap <>();
        map.put("begin",begin);
        map.put("end",end);
        //调用DAO,根据日期范围查询预约设置数据
        List<OrderSetting> list =  orderSettingMapper.getOrderSettingByMonth(map);
        List <Map> result = new ArrayList <>();
        if(list!=null && list.size() > 0){
            for (OrderSetting orderSetting : list) {
                //页面需要啥数据,我们构造啥数据
                Map <String, Object> m = new HashMap <>();
                m.put("date",orderSetting.getOrderDate().getDate());//获取日期数字--几号
                m.put("number",orderSetting.getNumber());
                m.put("reservations",orderSetting.getReservations());
                result.add(m);
            }
        }
        return result;
    }

    @Override
    public void editNumberByDate(OrderSetting orderSetting) {
        long count = orderSettingMapper.findCountByOrderDate(orderSetting.getOrderDate());
        if(count>0){
            orderSettingMapper.editNumberByOrderDate(orderSetting);
        }else{
            orderSettingMapper.add(orderSetting);
        }

    }
}
