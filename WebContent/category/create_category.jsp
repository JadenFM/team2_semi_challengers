<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.all_container{
	margin-left: 30%;
}
.asd{
	background-color: #F6F7F9;
}
#container{
	background-color: #F6F7F9;
}
.header {
	background-color: #F6F7F9;
	height: 100%;
	padding: 60px 0px 30px;
}
.h_container1{
	margin-top: 15%;
}

.h_container2 {
	border: none;
	width: 30px;
	display: inline-block;
	height: 66px;
	background-color: white;
	border-radius: 7px;
}

.search {
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

img {
	margin-top: 20px;
}

.header2 {
	background-color: #F6F7F9;
	margin-top: 100px;
}

.h_bottom {
	margin-left: 100px;
}

.list li {
	display: inline-block;
	width: 70px;
}

.list li b {
	margin-left: 15px;
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
<body class="asd">
	<jsp:include page="../include/admin_top.jsp" />
	<div class="all_body">
		<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/create_category.do">
		<div class="header">
			<div class="all_container">
				<div class="h_container">
					<h2>카테고리 코드</h2>
					<input class="search" name="category_code">
				</div>
				<div class="h_container1">
					<h2>카테고리 이름</h2>
					<input class="search" name="category_name">
				</div>
				<div class="h_container1">
					<h2>카테고리 이미지</h2>
					<input type="file" class="search" name="category_image">
				</div>
				<br>
				<br><br>
				<br>
				<div class="btn">
					<input type="submit" value="추가">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				</div>
			</div>
			</div>
			<!-- 
					<th>카테고리 코드</th>
					<td><input name="category_code"></td>
					<th>카테고리 이름</th>
					<td><input name="category_name"></td>
					<th>카테고리 이미지</th>
					<td><input type="file" name="category_image"></td>
					<td colspan="2" align="center"><input type="submit"
						value="추가하기"></td> -->
		</form>
	</div>
</body>
</html>