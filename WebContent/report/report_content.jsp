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
	height : 100%;
	background-color: #F6F7F9;
}
.header {
	height: 100%;
	padding: 60px 0px 30px;
}
.h_container {
	margin-left: 120px;
}
.h_container1{
	margin-top: 100px;
	margin-left: 120px;
}

.report_title , .mem_id_report , .mem_id_reported , .mem_name_reported , .report_cause , .report_result{
	width: 700px;
	height: 66px;
	font-size: 20px;
	border: none;
	border-radius: 7px;
	position: absolute;
}
.report_cont {
	border: none;
	border-radius: 7px;
}

.btn {
	margin-left: 230px;
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
		<form method="post" action="report_result.do">
				<div id="container">
				<div class="header">
				<div class="h_container">
					<div class="h_container">
						<h2>제 목</h2>
						<input class="report_title" name="report_title" value="${content.report_title }" readonly>
					</div>
					<div class="h_container1">
						<h2>신고자</h2>
						<input class="mem_id_report" name="mem_id_report" value="${content.mem_id_report }" readonly>
					</div>
					<c:if test="${!empty content.mem_id_reported }">
						<div class="h_container1">
							<h2>피신고자</h2>
							<input class="mem_id_reported" name="mem_id_reported" value="${content.mem_id_reported }" readonly>
						</div>
					</c:if>
					<c:if test="${empty content.mem_id_reported }">
						<div class="h_container1">
							<h2>피신고자</h2>
							<input class="mem_name_reported" name="mem_name_reported" value="${content.mem_name_reported }" readonly>
						</div>
					</c:if>
					<div class="h_container1">
						<h2>신고 사유</h2>
						<input class="report_cause" name="report_cause" value="${content.report_cause }" readonly>
					</div>
					<div class="h_container1">
						<h2>내 용</h2>
						<textarea class="report_cont" rows="20" cols="100" readonly>${content.report_content }</textarea>
					<h2>정지일</h2>
					<select class="report_result" name="report_result">
						<option value="">:::선택:::</option>
						<option value="3">3일</option>
						<option value="5">5일</option>
						<option value="15">15일</option>
						<option value="30">30일</option>
						<option value="365">365일</option>
					</select>
					</div>
					<c:if test="${!empty content.report_image }">
						<div class="h_container1">
							<img src="<%=request.getContextPath() %>/report_image/${content.report_image}" width="250px" height="250px">						
						</div>
					</c:if>
				</div>
				</div>
			<br><br><br><br><br>
			<div class="btn">
					<input type="submit" value="정지">
					<c:if test="${!empty content.mem_id_reported }">
						<input type="button" value="회원삭제" onclick="location.href='<%=request.getContextPath()%>/delete_member.do?mem_id_reported=${content.mem_id_reported }'">			
					</c:if>
					<c:if test="${empty content.mem_id_reported }">
						<input type="button" value="회원삭제" onclick="location.href='<%=request.getContextPath()%>/delete_member.do?mem_name_reported=${content.mem_name_reported }'">			
					</c:if>
			</div>
			</div>
		</form>
	<jsp:include page="../include/chall_bottom.jsp"/>
</body>
</html>