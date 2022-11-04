<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Challengers</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript" src="searchJS/main_list.js"></script>

<script type="text/javascript" src="searchJS/refresh.js"></script>

</head>
<body>
	<jsp:include page="include/chall_top.jsp" />
	<article align="center" id="art">
		<hr width="65%" color="gray">


			<h3>챌린저스 메인 페이지</h3>
		<hr width="65%" color="gray">
		<br>
	<div class="kakao"></div>	
		<a href="<%=request.getContextPath()%>/member_login.do">[회원 로그인]</a>
		&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
		<a href="<%=request.getContextPath()%>/admin_login.do">[관리자 로그인]</a>
		<div id="load">
			<table class="chall_list">
				<tr>
					<th>제목</th>
					<th>내용</th>
				</tr>
			</table>
		</div>
		
		
		
	</article>
	<jsp:include page="include/chall_bottom.jsp" />

</body>
</html>