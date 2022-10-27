<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../include/chall_top.jsp"/>
	<div align="center">
		<c:set var="admin_id" value="${admin_id }"/>
		<c:set var="admin_name" value="${admin_name }"/>
		${admin_name }님 환영합니다!
		<br>
		<hr width="65%" color="tomato">
		<a href="<%=request.getContextPath() %>/admin_control.do">회원 관리</a>
		<hr width="65%" color="tomato">
		<br>
		<hr width="65%" color="tomato">
		<a href="<%=request.getContextPath() %>/category_control.do">카테고리 관리</a>
		<hr width="65%" color="tomato">
		<br>
		<hr width="65%" color="tomato">
		<a href="<%=request.getContextPath() %>/category_question.do">1:1문의 답변</a>
		<hr width="65%" color="tomato">
		<br>
		<hr width="65%" color="tomato">
		<a href="<%=request.getContextPath() %>/FAQ_control.do">공지사항 관리</a>
		<hr width="65%" color="tomato">
	</div>
	<jsp:include page="../include/chall_bottom.jsp"/>
</body>
</html>