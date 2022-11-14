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
    String access_token = (String)session.getAttribute("access_token");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

<!-- CS센터 페이지에서 쓰는 부분 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../CSS/CScenter.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src="../JS/CScenter.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/searchJS/location.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/searchJS/location.js"></script>
<script type="text/javascript" src="searchJS/local.js"></script>
<!-- <script type="text/javascript" src="../searchJS/move.js"></script>
<script type="text/javascript" src="searchJS/move.js"></script> -->



<style type="text/css">
	
	body {
	 width: 100vw;
	 height: 100vh;
	 margin : 0;
	}
	
	.container {
		display : grid;
		grid-template-columns: repeat(6, 1fr);
		grid-template-rows: 100px 80px 66.665px;
		
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
		padding: 0px;
		width: 500px;
		display: grid;
		grid-template-columns: 1fr 2fr 1fr 1fr 1fr;
		grid-template-rows: 50px;
		grid-auto-columns: auto;
		column-gap : 1px;
	}
	
	.top_li_1 {
		list-style: none;
		grid-column: 3/4;
		grid-row: 1/2;
		font-size: 16px;
	}
	
	.top_li_2 {
		list-style: none;
		grid-column: 4/5;
		grid-row: 1/2;
		font-size: 16px;
	}
	
	.top_li_3 {
		list-style: none;
		grid-column: 5/6;
		grid-row: 1/2;
		font-size: 16px;
	}
	
	.top_li_4 {
		list-style: none;
		grid-column: 2/3;
		grid-row: 1/2;
		font-size: 16px;
	}
	.top_li_5 {
		grid-column: 1/2;
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
		background-color: #ff4d54;
		color : white;
		font-weight : bold;
		font-size: 16px;
		border-radius: 5px;
		
	}
	
	.navi {
		grid-column: 1/7;
		grid-row: 3/4;
		float:left; 
		text-align: center;
	}
	
	nav ul {
		display: grid;
		list-style: none;
		grid-template-columns: repeat(6, 1fr);
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
		background-color: #ff4d54;
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
<body>
	<div class="container" align="center">
		
		<header class="head">
		
			<a  href="<%=request.getContextPath() %>/main.do"> <img class="rogoImg" alt="챌린저스 로고" src="<%=request.getContextPath() %>/uploadFile/logo_standard.svg"> </a>

		</header>
			<c:set var="dto" value="${memberName }" />
			<c:set var="list" value="${list }"/>
			<div class="top_right">
				<ul class="top">
					
					<c:if test="${empty memberName }">
						<li class="top_li_1"><a href="<%=request.getContextPath()%>/CS_main.do">고객센터</a></li>
						<li class="top_li_2"><a href="<%=request.getContextPath()%>/member_login.do">마이페이지</a></li>					
						<li class="top_li_3"><a href="<%=request.getContextPath() %>/member_login.do">로그인</a></li>
					</c:if>
					
					<c:if test="${!empty memberName }">
						<li class="top_li_1"><a href="<%=request.getContextPath()%>/CS_main.do">고객센터</a></li>
						<li class="top_li_2"><a href="<%=request.getContextPath() %>/member_mypage.do?no=${memberNum}">마이페이지</a></li>	
						<li class="top_li_3"><a href="#" onclick="javascript:document.frm.submit();">로그아웃</a></li>
						<form name="frm" action="<%=request.getContextPath() %>/member_logout.do" method="POST">
							<input type="hidden" name="access_token" value="${access_token }">
						</form>	
						<li class="top_li_4"><b>${memberName }</b> 님 안녕하세요!</li>
	
						<c:if test="${!empty list}">
							<span class="top_li_5">
											<a href="<%=request.getContextPath() %>/question_check_answer.do?mem_num=${memberNum}&p_q_check=1&mem_id=${memberId}"><img src="uploadFile/다운로드.png" width="30" height="30"></a>
											${fn:length(list)}
							</span>
						</c:if>
					</c:if>
				</ul>
			</div>


		<div class="search">
			<form id="form_searchText" method="post" onsubmit="return false;">
				<input id="search_text" class="search_text" name="search_text" placeholder="  당신의 챌린지를 찾아보세요!">&nbsp;&nbsp;
				<input id="search_btn" class="search_btn" type="button" value="검색">
			</form>	
		</div>

		<nav class="navi">
			<ul class="menu">
			
				<li class="menu_li_1"><a href="<%=request.getContextPath() %>/main.do">홈</a></li>
				
				<li class="menu_li_2"><a href="#">챌린지 조회</a></li>
				<li class="menu_li_3"><a href="<%=request.getContextPath() %>/member_challJoin.do">챌린지 개설</a></li>
				<li class="menu_li_4"><a href="#">내 챌린지</a></li>
			</ul>
		</nav>
		
	</div>
	<hr width=100% align="center">

	<%-- 이하 영역은 본문 영역이 됨 --%>
