package com.rg.service;


import com.rg.pojo.Member;

import java.util.List;

public interface MemberService {

    Member findByEmail(String email);

    void add(Member member);

    List<Integer> findMemberCountByMonth(List<String> months);
}
