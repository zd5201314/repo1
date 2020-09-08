<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表界面</title>

<script
	src="${pageContext.request.contextPath }/static/js/jquery-1.11.0.min.js"></script>
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/bootstrap/css/bootstrap.min.css">
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script
	src="${pageContext.request.contextPath }/static/bootstrap/js/bootstrap.min.js"></script>

</head>
<body>
<!-- ================================= -->
	<!-- 添加的模态框 -->
	<div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加员工</h4>
				</div>
				<!--  添加的模块 -->
				<div class="modal-body">
					<!-- 写入表单 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">姓名：</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="empName" name="empName"
									placeholder="Name" >
								<span id="helpBlock2" class="help-block">
									<!-- 动态的添加错误信息 -->
								</span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">邮箱：</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="email" name="email"
									placeholder="Email">
								<span id="helpBlock2" class="help-block">
									<!-- 动态的添加错误信息 -->
								</span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">性别：</label>
							<label class="radio-inline">
  								<input type="radio" name="gender" id="gender" value="男" checked="checked"> 男
							</label>
							<label class="radio-inline">
  								<input type="radio" name="gender" id="gender2" value="女"> 女
							</label>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">部门：</label>
							<div class="col-sm-3">
							<select class="form-control" name="dId" id="dept">
  								<option value="">--请选择--</option>
							</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="addEmp">保存</button>
				</div>
			</div>
		</div>
	</div>
<!-- 	==================================== -->
	<!-- ================================= -->
	<!-- 修改员工的模态框 -->
	<div class="modal fade" id="updateEmpModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">编译信息</h4>
				</div>
				<!--  修改的模块 -->
				<div class="modal-body">
					<!-- 写入表单 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">姓名：</label>
							<div class="col-sm-10">
								<input type="hidden"  name="empName" id="update_empName">
								<input type="hidden" name="_method" value="PUT">
								
								  <p class="form-control-static" id="update_name"></p>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">邮箱：</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="update_email" name="email"
									placeholder="Email">
								<span id="helpBlock2" class="help-block">
									<!-- 动态的添加错误信息 -->
								</span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">性别：</label>
							<label class="radio-inline">
  								<input type="radio" name="gender" id="update_gender" value="男" checked="checked"> 男
							</label>
							<label class="radio-inline">
  								<input type="radio" name="gender" id="update_gender2" value="女"> 女
							</label>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">部门：</label>
							<div class="col-sm-3">
							<select class="form-control" name="dId" id="updatedept">
  								<option value="">--请选择--</option>
							</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateEmp">更新</button>
				</div>
			</div>
		</div>
	</div>
