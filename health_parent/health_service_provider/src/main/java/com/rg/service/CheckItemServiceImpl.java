package com.rg.service;

import com.alibaba.dubbo.config.annotation.Service;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.rg.entity.PageResult;
import com.rg.entity.QueryPageBean;
import com.rg.mapper.CheckItemMapper;
import com.rg.pojo.CheckItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 检查项服务
 */
@Service(interfaceClass = CheckItemService.class)//对外暴露服务,并指明是那个的实现类
@Transactional //开启事务
public class CheckItemServiceImpl implements CheckItemService{

    @Autowired
    private CheckItemMapper checkItemMapper;
    //新增.
    @Override
    public void add(CheckItem checkItem) {
        checkItemMapper.add(checkItem);
    }

    //分页查询
    @Override
    public PageResult pageQuery(QueryPageBean queryPageBean) {
        Integer currentPage = queryPageBean.getCurrentPage();//当前页
        Integer pageSize = queryPageBean.getPageSize();//每页显示的条数
        String queryString = queryPageBean.getQueryString();//查询条件

        //解决一个小bug:当在当前页搜索非当前页的内容时,出现查找不到的情况..
        //解决办法:如果搜索的由内容时,则从第一个开始进行搜索..
        if(queryString!=null&&queryString.trim().length()!=0){//
            currentPage = 1;
        }

        // if(queryString!=null&&queryString.trim()!=""){//这样不可以,为什么呢??
        //     currentPage = 1;
        // }

        //完成分页查询,基于Mybatis框架提供的分页助手插件完成
        PageHelper.startPage(currentPage,pageSize); //底层基于ThreadLocal,最后会形成limt语句,追加到sql后面
        Page <CheckItem> page = checkItemMapper.selectByCondition(queryString);
        long total = page.getTotal();
        List <CheckItem> rows = page.getResult();
        return new PageResult(total,rows);
    }

    //删除检查项
    @Override
    public void deleteById(Integer id) {
        //查询当前检查项是否和检查组关联
        Integer count = checkItemMapper.findCountByCheckItemId(id);
        if (count>0){
            //当前项被引用,不能删除
            throw new RuntimeException("当前项被引用,不能删除");//抛出异常,controller返回操作失败..
        }
        checkItemMapper.deleteById(id);

    }

    //根据id查询checkItem
    @Override
    public CheckItem findById(Integer id) {
        CheckItem checkItem = checkItemMapper.findById(id);
        return checkItem;
    }

    //编辑检查项
    @Override
    public void edit(CheckItem checkItem) {
        checkItemMapper.edit(checkItem);
    }

    @Override
    public List <CheckItem> findAll() {
        return checkItemMapper.findAll();
    }
}
