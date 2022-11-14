<%@page import="com.category.medel.CategoryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	CategoryDTO content = (CategoryDTO)request.getAttribute("content11");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

#container{
	background-color: #F6F7F9;
	height: 100%;
}
.header {
	/* height: 100%; */
	padding: 60px 0px 30px;
	box-sizing: none;
	margin-left: 30%;
}

.h_container1{
	margin-top: 100px;
}

.h_container2 {
	border: none;
	width: 30px;
	display: inline-block;
	height: 66px;
	background-color: white;
	border-radius: 7px;
}

.code , .name , .image , .sub_category_name{
	width: 700px;
	height: 66px;
	font-size: 20px;
	border: none;
	border-radius: 7px;
	position: absolute;
}


.category_name {
	width: 700px;
	height: 66px;
	font-size: 20px;
	border: none;
	border-radius: 7px;
	position: absolute;
}

.header2 {
	background-color: #F6F7F9;
}

.list li {
	display: inline-block;
	width: 70px;
}
.h_underline {
	margin-top: 20px;
	border: solid;
}

.cont {
	border: none;
	border-radius: 7px;
}

.btn input {	
	position: relative;
	border: none;
	display: inline-block;
	padding: 15px 30px;
	border-radius: 7px;
	font-family: "paybooc-Light", sans-serif;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
	text-decoration: none;
	font-weight: 600;
	transition: 0.25s;
	background-color: #519d9e;
	color: black;
}

.btn input:hover {
	background-color: #77af9c;
	color: #d7fff1;
}
</style>
</head>
<body>
	<jsp:include page="../include/admin_top.jsp" />
	<div id="container">
		<form method="post" enctype="multipart/form-data"
			action="<%=request.getContextPath()%>/category_modify_Ok.do">
			<input type="hidden" name="category_num" value="<%=content.getCategory_num()%>">
			<div class="header">
				<div class="h_container">
					<h2>코 드</h2>
					<input class="code" name="category_code" value="<%=content.getCategory_code()%>">
				</div>
				<div class="h_container1">
					<h2>이 름</h2>
					<input class="name" name="category_name" value="<%=content.getCategory_name()%>">
				</div>
				<div class="h_container1">
					<h2>이미지</h2>
					<input class="image" type="file" name="category_image">
				</div>
				<div class="h_container1">
					<h2>서브 카테고리</h2>
					<select class="sub_category_name" name="sub_category_name">
							<option>:::서브 카테고리:::</option>
						<c:forEach items="${list }" var="dto">
							<option value="${dto.sub_category_name }">${dto.sub_category_name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="h_container1">
					<h2>서브카테고리</h2>
					<input class="name" name="category_name_input" placeholder="변결할 서브카테고리의 이름을 입력해 주십시오.">
				</div>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
			<div class="btn">
				<input type="submit" value="수정하기">
				<input type="button" value="삭제하기" onclick="location.href='<%=request.getContextPath()%>/category_delete.do?category_num=<%=content.getCategory_num()%>'">
			</div>
			</div>
		</form>
	</div>
	<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>