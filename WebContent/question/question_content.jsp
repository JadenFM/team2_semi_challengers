<%@page import="com.question.model.QuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	QuestionDTO content = (QuestionDTO)request.getAttribute("content");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
		$("#btn").click(function(){
			history.back()
		});
	});
	
</script>
<style type="text/css">
	#container{
	background-color: #F6F7F9;
}
.header {
	background-color: #F6F7F9;
	height: 100%;
	padding: 60px 0px 30px;
	margin-left: 30%
}


.h_container_cate {
	margin-top: 10%;
}

.h_container_cont {
	margin-top: 10%;
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
	margin-top: 2%;
}

.header2 {
	background-color: #F6F7F9;
	margin-top: 10%;
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
.btn{
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
.btn:hover{
	background-color: #77af9c;
	color: #d7fff1;
}
</style>
</head>
<body>
	<jsp:include page="../include/admin_top.jsp" />
		<c:set var="content" value="${content }" />
		<form method="post" action="question_answer.do">
		<input type="hidden" name="p_q_num" value="<%=content.getP_q_num() %>">
		<input type="hidden" name="p_q_user_num" value="<%=content.getP_q_user_num() %>">		
		<div id="container">
		<div class="header">
			<div class="h_container">
				<h2>제 목<%=content.getP_q_user_num() %></h2>
				<input class="search" value="<%=content.getP_q_title()%>" readonly>
			</div>
			<div class="h_container_cate">
				<h2>카테고리</h2>
				<input class="category_name"value="<%=content.getP_q_category_num()%>" readonly>
			</div>
			<div class="header2"></div>
			<div class="h_container_cont">
				<h2>내 용</h2>
				<textarea class="cont" rows="20" cols="100" readonly><%=content.getP_q_content() %></textarea>
			</div>
			<div class="h_container_cont_1">
				<h2>답 변</h2>
				<textarea class="cont" rows="20" cols="100" name="p_q_answer_cont"></textarea>
			</div>
			<br>
			<br>
			<input class="btn" type="submit" value="답변하기" onclick="<%=request.getContextPath()%>/category_control.do">
		</div>
		</div>
		</form>
	<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>