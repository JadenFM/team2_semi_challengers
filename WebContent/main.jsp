<%@ page language="java" contentType="text/html; charset=UTF-8"	
    pageEncoding="UTF-8"%>	
<!DOCTYPE html>	
<html>	
<head>	
<meta charset="UTF-8">	
<title>Challengers</title>	
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>	
<script type="text/javascript" src="searchJS/main_list.js"></script>	
<script type="text/javascript" src="searchJS/main_menu.js"></script>	
<link rel="stylesheet" href="searchCS/mainCS.css">	
</head>	
<body>	
	<jsp:include page="include/chall_top.jsp" />	
	<article align="center" id="art">	
<%-- 		<hr width="65%" color="gray">	
 			<h3>챌린저스 메인 페이지</h3>	
		<hr width="65%" color="gray">	
		<br>	
	<div class="kakao"></div>		
		<a href="<%=request.getContextPath()%>/member_login.do">[회원 로그인]</a>	
		&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;	
		<a href="<%=request.getContextPath()%>/admin_login.do">[관리자 로그인]</a> jgvj--%>	
		<div class="main_container">	
 			<div class="main_container event">	
				<div class="slide_container">	
					<div class="slide fade active">	
						<img class="fade_img" src="<%=request.getContextPath() %>/event/event1.jpg">	
					</div>	
					<div class="slide fade">	
						<img class="fade_img" src="<%=request.getContextPath() %>/event/event2.png">	
					</div>	
					<div class="slide fade">	
						<img class="fade_img" src="<%=request.getContextPath() %>/event/event3.jpg">	
					</div>	
				</div>			
				<a class="prev" onclick="prevSlide()">&#10094;</a>	
				<a class="next" onclick="nextSlide()">&#10095;</a>		
			</div>	
				
			<div class="main_container">	
				<div class="category_container">	
					<div class="container_title">	
						<span class="title">카테고리 목록</span>	
					</div>	
					<div id="input_items">	
					</div>	
				</div>	
			</div>	
				
			<div class="main_container">	
				<div class="most_container">	
					<div class="container_title">	
						<span class="title">인기 챌린지</span>	
					</div>	
					<div id="input_items2">	
					</div>	
				</div>	
			</div>	
				
			<div class="main_container">	
				<div class="admin_container">	
					<div class="container_title">	
						<span class="title">전문 멘토와 함께하는 챌린지</span>	
					</div>	
					<div id="input_items3">	
					</div>	
				</div>	
			</div>	
				
			<form id="form" method='post' action="<%=request.getContextPath()%>/search.do">	
			<input type="hidden" name="keyword" value="">				
			<input type="hidden" id="form_category" name="category" value="">				
			</form>	
<a href="<%=request.getContextPath() %>/review/review_main.jsp" >임시리뷰페이지</a>	
			
	</article>	
	<jsp:include page="include/chall_bottom.jsp" />	
</body>	
</html>
