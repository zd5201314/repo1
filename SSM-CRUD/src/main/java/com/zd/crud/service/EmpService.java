package com.zd.crud.service;

import java.util.List;

import com.github.pagehelper.PageInfo;
import com.zd.crud.bean.Emp;

public interface EmpService {
	
	public List<Emp>findAll();
	
	public PageInfo<Emp> findAllByPage(Integer PageNum,Integer pageSize);
	
	public void addEmp(Emp emp);
	
	public boolean checkName(Emp emp);
	
	public Emp findEmp(Integer empId);
	
	public void updateEmp(Emp emp);
	
	public void delEmp(Integer empId);
	
	public void delBatch(List<Integer>empIds);
}
