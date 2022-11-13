<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

function category_check(){
	console.log($(".category_name").val());
	if($(".category_name").val() == ":::카테고리 선택:::"){
		alert("서브 카테고리를 선택해 주십시오.");
	}else{
		$("form").submit();
	}
}

</script>
<style type="text/css">

.all_container{
	margin-left: 30%;
}
#container{
	background-color: #F6F7F9;
}
.header {
	background-color: #F6F7F9;
	height: 100%;
	padding: 60px 0px 30px;
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
<body>
	<c:set var="dto" value="${dto }" />
	<jsp:include page="../include/admin_top.jsp" />
	<div id="container">
	<form method="post"
		action="<%=request.getContextPath()%>/FAQ_update.do">
		<input type="hidden" name="faq_num" value="${dto.faq_num }"> <input
			type="hidden" name="page" value="${param.page }">
			<div class="header">
			<div class="all_container">
				<div class="h_container">
					<h2>제 목</h2>
					<input class="search" name="faq_title" value="${dto.faq_title }">
				</div>
				<div class="h_container_cate">
					<h2>카테고리</h2>
					<select class="category_name" name="faq_category_num">
						<option>:::카테고리 선택:::</option>
						<option value="1">인증</option>
						<option value="2">결제</option>
						<option value="3">상금</option>
					</select>
				</div>
				<div class="header2"></div>
				<div class="h_container_cont">
					<h2>내 용</h2>
					<textarea class="cont" rows="20" cols="100" name="faq_content">${dto.faq_content }</textarea>
				</div>
				<br>
				<br>
				<div class="btn">
				<input type="button" value="수정하기" onclick="category_check()">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<input type="button" value="삭제하기" onclick="location.href='<%=request.getContextPath() %>/FAQ_delete.do?faq_num=${dto.faq_num }&page=${param.page }'">
			</div>
			</div>
			</div>
			
	</form>
	</div>
	<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>