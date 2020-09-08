package com.zd.crud.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zd.crud.bean.Emp;
import com.zd.crud.bean.EmpExample;
import com.zd.crud.bean.EmpExample.Criteria;
import com.zd.crud.bean.PageMes;
import com.zd.crud.service.EmpService;

@Controller
public class EmpController {

	@Resource(name = "empService")
	private EmpService empService;

	// @RequestMapping("emps")
	public String findAll(Map<String, Object> map) {
		List<Emp> list = empService.findAll();
		map.put("list", list);
		return "emp/list";
	}

	/**
	 * 后台数据库校验表单姓名数据
	 * 
	 * @param emp
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/check")
	@ResponseBody
	public PageMes checkName(Emp emp) throws IOException {
		String name = new String(emp.getEmpName().getBytes("ISO-8859-1"), "utf-8");
		emp.setEmpName(name);
		String testname = "(^[A-Za-z0-9_-]{4,10}$)|(^[\u2E80-\u9FFF]{2,5})";
		if (!name.matches(testname)) {
			return PageMes.failed().add("check_mes", "用户名规格错误！");
		}
		boolean flag = empService.checkName(emp);
		if (flag) {
			PageMes mes = PageMes.success().add("check_mes", "用户名可用！");
			return mes;
		} else {
			PageMes mes = PageMes.failed().add("check_mes", "用户名已使用！");
			return mes;
		}
	}

	/**
	 * 跳转到显示员工数据的页面
	 * 
	 * @return
	 */
	@RequestMapping("/toList")
	public String toList() {
		return "emp/listAjax";
	}

	/**
	 * ajax异步方式获取到查询到的数据以json格式响应给页面
	 * 
	 * @return 需要jackson依赖包
	 */
	@RequestMapping(value = "/emps", method = RequestMethod.GET)
	@ResponseBody
	public PageMes ajaxWithPage(@RequestParam(name = "pageNum", defaultValue = "1", required = false) Integer pageNum,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Emp> list = empService.findAll();
		PageInfo<Emp> info = new PageInfo<Emp>(list, 5);
		PageMes mes = PageMes.success().add("info", info);
		return mes;
	}

	/**
	 * 添加员工
	 * 
	 * @return 用户可以通过非法的方式绕过前端校验，因此我们可以在保存的时候进行后端检验 。 后端校验用到jsr303，我们需要导入依赖。
	 * @Valid 对传过来的数据开启后端校验。 BindingResult 获取校验的结果
	 */
	@RequestMapping(value = "/emps", method = RequestMethod.POST)
	@ResponseBody
	public PageMes addEmp(@Valid Emp emp, BindingResult result) {
		if (result.hasErrors()) {
			// 获取所有的校验错误信息
			PageMes mes = PageMes.failed();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				mes.add(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return mes;
		} else {
			empService.addEmp(emp);
			PageMes mes = PageMes.success();
			return mes;
		}
	}

	/**
	 * 通过id获取到员工的信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/emps/{empId}", method = RequestMethod.GET)
	@ResponseBody
	public PageMes findEmp(@PathVariable("empId") Integer empId) {
		Emp emp = empService.findEmp(empId);
		PageMes mes = PageMes.success().add("emp", emp);
		return mes;
	}

	/**
	 * 更新员工
	 * 
	 * @param emp
	 * @param result
	 * @return 如果客户端ajax发送put请求，服务器端接收不到请求。
	 *         原因在于tomcat服务器只能将post请求中的请求体中的数据封装成map，
	 *         request是从map中获取数据，而tomcat对put请求中请求体中的数据不进行封装, 解决方法：
	 *         加入过滤器：HttpPutFormContentFilter。
	 *         springMVC，帮我们将put请求中的数据封装成map，然后包装了request请求,
	 *         修改了getParameter方法，让我们可以取到我们封装的map中的数据
	 */
	@RequestMapping(value = "/emps/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public PageMes updateEmp(@Valid Emp emp, BindingResult result) {
		// 如果有错误信息
		if (result.hasErrors()) {
			// 获取校验邮箱的错误信息
			PageMes mes = PageMes.failed();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				mes.add(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return mes;
		} else {
			empService.updateEmp(emp);
			return PageMes.success();
		}
	}

	/**
	 * 删除员工和批量删除员工
	 * 
	 * @param empId
	 * @return
	 */
	@RequestMapping(value = "/emps/{ids}", method = RequestMethod.DELETE)
	@ResponseBody
	public PageMes delEmp(@PathVariable("ids") String ids) {
		if (ids.contains("-")) {
			List<Integer>empIds=new ArrayList<Integer>();
			String[] a=ids.split("-");
			for (String string : a) {
				empIds.add(Integer.parseInt(string));
			}
			empService.delBatch(empIds);
			return PageMes.success();
		} else {
			Integer empId=Integer.parseInt(ids);
			empService.delEmp(empId);
			PageMes mes = PageMes.success();
			return mes;
		}
	}

	/**
	 * 原始的同步的数据查询并分页
	 * 
	 * @param pageNum
	 * @param pageSize
	 * @param map
	 * @return
	 */
	// @RequestMapping("emps")
	public String findAllByPage(@RequestParam(name = "pageNum", defaultValue = "1", required = false) Integer pageNum,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) Integer pageSize,
			Map<String, Object> map) {
		PageHelper.startPage(pageNum, pageSize);
		List<Emp> list = empService.findAll();
		PageInfo<Emp> info = new PageInfo<Emp>(list, 5);
		map.put("info", info);
		return "emp/list";
	}
}
