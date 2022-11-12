<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
window.history.forward();
function noBack(){window.history.forward();}
</script>
<style type="text/css">
	
.home_list{
	display: grid;
	grid-template-columns: repeat(5, 1fr);
	grid-template-rows: 250px 250px 250px;
}
.home_list li{
	list-style: none;
	
}
.home_list li h2{
	color: black;
}
.home_list li:hover{
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
}
.home_list li:hover .tkdtpqhrl{
	background-color: #519d9e;
    color: #9dc8c8;
}

.home_list li span:hover{
	background-color: #519d9e;
    color: #9dc8c8;
}
.home_list li:nth-of-type(1){
	grid-column: 2/3;
	grid-row: 1/2;

}
.home_list li:nth-of-type(2){
	grid-column: 3/4;
	grid-row: 1/2;
}
.home_list li:nth-of-type(3){
	grid-column: 4/5;
	grid-row: 1/2;
}
.home_list li:nth-of-type(4){
	grid-column: 2/3;
	grid-row: 2/3;
}
.home_list li:nth-of-type(5){
	grid-column: 3/4;
	grid-row: 2/3;
}
.home_list li:nth-of-type(6){
	grid-column: 4/5;
	grid-row: 2/3;
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
.block{
	display: block;
}
	
</style>
</head>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	<jsp:include page="../include/admin_top.jsp"/>
	<br><br><br>
	<div class="grid" align="center">
		<c:set var="admin_id" value="${admin_id }"/>
		<c:set var="admin_name" value="${admin_name }"/>
		<ul class="home_list">
			<li>
				<div class="member_control">
					<a class="block" href="<%=request.getContextPath() %>/admin_control.do">
						<br><br><br>
						<img src="<%=request.getContextPath()%>/uploadFile/admin/회원관리_image.png" width="64" height="54">
						<h2>회원 신고 관리</h2>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
				</div>
			</li>
			<li>
				<div class="category_control">
					<a class="block" href="<%=request.getContextPath() %>/category_control.do">
						<br><br><br>
						<img src="<%=request.getContextPath()%>/uploadFile/admin/카테고리관리_image.png" width="64" height="54">
						<h2>카테고리 관리</h2>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
				</div>
			</li>
			<li>
				<div class="question_control">
					<a class="block" href="<%=request.getContextPath() %>/category_question.do">
						<br><br><br>
						<img src="<%=request.getContextPath()%>/uploadFile/admin/1대1문의_image.png" width="64" height="54">
						<h2>1:1문의 관리</h2>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
				</div>
			</li>
			<li>
				<div class="category_control">
					<a class="block" href="<%=request.getContextPath() %>/FAQ_control.do">
						<br><br><br>
						<img src="<%=request.getContextPath()%>/uploadFile/admin/공지사항관리_image.png" width="64" height="54">
						<h2>공지사항 관리</h2>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
				</div>
			</li>
			<li>
				<div class="challenge_control">
					<a class="block" href="<%=request.getContextPath() %>/challenge_control.do">
						<br><br><br>
						<img src="<%=request.getContextPath()%>/uploadFile/admin/챌린지관리_image.png" width="64" height="54">
						<h2>챌린지 관리</h2>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
				</div>
			</li>
			<li>
				<div class="make_challenge">
					<a class="block" href="<%=request.getContextPath() %>/admin_challJoin_1.do">
						<br><br><br>
						<img src="<%=request.getContextPath()%>/uploadFile/admin/챌린지만들기_image.png" width="64" height="54">
						<h2>챌린지 만들기</h2>
						<span class="tkdtpqhrl"> 상세보기 + </span>
					</a>
				</div>
			</li>
			<%-- <a id="1" href="<%=request.getContextPath() %>/admin_control.do"><img src="<%=request.getContextPath()%>/uploadFile/admin/회원관리_image.png" width="64" height="54"></a>
			<a id="2" href="<%=request.getContextPath() %>/category_control.do"><img src="<%=request.getContextPath()%>/uploadFile/admin/카테고리관리_image.png" width="64" height="54"></a>
			<a id="3" href="<%=request.getContextPath() %>/category_question.do"><img src="<%=request.getContextPath()%>/uploadFile/admin/1대1문의_image.png" width="64" height="54"></a>
			<a id="4" href="<%=request.getContextPath() %>/FAQ_control.do"><img src="<%=request.getContextPath()%>/uploadFile/admin/공지사항관리_image.png" width="64" height="54"></a>
			<a id="5" href="<%=request.getContextPath() %>/challenge_control.do"><img src="<%=request.getContextPath()%>/uploadFile/admin/챌린지관리_image.png" width="64" height="54"></a>
			<a id="6" href="<%=request.getContextPath() %>/admin_challJoin_1.do"><img src="<%=request.getContextPath()%>/uploadFile/admin/챌린지만들기_image.png" width="64" height="54"></a> --%>
		</ul>
	</div>
	<jsp:include page="../include/chall_bottom.jsp"/>
</body>
</html>