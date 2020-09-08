package com.zd.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.DefaultMockMvcBuilder;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.zd.crud.bean.Emp;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","classpath:springMVC.xml"})
public class TestWeb {
	//传入spring的ioc容器
	@Autowired
	WebApplicationContext context;
	//虚拟mvc请求，获取到处理的结果
	MockMvc mvc;
	
	//每次使用都要初始化
	@Before
	public void initMockMvc(){
		mvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception{
		MvcResult result = mvc.perform(MockMvcRequestBuilders.get("/emps")).andReturn();
		//请求成功后，获取请求域中的pageInfo对象
		MockHttpServletRequest request = result.getRequest();
		PageInfo< Emp>info=(PageInfo<Emp>) request.getAttribute("info");
		List<Emp>list=info.getList();
		for (Emp emp : list) {
			System.out.println(emp.toString()+emp.getDept().toString());
		}
	}
}
