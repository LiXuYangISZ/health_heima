package com.rg.mapper;

import com.rg.pojo.OrderSetting;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface OrderSettingMapper {
    void add(OrderSetting orderSetting);

    long findCountByOrderDate(Date orderDate);

    void editNumberByOrderDate(OrderSetting orderSetting);

    List<OrderSetting> getOrderSettingByMonth(Map<String, String> map);

    //更新已预约人数
    public void editReservationsByOrderDate(OrderSetting orderSetting);

    //根据预约日期查询预约设置信息
    public OrderSetting findByOrderDate(Date orderDate);
}