<!-- 	==================================== -->

	<!-- 主程序页面 -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-success" onclick="toAddEmpUI()">添加</button>
				<button class="btn btn-danger" id="del_Emps">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="table">
					<thead>
						<th><input type="checkbox" id="checkAll"></th>
						<th>员工编号</th>
						<th>员工姓名</th>
						<th>员工性别</th>
						<th>员工邮箱</th>
						<th>员工所属部门</th>
						<th>操作</th>
					</thead>
					<tbody>
						<!-- ajax动态显示数据 -->
					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页的信息 -->
		<div class="row">
			<div class="col-md-6" id="page_info">
				<!-- 动态显示分页的信息 -->
			</div>
			<!-- 显示分页条 -->
			<div class="col-md-6" id="page_nav">
				<!-- 动态的显示分页条 -->
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	//全局变量，存储当前的最大记录数
	var totalSize;
	//全局变量，存储当前的页数
	var Num;
	$(function() {
		toPage(1);
	});
	//分页跳转
	function toPage(pageNum) {
		//把当前页穿传进去
		Num=pageNum;
		$.ajax({
			url : "${pageContext.request.contextPath }/emps",
			data : "pageNum=" + pageNum,
			type : "GET",
			success : function(data) {
				//显示员工数据到表格中
				empsToTable(data);
				//显示分页信息
				page_info(data);
				//显示分页条
				page_nav(data);
			}
		});
	}
	//显示员工数据函数
	function empsToTable(data) {
		//清空表格数据
		$("#table tbody").empty();
		//获取员工的数据
		var emps = data.map.info.list;

		$.each(emps,function(index, emp) {
							var checkBox=$("<td><input type='checkbox' class='onecheck'></td>")
							var empId = $("<td></td>").append(emp.empId);
							var empName = $("<td></td>").append(emp.empName);
							var gender = $("<td></td>").append(emp.gender);
							var email = $("<td></td>").append(emp.email);
							var deptName = $("<td></td>").append(
									emp.dept!=null?emp.dept.deptName:null);
							var editBtn = $("<button></button>")
									.addClass("btn btn-primary btn-sm editBtn")
									.append(
											"<span class='glyphicon glyphicon-pencil' aria-hidden='true'></span>")
									.append("编译");
							//为编译按钮设置一个属性，用来存储当前员工的id
							editBtn.attr("edit_id",emp.empId);
							var delBtn = $("<button></button>")
									.addClass("btn btn-danger btn-sm delBtn")
									.append(
											"<span class='glyphicon glyphicon-trash' aria-hidden='true'></span>")
									.append("删除");
							/***/
							delBtn.attr("del_id",emp.empId);
							
							var td = $("<td></td>").append(editBtn).append(" ")
									.append(delBtn);
							var tr = $("<tr></tr>").append(checkBox).append(empId).append(
									empName).append(gender).append(email)
									.append(deptName).append(td);
							$("#table tbody").append(tr);
						});
	}
	//显示分页信息
	function page_info(data) {
		$("#page_info").empty();
		var info = data.map.info;
		$("#page_info").append(
				"当前是第" + info.pageNum + "页，总共有" + info.pages + "页，共"
						+ info.total + "条记录。");
		totalSize=info.total;
	}
	//显示分页条
	function page_nav(data) {
		$("#page_nav").empty();
		var info = data.map.info;
		//首页
		var firstPage = $("<li></li>").append(
				$("<a aria-label='Previous'></a>").attr("href", "#").append(
						$("<span aria-hidden='true'></span>").append("首页")));
		firstPage.click(function() {
			toPage(1);
		});
		//上一页
		var prePage = $("<li></li>").append(
				$("<a aria-label='Previous'></a>").attr("href", "#")
						.append(
								$("<span aria-hidden='true'></span>").append(
										"&laquo;")));
		prePage.click(function() {
			toPage(info.prePage);
		});
		if (info.isFirstPage) {
			firstPage = $("<li></li>").append(
					$("<span aria-hidden='true'></span>").append("首页"))
					.addClass("disabled");
			prePage = $("<li></li>").append(
					$("<span aria-hidden='true'></span>").append("&laquo;"))
					.addClass("disabled");
		}
		//下一页
		var nextPage = $("<li></li>").append(
				$("<a aria-label='Next'></a>").attr("href", "#")
						.append(
								$("<span aria-hidden='true'></span>").append(
										"&raquo;")));
		nextPage.click(function() {
			toPage(info.nextPage);
		});
		//尾页
		var lastPage = $("<li></li>").append(
				$("<a aria-label='Next'></a>").attr("href", "#").append(
						$("<span aria-hidden='true'></span>").append("尾页")));
		lastPage.click(function() {
			toPage(info.pages);
		});
		if (info.isLastPage) {
			nextPage = $("<li></li>").append(
					$("<span aria-hidden='true'></span>").append("&raquo;"))
					.addClass("disabled");
			lastPage = $("<li></li>").append(
					$("<span aria-hidden='true'></span>").append("尾页"))
							.addClass("disabled");
		}
		//ul标签
		var ul = $("<ul></ul>").addClass("pagination");
		ul.append(firstPage).append(prePage);
		$.each(info.navigatepageNums, function(index, i) {
			var li = $("<li></li>").append(
					$("<a></a>").attr("href", "#").append(i));
			if (info.pageNum == i) {
				li.addClass("active");
			}
			if (info.pageNum != i) {
				//点击跳转指定页码
				li.click(function() {
					toPage(i);
				});
			}
			ul.append(li);
		});
		ul.append(nextPage).append(lastPage);
		//nav标签
		var nav = $("<nav aria-label='Page navigation'></nav>");
		nav.append(ul);
		$("#page_nav").append(nav);
	}
	
	//重置表单
	function resetForm(elm){
		$(elm)[0].reset();
		$(elm).find("*").removeClass("has-success has-error");
		$(elm).find(".help-block").text("");
	}
	
	//打开添加的模块框
	function toAddEmpUI() {
		//重置表单数据
		resetForm("#addEmpModal form");
		//resetForm("#addEmpModal");
		findAllDept("#dept");
		$("#addEmpModal").modal({
			backdrop : "static"
		});
	}
	
	//将获取的部门信息放在下拉列表中
	function findAllDept(elm){
		$.ajax({
			url:"${pageContext.request.contextPath }/dept",
			type:"GET",
			success:function(data){
				//向下拉列表中放值时，应该先清空下拉列表中的值
				$(elm).empty();
				$(elm).append("<option value=''>--请选择--</option>");
				$.each(data .map.list,function(index,dept){
					/* if(did==dept.deptId){
						$(elm).append("<option value='"+dept.deptId+"' selected='selected'>"+dept.deptName+"</option>");
					}else{
					$(elm).append("<option value='"+dept.deptId+"'>"+dept.deptName+"</option>");
					} */
					$(elm).append("<option value='"+dept.deptId+"'>"+dept.deptName+"</option>");
				});
			}
		});
	}
	
	//校验表单提示错误信息
	function showMes(elm,struct,mes){
		$(elm).parent().removeClass("has-success has-error");
		$(elm).next("span").text("");
		if("success"==struct){
			//成功的提示信息
			$(elm).parent().addClass( "has-success");
			$(elm).next("span").text(mes);
		}else if("error"==struct){
			//错误的提示信息
			$(elm).parent().addClass( "has-error");
			$(elm).next("span").text(mes);
		}
	}
	//校验表单的数据
	function checkForm(){
		var name=$("#empName").val();
		var checkName=/(^[A-Za-z0-9]{4,10}$)|(^[\u2E80-\u9FFF]{2,5})/;
		if(!checkName.test(name)){
			showMes("#empName", "error", "用户名规格错误！");
			return false
		}else{
			showMes("#empName", "success", "用户名正确！");
		};
		var email=$("#email").val();
		var checkEmail=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
		if(!checkEmail.test(email)){
			showMes("#email", "error", "邮箱规格错误！");
			return false;
		}else{
			showMes("#email", "success", "邮箱可用！");
		};
		return true;
	}
	//点击保存，保存员工
	$("#addEmp").click(function(){
		//前端校验数据
		 if(!checkForm()){
			return false;
		} 
		//若用户名与数据库中重名了。则保存失败
		if($("#addEmp").attr("check_name")=="error"){
			showMes("#empName", "error", "用户已存在！");
			return false;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/emps",
			type:"POST",
			data:$("#addEmpModal form").serialize(),
			success:function(data){
				if(data.code==100){
					//关闭添加的模态框
					$("#addEmpModal").modal("hide");
					//跳转到查询最后一页
					toPage(totalSize);
				}else{
					if(undefined!=data.map.email){
						showMes("#email","error", data.map.email);
					}
					if(undefined!=data.map.empName){
						showMes("#empName","error", data.map.empName);
					}
				}
			}
		})
	});
	//校验表单name数据看是否与数据库中重名
	$("#empName").change(function(){
		var name=$("#empName").val();
			$.ajax({
				url:"${pageContext.request.contextPath }/check",
				type:"GET",
				data:"empName="+name,
				success:function(data){
					if(data.code==100){
						showMes("#empName", "success",data.map.check_mes);
						$("#addEmp").attr("check_name","success");
					}else if(data.code==200){
						showMes("#empName", "error",data.map.check_mes);
						$("#addEmp").attr("check_name","error");
					}
				}
			});
	});
	
	/* 
		为修改按钮绑定事件 
		不同的绑定单击事件是绑定不上去的，因为绑定单击事件
		是在页面加载的时候js执行绑定，这个时候按钮还没有创建出来，
		按钮是在页面加载之后才创建出来的
		因此绑定事件需要用到live函数，在新版本的jquery中，用on来代替
		document:页面总元素
		click:将要绑定的事件
		".editBtn":通过类选择器找到要绑定时间的标签
	*/
	//修改员工数据，打开员工的模块框
	$(document).on("click",".editBtn",function(){
		//向下拉列表中填入数据
		findAllDept("#updatedept");
		var empId=$(this).attr("edit_id");
		//为更新按钮绑定要更新数据id
		$("#updateEmp").attr("update_empId",empId);
		//发送ajax请求，获取员工的信息
		updataEmpUI(empId);
		//打开模块框之前要重置表单的数据和样式
		resetForm("#updateEmpModal form")
		//打开模块框
		$("#updateEmpModal").modal({
			backdrop : "static"
		});
	});
	//获取员工数据的函数
	function updataEmpUI(empId){
		$.ajax({
			url:"${pageContext.request.contextPath }/emps/"+empId,
			type:"GET",
			success:function(data){
				$("#update_name").text(data.map.emp.empName);
				$("#update_email").val(data.map.emp.email);
				/*
				#updateEmpModal input[name='gender']":子元素选择器，找到id为#updateEmpModal
				标签下的所有name=gender的标签
				*/
				$("#updateEmpModal input[name='gender']").val([data.map.emp.gender]);
				$("#updateEmpModal select").val([data.map.emp.dId]);
				$("#update_empName").val(data.map.emp.empName);
			}
		});
	}
	
	//更新员工
	$("#updateEmp").click(function(){
		//前端校验邮箱的格式
		var email=$("#update_email").val();
		var checkEmail=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
		if(!checkEmail.test(email)){
			showMes("#update_email", "error", "邮箱规格错误！");
			return false;
		}else{
			showMes("#update_email", "success", "邮箱可用！");
		}; 
		var empName=$("#update_name").text();
		$.ajax({
			url:"${pageContext.request.contextPath }/emps/"+$("#updateEmp").attr("update_empId"),
			data:$("#updateEmpModal form").serialize(),
			type:"PUT",
			success:function(data){
				if(data.code==200){
					if(undefined!=data.map.email){
						showMes("#update_email","error", data.map.email);
					}
					return false;
				}else{
					//关闭添加的模态框
					$("#updateEmpModal").modal("hide");
					//跳转到更新数据的这一页
					toPage(Num);
				}
			}
		});
	});
	
	//员工删除
	$(document).on("click",".delBtn",function(){
		/* parents("tr")：找祖先节点 */
		var empName=$(this).parents("tr").find("td:eq(2)").text();
		var flag=confirm("是否确定删除【"+empName+"】?");
		if(flag){
			$.ajax({
				url:"${pageContext.request.contextPath}/emps/"+$(this).attr("del_id"),
				type:"DELETE",
				success:function(data){
					alert(data.mes);
					toPage(Num);
				}
			});
		}
	});
	
	//全选，全不选
	$("#checkAll").click(function(){
		var check=$(this).prop("checked");
		if(check){
			$(".onecheck").prop("checked","checked");
		}else{
			$(".onecheck").prop("checked",false);
		}
	});
	//如果底下的复选框全部选中，上面的也要选中
	$(document).on("click",".onecheck",function(){
		var length=$(".onecheck:checked").length==$(".onecheck").length;
			$("#checkAll").prop("checked",length);
	});
	
	//批量删除员工
	$("#del_Emps").click(function(){
		var checkboxs=$(".onecheck:checked");
		var names="";
		var ids="";
		$.each(checkboxs,function(){
			names+=$(this).parents("tr").find("td:eq(2)").text()+",";
			ids+=$(this).parents("tr").find("td:eq(1)").text()+"-";
		});
		var flag=confirm("确定删除【"+names.substring(0, names.length-1)+"】？");
		if(flag){
			$.ajax({
				url:"${pageContext.request.contextPath}/emps/"+ids.substring(0,ids.length-1),
				type:"DELETE",
				success:function(data){
					alert(data.mes);
					toPage(Num);
				}
			});
		};
	});
</script>
</html>