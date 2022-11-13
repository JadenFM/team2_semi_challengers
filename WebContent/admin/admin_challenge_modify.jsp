<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

#container{
	background-color: #F6F7F9;
}
.header {
	background-color: #F6F7F9;
	height: 100%;
	padding: 60px 0px 30px;
	margin-left: 30%;
}
.h_container1{
	margin-top: 100px;
}

.open_close , .name , .chall_category , .chall_cycle , .chall_guide , .chall_regitimestart , .chall_regitimeend{
	width: 700px;
	height: 66px;
	font-size: 20px;
	border: none;
	border-radius: 7px;
	position: absolute;
}
.chall_cont {
	border: none;
	border-radius: 7px;
}
.chall_depositdefault , .chall_depositmax , .chall_maxpeople{
	width: 700px;
	height: 66px;
	font-size: 20px;
	border: none;
	border-radius: 7px;
	position: absolute;
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
	<jsp:include page="../include/admin_top.jsp"/>
		<c:set var="content" value="${content }"/>
		<div id="container">
			<form method="post" action="<%=request.getContextPath()%>/challenge_update.do">
			<input type="hidden" name="chall_num" value="${content.chall_num }">
			<input type="hidden" name="page" value="${page }">
			<div class="header">
				<div class="h_container">
					<h2>공개/비공개</h2>
					<c:if test="${content.chall_open == 'open' }">
					<input class="open_close" value="공개" readonly>
					<input type="hidden" name="chall_open" value="open">
					</c:if>
					<c:if test="${content.chall_open != 'open' }">
					<input class="open_close" value="비공개" readonly>
					<input type="hidden" name="chall_open" value="private">
					</c:if>
				</div>
				<div class="h_container1">
					<h2>제 목</h2>
					<input class="name" name="chall_title" value="${content.chall_title }">
				</div>	
				<div class="h_container1">
					<h2>카테고리</h2>
					<select class="chall_category" name="chall_category">
						<option value="${content.chall_category_code_fk }">${chall_category }</option>
						<option value="C001">운동</option>
						<option value="C002">식습관</option>
						<option value="C003">생활</option>
						<option value="C004">정서</option>
						<option value="C005">취미</option>
						<option value="C006">환경&펫</option>
						<option value="C007">기타</option>
						<option value="C008">공부</option>
						<option value="C009">자기관리</option>
					</select>
				</div>		
				<div class="h_container1">
					<h2>챌린지 사이클</h2>
					<select class="chall_cycle" name="chall_cycle">
						<option value="${content.chall_cycle }">${content.chall_cycle }</option>
						<option value="평일 매일">평일 매일</option>
						<option value="주말 매일">주말 매일</option>
						<option value="주 1일">주 1일</option>
						<option value="주 2일">주 2일</option>
						<option value="주 3일">주 3일</option>
						<option value="주 4일">주 4일</option>
						<option value="주 5일">주 5일</option>
						<option value="주 6일">주 6일</option>
						<option value="기 타">기 타</option>
					</select>
				</div>
				<div class="h_container1">
					<h2>가이드</h2>
					<input class="chall_guide" name="chall_guide" value="${content.chall_guide }">
				</div>
				<div class="h_container1">
					<h2>시작시간</h2>
					<input type="time" class="chall_regitimestart" name="chall_regitimestart" value="${content.chall_regitimestart }">
				</div>
				<div class="h_container1">
					<h2>종료시간</h2>
					<input type="time" class="chall_regitimeend" name="chall_regitimeend" value="${content.chall_regitimeend }">
				</div>
				<br><br>
				<div class="h_container1">
					<h2>내 용</h2>
					<textarea class="chall_cont" rows="20" cols="100" name="chall_cont">${content.chall_cont }</textarea>
					<h2>예치금</h2>
					<input class="chall_depositdefault" name="chall_depositdefault" value="${content.chall_depositdefault }">
				</div>
				<div class="h_container1">
					<h2>최대 예치금</h2>
					<input class="chall_depositmax" name="chall_depositmax" value="${content.chall_depositmax }">
				</div>
				<div class="h_container1">
					<h2>제한인원</h2>
					<input class="chall_maxpeople" name="chall_maxpeople" value="${content.chall_maxpeople }">
				</div>
				<br><br><br><br><br>
				<div class="btn">
					<input type="submit" value="수정하기">
					<input type="button" value="삭제하기" onclick="location.href='<%=request.getContextPath()%>/challenge_delete.do?chall_num=${content.chall_num }'">
				</div>
				</div>
			</form>
			</div>		
	<jsp:include page="../include/chall_bottom.jsp"/>
</body>
</html>
