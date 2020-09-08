package com.zd.crud.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zd.crud.bean.Dept;
import com.zd.crud.dao.DeptMapper;
import com.zd.crud.service.DeptService;

@Service("deptService")
public class ImplDeptService implements DeptService {
	
	@Autowired
	private DeptMapper deptMapper;
	

	public List<Dept> findAll() {
		List<Dept>list=deptMapper.selectByExample(null);
		return list;
	}

}
