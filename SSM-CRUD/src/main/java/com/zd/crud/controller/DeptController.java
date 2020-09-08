package com.zd.crud.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zd.crud.bean.Dept;
import com.zd.crud.bean.PageMes;
import com.zd.crud.service.DeptService;

@Controller
public class DeptController {
	
	@Resource(name="deptService")
	private DeptService deptService;
	
	@RequestMapping("/dept")
	@ResponseBody
	public PageMes findAllDept(){
		List<Dept>list=deptService.findAll();
		PageMes mes=PageMes.success().add("list", list);
		return mes;
	}
}
