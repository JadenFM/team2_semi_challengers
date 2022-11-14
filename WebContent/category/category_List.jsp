<%@page import="com.category.medel.CategoryDTO"%>
<%@page import="com.category.medel.SubDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<style type="text/css">
.container{
    margin-right: 0px;
    margin-left: 0px;   
    max-width: 100%;
    padding: 0px;
    box-sizing: content-box;
      }
   
    .search_text{
   box-sizing:content-box;
    }
    
    .rogoImg{
   box-sizing: content-box;
    }
    
    .top{
   margin: 16px 0px 16px 0px; 
    }
    
    .menu li{
    box-sizing: content-box;
    }
.header {
	background-color: #F6F7F9;
	height: 247px;
	padding: 60px 0px 30px;
}

.h_container {
	margin-left: 19%;
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
	width: 350px;
	height: 66px;
	font-size: 20px;
	border: none;
	border-radius: 7px;
	position: absolute;
}

img {
	margin-top: 40px;
}
.category_div{
	display: inline-block;
	margin-left: 120px;
}
.category_list li{
	display: inline-block;
}
.block{
	display: block;
}
.category_list{
	display: grid;
	grid-template-columns: repeat(5, 1fr);
	grid-template-rows: 250px 250px 250px;
}
.category_list li{
	list-style: none;
	
}
.category_list li h2{
	color: black;
}
.category_list li:hover{
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
}
.category_list li:hover .tkdtpqhrl{
	background-color: #519d9e;
    color: #9dc8c8;
}

.category_list li span:hover{
	background-color: #519d9e;
    color: #9dc8c8;
}
.category_list li:nth-of-type(1){
	grid-column: 2/3;
	grid-row: 1/2;

}
.category_list li:nth-of-type(2){
	grid-column: 3/4;
	grid-row: 1/2;
}
.category_list li:nth-of-type(3){
	grid-column: 4/5;
	grid-row: 1/2;
}
.category_list li:nth-of-type(4){
	grid-column: 2/3;
	grid-row: 2/3;
}
.category_list li:nth-of-type(5){
	grid-column: 3/4;
	grid-row: 2/3;
}
.category_list li:nth-of-type(6){
	grid-column: 4/5;
	grid-row: 2/3;
}
.category_list li:nth-of-type(7){
	grid-column: 2/3;
	grid-row: 3/4;
}
.category_list li:nth-of-type(8){
	grid-column: 3/4;
	grid-row: 3/4;
}
.category_list li:nth-of-type(9){
	grid-column: 4/5;
	grid-row: 3/4;
}

.tkdtpqhrl{
	border: 3px solid #519d9e;
    color: darkgray;
	position: relative;
    padding: 7px 15px;
    border-radius: 15px;
    font-family: "paybooc-Light", sans-serif;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    text-decoration: none;
    font-weight: 600;
    transition: 0.25s;
}
.tkdtpqhrl:hover{
	background-color: #519d9e;
    color: #9dc8c8;
}
.btn {
	text-align: center;
	margin-left: 46%;
}

.btn input {
	display : inline-block;
	border: none;
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
	<jsp:include page="../include/admin_top.jsp"/>
	<c:set var="list" value="${list }"/>
		<br><br><br><br><br><br>
		<div class="all">
			<ul class="category_list">
				<li>
					<div class="training">
						<a class="block" href="<%=request.getContextPath()%>/category_modify.do?category_num=1">
							<img src="uploadFile/admin/운동.png" width="64" height="54">
							<h2>운 동</h2>
							<br>
							<span class="tkdtpqhrl"> 상세보기 + </span>
						</a>
					</div>
				</li>
				<li>
					<div class="eating">
					<a class="block" href="<%=request.getContextPath()%>/category_modify.do?category_num=2">
						<img src="uploadFile/admin/식습관.png" width="64" height="54">
						<h2>식습관</h2>
						<br>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
					</div>
				</li>
				<li>
					<div class="life">
					<a class="block" href="<%=request.getContextPath()%>/category_modify.do?category_num=3">
						<img src="uploadFile/admin/생활.png" width="64" height="54">
						<h2>생 활</h2>
						<br>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
					</div>
				</li>
				<li>
					<div class="mind">
					<a class="block" href="<%=request.getContextPath()%>/category_modify.do?category_num=4">
						<img src="uploadFile/admin/정서.png" width="64" height="54">
						<h2>정 서</h2>
						<br>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
					</div>
				</li>
				<li>
					<div class="hobby">
					<a class="block" href="<%=request.getContextPath()%>/category_modify.do?category_num=5">
						<img src="uploadFile/admin/취미.png" width="64" height="54">
						<h2>취 미</h2>
						<br>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
					</div>
				</li>
				<li>
					<div class="environment">
					<a class="block" href="<%=request.getContextPath()%>/category_modify.do?category_num=6">
						<img src="uploadFile/admin/환경.png" width="64" height="54">
						<h2>환경+펫</h2>
						<br>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
					</div>
				</li>
				<li>
					<div class="etc">
					<a class="block" href="<%=request.getContextPath()%>/category_modify.do?category_num=7">
						<img src="uploadFile/admin/기타.png" width="64" height="54">
						<h2>기 타</h2>
						<br>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
					</div>
				</li>
				<li>
					<div class="study">
					<a class="block" href="<%=request.getContextPath()%>/category_modify.do?category_num=8">
						<img src="uploadFile/admin/공부.png" width="64" height="54">
						<h2>공 부</h2>
						<br>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
					</div>
				</li>
				<li>
					<div class="selfcare">
					<a class="block" href="<%=request.getContextPath()%>/category_modify.do?category_num=9">
						<img src="uploadFile/admin/공부.png" width="64" height="54">
						<h2>셀프케어</h2>
						<br>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
					</div>
				</li>
			</ul>
		</div><br>
	<jsp:include page="../include/chall_bottom.jsp"/>
</body>

</html>
