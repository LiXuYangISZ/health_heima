package com.rg.service;

import com.alibaba.dubbo.config.annotation.Service;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.rg.constant.RedisConstant;
import com.rg.entity.PageResult;
import com.rg.entity.QueryPageBean;
import com.rg.mapper.SetMealMapper;
import com.rg.pojo.SetMeal;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import redis.clients.jedis.JedisPool;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 预约服务类
 */
@Service(interfaceClass = SetMealService.class)
@Transactional
public class SetMealServiceImpl implements SetMealService{

    @Autowired
    private JedisPool jedisPool;

    @Autowired
    private SetMealMapper setMealMapper;

    @Autowired
    private FreeMarkerConfigurer freeMarkerConfigurer;

    @Value("F:/Code/Workspace_JavaEE/health_parent/health_mobile/src/main/webapp/pages")
    private String outPutPath;//从属性文件中读取要生成的html对应的目录

    @Override
    public void add(SetMeal setMeal, Integer[] checkgroupIds) {
        //新增套餐
        setMealMapper.add(setMeal);
        //将图片名称添加到redis结合
        jedisPool.getResource().sadd(RedisConstant.SETMEAL_PIC_DB_RESOURCES,setMeal.getImg());
        //设置套餐和检查组的多对多关联关系
        setCheckGroupAndMeal(setMeal,checkgroupIds);

        // //当添加套餐后需要重新生成的静态页面(套餐列表页面,套餐详情页面)
        generateMobileStaticHtml();


    }

    //生成当前页面所需的静态页面
    private void generateMobileStaticHtml() {
        //在生成静态页面之前需要查询数据
        List <SetMeal> list = setMealMapper.findAllSetMeal();

        //需要生成套餐列表静态页面
        generateMobileSetMealListHtml(list);
        //需要生成套餐详情的静态页面
        generateMobileSetMealDetailHtml(list);
    }

    //需要生成套餐列表静态页面
    public void generateMobileSetMealListHtml(List<SetMeal> list){
        Map <Object, Object> map = new HashMap <>();
        //为末班提供数据,用于提供静态页面
        map.put("setmealList",list);
        generateHtml("mobile_setmeal.ftl","m_setmeal.html",map);
    }

    //需要生成套餐详情的静态页面
    public void generateMobileSetMealDetailHtml(List<SetMeal> list){
        for (SetMeal setMeal : list) {
            Map <Object, Object> map = new HashMap <>();
            map.put("setmeal",setMealMapper.findById(setMeal.getId()));
            generateHtml("mobile_setmeal_detail.ftl", "setmeal_detail_" + setMeal.getId() + ".html", map);
        }
    }



    //通用的方法,用于生成静态页面
    public void generateHtml(String templateName,String htmlPageName,Map map){
        Configuration configuration = freeMarkerConfigurer.getConfiguration();//获得配置对象
        FileWriter out = null;
        try {
            Template template = configuration.getTemplate(templateName);
            //构造输出流
            out = new FileWriter(new File(outPutPath + "/" + htmlPageName));
            //输出文件
            template.process(map,out);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //分页查询
    @Override
    public PageResult findPage(QueryPageBean queryPageBean) {
        Integer currentPage = queryPageBean.getCurrentPage();
        Integer pageSize = queryPageBean.getPageSize();
        String queryString = queryPageBean.getQueryString();
        if(queryString!=null && queryString.length()>0){
            currentPage = 1;
        }
        PageHelper.startPage(currentPage,pageSize);
        Page<SetMeal> page =  setMealMapper.findByCondition(queryString);
        return new PageResult(page.getTotal(),page.getResult());
    }

    //查询用户组id通过setMeal_id
    @Override
    public List <Integer> findCheckGroupIdsBySetMealId(Integer id) {
        return setMealMapper.findCheckGroupIdsBySetMealId(id);
    }

    //编辑套餐
    @Override
    public void edit(SetMeal setMeal, Integer[] checkgroupIds) {
        setMealMapper.edit(setMeal);
        //将图片名称添加到redis结合
        jedisPool.getResource().sadd(RedisConstant.SETMEAL_PIC_DB_RESOURCES,setMeal.getImg());
        //清空之前套餐和检查组的关联
        setMealMapper.deleteAssociation(setMeal.getId());
        //设置套餐和检查组的多对多关联
        setCheckGroupAndMeal(setMeal,checkgroupIds);

        //当添加套餐后需要重新生成的静态页面(套餐列表页面,套餐详情页面)
        generateMobileStaticHtml();

    }

    //查询所有套餐数据
    @Override
    public List <SetMeal> findAllSetMeal() {
        return setMealMapper.findAllSetMeal();
    }

    //根据ID删除套餐
    @Override
    public void deleteById(Integer id) {

        //删除t_setmeal_checkgroup中的关系   //这两条删除语句也要有先后顺序哦,因为 t_setMeal中有外键约束对于表:t_setmeal_checkgroup
        setMealMapper.deleteAssociation(id);
        //删除setMeal中对应的套餐项
        setMealMapper.deleteSetMeal(id);

        //当添加套餐后需要重新生成的静态页面(套餐列表页面,套餐详情页面)
        generateMobileStaticHtml();


    }

    //根据id查询套餐的详情
    @Override
    public SetMeal findById(Integer id) {

        return setMealMapper.findById(id);
    }

    @Override
    public List <Map <String, Object>> findSetMealCount() {

        return setMealMapper.findSetMealCount();
    }

    private void setCheckGroupAndMeal(SetMeal setMeal, Integer[] checkgroupIds) {
        if(checkgroupIds!=null&&checkgroupIds.length>0){
            for (Integer checkgroupId : checkgroupIds) {
                Map <String, Integer> map = new HashMap <>();
                //setmeal_id  checkgroup_id
                map.put("setmeal_id",setMeal.getId());
                map.put("checkgroup_id",checkgroupId);
                setMealMapper.AddChekcGroupAndSetMeal(map);
            }
        }
    }
}
