package com.zd.crud.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedCaseInsensitiveMap;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zd.crud.bean.Emp;
import com.zd.crud.bean.EmpExample;
import com.zd.crud.bean.EmpExample.Criteria;
import com.zd.crud.dao.EmpMapper;
import com.zd.crud.service.EmpService;

@Service("empService")
public class ImplEmpService implements EmpService {

	@Autowired
	private EmpMapper empMapper;
	
	@Autowired
	private SqlSession session;
	
	public List<Emp> findAll() {
		List<Emp>list=empMapper.selectByExampleWithDept(null);
		return list;
	}

	public PageInfo<Emp> findAllByPage(Integer pageNum,Integer pageSize) {
		PageHelper.startPage(pageNum,pageSize);
		List<Emp>list=empMapper.selectByExampleWithDept(null);
		PageInfo<Emp> info=new PageInfo<Emp>(list,5);
		return info;
	}


	public void addEmp(Emp emp) {
		empMapper.insertSelective(emp);
	}

	/**
	 * 通过姓名查找员工
	 */
	
	public boolean checkName(Emp emp) {
		EmpExample ex=new EmpExample();
		Criteria criteria = ex.createCriteria();
		criteria.andEmpNameEqualTo(emp.getEmpName());
		long count=empMapper.countByExample(ex);
		return count==0;
	}

	
	public Emp findEmp(Integer empId) {
		Emp emp=empMapper.selectByPrimaryKey(empId);
		return emp;
	}

	
	public void updateEmp(Emp emp) {
		empMapper.updateByPrimaryKeySelective(emp);
	}


	public void delEmp(Integer empId) {
		empMapper.deleteByPrimaryKey(empId);
	}


	public void delBatch(List<Integer> empIds) {
		EmpExample ex=new EmpExample();
		Criteria criteria = ex.createCriteria();
		criteria.andEmpIdIn(empIds);
		empMapper.deleteByExample(ex);
	}

}
