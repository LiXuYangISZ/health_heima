package com.rg.service;

import com.alibaba.dubbo.config.annotation.Service;
import com.rg.entity.Result;
import com.rg.mapper.MemberMapper;
import com.rg.pojo.Member;
import com.rg.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import javax.xml.crypto.Data;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
@Service(interfaceClass = MemberService.class)
@Transactional
public class MemberServiceImpl implements MemberService{

    @Autowired
    private MemberMapper memberMapper;

    @Override
    public Member findByEmail(String email) {
        return memberMapper.findByEmail(email);
    }

    //保存会员信息
    @Override
    public void add(Member member) {
        String password = member.getPassword();
        //由于这个add是一个通用方法,有时候可能携带密码,有时候可能不携带,但是携带的时候要注意进行加密.
        if(password!=null){
            //使用MD5将明文密码进行加密
            password = MD5Utils.md5(password);
            member.setPassword(password);
        }
        memberMapper.add(member);
    }

    //根据月份查询会员人数
    @Override
    public List <Integer> findMemberCountByMonth(List <String> months) {
        List <Integer> memberCount = new ArrayList <>();
        for (String month : months) {
            String date = month +".31";//2021.12.31
            Integer count = memberMapper.findMemberCountBeforeDate(date);
            memberCount.add(count);
        }
        return memberCount;
    }
}
