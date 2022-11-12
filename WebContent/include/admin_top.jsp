<%@page import="com.user.model.UserDAO"%>
<%@page import="com.question.model.QuestionDAO"%>
<%@page import="com.question.model.QuestionDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.user.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	HttpSession session1 = request.getSession();
	String admin_id =(String)session1.getAttribute("admin_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script type="text/javascript">

	function login_check(){
		console.log("<%=admin_id%>");
		if("<%=admin_id%>" == "null"){
			alert("로그인이 필요합니다.")
			location.href="main.do"
		}
	}
	
	
	
</script>
<style type="text/css">
	
	body {
	 width: 100vw;
	 height: 100vh;
	 margin : 0;
	}
	
	.container {
		display : grid;
		grid-template-columns: repeat(6, 1fr);
		grid-template-rows: 100px 80px;
		position: sticky;
		background-color : white;
	 	/* top: 0; */
	 	border-bottom: 1px solid lightgray;
	}
	
	.head {
		text-align: left;
	}
	
	.rogoImg{
		padding: 20px;
		grid-column: 1/2;
		grid-row: 1/2;
		width: 250px;
	}
	
	.top_right{
		grid-column: 6/7;
		grid-row: 1/2;
	}
	
	.top_right a {
		color: black;
	}
	
	.top{
		width: 420px;
		display: grid;
		grid-template-columns: 1fr 2fr 1fr;
		grid-template-rows: 50px;
		grid-auto-columns: auto;
		column-gap : 1px;
	}
	
	.top_li_4 {
		list-style: none;
		grid-column: 2/3;
		grid-row: 1/2;
		font-size: 16px;
	}
	.top_li_5 {
		grid-column: 3/4;
		grid-row: 1/2;	
		list-style: none;
		font-size: 16px;
		top : 100;
	}
	
	.search{
		grid-column: 1/7;
		grid-row: 2/3;
		align-content: center;
	}
	
	.search_text{
		width:33%; 
		height:40px;
		padding: 0;
		border-spacing: 1px;
		border-color: black;
		border-radius: 5px;
		font-size: 16px;
	}
	
	.search_btn{
		cursor: pointer;
		width: 80px;
		height: 43.99px;
		background-color:#289828;
		color : white;
		font-weight : bold;
		font-size: 16px;
		border-radius: 5px;
		
	}
	
	.navi {
		grid-column: 1/7;
		grid-row: 2/3;
		float:left; 
		text-align: center;
	}
	
	nav ul {
		display: grid;
		list-style: none;
		grid-template-columns: repeat(7, 1fr);
		grid-column: -1/-2;
		grid-row: 1/2;	
		height: 66.65px;
		margin: 0;
	}
	
	.menu li{
		font-size: 20px;
		font-weight: bold;
		height: 50px;
		padding-top: 16.665px;
	}
	
	a {
		text-align: center;
		text-decoration: none;
	}
	
	.menu a {
		display: block;
		height: 50px;
		color: black;
	}
	
	
	.menu li:hover{
		background-color: #289828;
	}
	
	.menu_li_1 {
		grid-column: 2/3;
		grid-row: 1/2;
	}
	
	.menu_li_2 {
		grid-column: 3/4;
		grid-row: 1/2;
	}
	
	.menu_li_3 {
		grid-column: 4/5;
		grid-row: 1/2;
	}
	
	.menu_li_4 {
		grid-column: 5/6;
		grid-row: 1/2;
	}
	.menu_li_5 {
		grid-column: 6/7;
		grid-row: 1/2;
	}
	
	.foot_container {
		display: grid;
		grid-template-columns: 1fr 2fr 1fr;
		grid-template-rows: 50px;
		text-align: center;
	}
	
	.footer{
		grid-column: 2/3;
		grid-row: 1/2;	
		color: gray;
	}
	
	.footer a{
		color: gray;
	}
	
	
</style>
</head>
<body onload="login_check()">
	<div class="container" align="center">
		
		<header class="head">
		
			<a  href="<%=request.getContextPath() %>/main.do"> <img class="rogoImg" alt="챌린저스 로고" src="<%=request.getContextPath() %>/uploadFile/challengers_manager_logo.png"> </a>
			
		</header>
			<c:set var="dto" value="${admin_name }" />
			<c:set var="list" value="${list }"/>
			<div class="top_right">
				<ul class="top">
					<c:if test="${!empty admin_name }">
						<li class="top_li_4"><b>${admin_name }</b> 관리자님 안녕하세요!</li>
						<li class="top_li_5"><a href="admin_logout.do">로그아웃</a>
					</c:if>
				</ul>
			</div>
		<nav class="navi">
			<ul class="menu">
				<li class="menu_li_1"><a href="<%=request.getContextPath()%>/admin/admin_home.jsp">관리자 홈</a></li>
				<li class="menu_li_2"><a href="<%=request.getContextPath()%>/admin_control.do">회원 신고 관리</a></li>
				<li class="menu_li_3"><a href="<%=request.getContextPath() %>/category_control.do">카테고리 관리</a></li>
				<li class="menu_li_4"><a href="<%=request.getContextPath() %>/FAQ_control.do">공지사항 관리</a></li>
				<li class="menu_li_5"><a href="<%=request.getContextPath() %>/category_question.do">1:1문의 관리</a></li>
			</ul>
		</nav>
	</div>
	<%-- 이하 영역은 본문 영역이 됨 --%>