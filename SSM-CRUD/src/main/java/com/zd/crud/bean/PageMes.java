package com.zd.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @author zd
 *封装了页面的显示信息
 */
public class PageMes {
	//状态码，执行程序的状态码，100-成功，200-失败
	private int code;
	//存放提示信息
	private String mes;
	//存放需要响应到客户端的数据
	private Map<String, Object>map=new HashMap<String,Object>();
	
	public static PageMes success(){
		PageMes mes=new PageMes();
		mes.setCode(100);
		mes.setMes("操作成功！");
		return mes;
	}
	
	public static PageMes failed(){
		PageMes mes=new PageMes();
		mes.setCode(200);
		mes.setMes("操作失败！");
		return mes;
	}
	//链接存放数据
	public PageMes add(String key,Object value){
		this.getMap().put(key, value);
		return this;
	}
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMes() {
		return mes;
	}
	public void setMes(String mes) {
		this.mes = mes;
	}
	public Map<String, Object> getMap() {
		return map;
	}
	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	
}
