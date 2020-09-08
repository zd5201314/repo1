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
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-success">添加</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<th>员工编号</th>
					<th>员工姓名</th>
					<th>员工性别</th>
					<th>员工邮箱</th>
					<th>员工所属部门</th>
					<th>操作</th>
					<c:forEach items="${info.list }" var="emp">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender }</td>
							<td>${emp.email }</td>
							<td>${emp.dept.deptName }</td>
							<td>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编译
								</button>
								<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				当前是第${info.pageNum }页，总共有${info.pages }页，共${info.total }条记录。
			</div>
			<div class="col-md-6">
				<nav>
				<ul class="pagination">
					<c:if test="${info.isFirstPage }">
						<li class="disabled"><span aria-hidden="true">首页</span></li>
						<li class="disabled"><span aria-hidden="true">&laquo;</span></li>
					</c:if>
					<c:if test="${!info.isFirstPage }">
						<li><a href="${pageContext.request.contextPath }/emps?pageNum=1"
							aria-label="Previous"> <span aria-hidden="true">首页</span>
						</a></li>
						<li><a href="${pageContext.request.contextPath }/emps?pageNum=${info.prePage }"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach begin="${info.navigateFirstPage }"
						end="${info.navigateLastPage }" var="i">
						<c:if test="${info.pageNum==i }">
							<li class="active"><a href="#">${i }</a></li>
						</c:if>
						<c:if test="${info.pageNum!=i }">
							<li><a href="${pageContext.request.contextPath }/emps?pageNum=${i }">${i }</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${info.isLastPage }">
						<li class="disabled"><span aria-hidden="true">&raquo;</span>
						</li>
						<li class="disabled"><span aria-hidden="true">尾页</span>
						</li>
					</c:if>
					<c:if test="${!info.isLastPage }">
						<li><a href="${pageContext.request.contextPath }/emps?pageNum=${info.nextPage }"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
						<li><a href="${pageContext.request.contextPath }/emps?pageNum=${info.pages }"
							aria-label="Next"> <span aria-hidden="true">尾页</span>
						</a></li>
					</c:if>
				</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>