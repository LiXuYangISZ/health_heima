package com.rg.service;

import com.alibaba.dubbo.config.annotation.Service;
import com.rg.mapper.MemberMapper;
import com.rg.mapper.OrderMapper;
import com.rg.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service(interfaceClass = ReportService.class)
@Transactional
public class ReportServiceImpl implements ReportService{
    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private OrderMapper orderMapper;
    @Override
    public Map <String, Object> getBusinessReportData() throws Exception{
        Map <String, Object> map = new HashMap <>();

        //今日
        String today = DateUtils.parseDate2String(DateUtils.getToday());
        //本周第一天
        String monday = DateUtils.parseDate2String(DateUtils.getThisWeekMonday());
        //获得本月第一天
        String  firstDay4ThisMonth = DateUtils.parseDate2String(DateUtils.getFirstDay4ThisMonth());

        //本日新增会员数
        Integer todayNewMember = memberMapper.findMemberCountAfterDate(today);
        //总会员数
        Integer totalMember = memberMapper.findMemberTotalCount();
        //本周会员数
        Integer thisWeekNewMember = memberMapper.findMemberCountAfterDate(monday);
        //本月会员数
        Integer thisMonthNewMember = memberMapper.findMemberCountAfterDate(firstDay4ThisMonth);

        //进入预约数
        Integer todayOrderNumber = orderMapper.findOrderCountByDate(today);
        //今日到访数
        Integer todayVisitsNumber = orderMapper.findVisitsCountByDate(today);

        //本周预约数
        Integer thisWeekOrderNumber = orderMapper.findOrderCountAfterDate(monday);
        //本周到访数
        Integer thisWeekVisitsNumber = orderMapper.findVisitsCountAfterDate(monday);

        //本月预约数
        Integer thisMonthOrderNumber = orderMapper.findOrderCountAfterDate(firstDay4ThisMonth);

        //本月到访数
        Integer thisMonthVisitsNumber = orderMapper.findVisitsCountAfterDate(firstDay4ThisMonth);

        List <Map> hotSetmeal = orderMapper.findHotSetmeal();

        map.put("reportDate",today);
        map.put("todayNewMember",todayNewMember);
        map.put("totalMember",totalMember);
        map.put("thisWeekNewMember",thisWeekNewMember);
        map.put("thisMonthNewMember",thisMonthNewMember);
        map.put("todayOrderNumber",todayOrderNumber);
        map.put("todayVisitsNumber",todayVisitsNumber);
        map.put("thisWeekOrderNumber",thisWeekOrderNumber);
        map.put("thisWeekVisitsNumber",thisWeekVisitsNumber);
        map.put("thisMonthOrderNumber",thisMonthOrderNumber);
        map.put("thisMonthVisitsNumber",thisMonthVisitsNumber);
        map.put("hotSetmeal",hotSetmeal);

        return map;
    }
}
