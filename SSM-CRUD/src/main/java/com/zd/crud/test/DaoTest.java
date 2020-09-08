package com.zd.crud.test;

import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zd.crud.bean.Emp;
import com.zd.crud.dao.DeptMapper;
import com.zd.crud.dao.EmpMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class DaoTest {
	
	@Autowired
	private EmpMapper empMapper;
	
	@Autowired
	private SqlSession sqlsession;
	
	@Test
	public void test(){
		List<Emp>list=empMapper.selectByExampleWithDept(null);
		for (Emp emp : list) {
			System.out.println(emp.toString());
			System.out.println(emp.getDept());
		}
		//System.out.println(empMapper);
	}
	
	@Test
	public void add(){
		Emp emp=new Emp();
		emp.setEmpName("ÕÅºÆÈ»");
		emp.setEmail("zhr@qq.com");
		emp.setGender("ÄÐ");
		emp.setdId(2);
		empMapper.insert(emp);
	}
	@Test
	public void addAll(){
		EmpMapper empMapper2=sqlsession.getMapper(EmpMapper.class);
		for(int i=0;i<20;i++){
			String M="ÄÐ";
			String uuid=UUID.randomUUID().toString().substring(0,5);
			if(i/2==0){
				 M="Å®";
			}else{
				M="ÄÐ";
			}
			Emp emp=new Emp(null, uuid, M, uuid+"@qq.com", 1);
			empMapper2.insertSelective(emp);
		}
	}
}
