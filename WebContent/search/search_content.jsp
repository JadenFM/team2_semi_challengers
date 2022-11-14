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
	<jsp:include page="../include/chall_top.jsp" />
	<c:set var="num" value="${num }"/>
	<p>이동완료</p>
	<p>${num }</p>
	<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>