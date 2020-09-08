package com.zd.crud.bean;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;

public class Emp {
    private Integer empId;
    /**
     * @Pattern自定义的校验规则
     */
    @Pattern(regexp="(^[A-Za-z0-9_-]{4,10}$)|(^[\\u2E80-\\u9FFF]{2,5})",message="用户名不规范！")
    private String empName;

    private String gender;
    /**
     * @Email jar303自带的校验邮箱规则
     */
    @Email(message="邮箱格式不规范！")
    private String email;

    private Integer dId;
    
    private Dept dept;
    
    
    public Emp() {
		super();
		// TODO Auto-generated constructor stub
	}
    
	public Emp(Integer empId, String empName, String gender, String email, Integer dId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
	}

	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	@Override
	public String toString() {
		return "Emp [empId=" + empId + ", empName=" + empName + ", gender=" + gender + ", email=" + email + ", dId="
				+ dId + "]";
	}
	
}