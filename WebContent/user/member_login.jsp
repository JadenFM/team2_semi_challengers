<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린저스 : 로그인</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<!-- <script src="https://t1.kakaocdn.net/kakao_js_sdk/v1/kakao.min.js"></script> -->

<style type="text/css">
	
	body {
	 width: 100vw;
	 height: 100vh;
	 margin : 0;
	}
	
	/* 하단 바 CSS (chall_bottom.jsp) */
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
	
	/* 로그인 페이지 CSS */
	.log_container {
		display: grid;
		grid-template-columns: 1fr 1fr 1fr;
		grid-template-rows: 1fr	2fr	1fr;
		text-align: center;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	
	.log_header {
		grid-column: 2/3;
		grid-row: 1/2;
	}
	
	.log_content{
		display: grid;
		place-items: center;
		grid-column: 2/3;
		grid-row: 2/3;	
	}
	
	.log_form {
		display: grid;
		place-items: center;
		width : 500px;
		border : 1px solid gray;
		border-radius: 10px;
		padding: 20px;
		padding-top: 40px;
	}
	
	.login_title{
		font-size: 25px;
	}
	
	.input_text {
		border : 1px solid lightgray;
		width: 360px;
		height: 121.11px;	
	}
	
	.input_text1 {
		width: 350px;
		height: 50px;
		border : 0px;
		font-size: 16px;
		padding : 5px;
	}
	
	.input_text2 {
		width: 350px;
		height: 50px;
		border : 0px;
		border-top : 1px solid lightgray;
		font-size: 16px;
		padding : 5px;
	}	
	
	.input_btn{
		cursor: pointer;
		width: 350px; 
		height: 60px;
		border : 1px solid black;
		border-radius: 5px;
		background-color: #ff4d54;
		color: white;
		font-size: 18px;
		font-weight: bold;
	}
	
	.find_join{
		list-style: none;
		display: flex;
		justify-content: center;
		padding: 0;
	}
	
	.bar{
		color : lightgray;
	}
	
	.sns_login {
		list-style: none;
		padding: 0;
	}
	.member_login{
		color : #ff4d54;
	}
	.admin_login {
		color : #289828;
	}
	
</style>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.0.0/kakao.min.js"
  integrity="sha384-PFHeU/4gvSH8kpvhrigAPfZGBDPs372JceJq3jAXce11bVA6rMvGWzvP4fMQuBGL" crossorigin="anonymous"></script>


</head>
<body>
	
	<div class="log_container">
		<header class="log_header">
			<br>
			<br>
			<br>
				<a href="<%=request.getContextPath() %>/main.do"> <img alt="챌린저스 로고" src="<%=request.getContextPath() %>/uploadFile/logo_standard.svg" width="250"> </a>
			<br>
			<br>
			<hr width="80%" color="#ff4d54">
						<h1 class="login_title"><a class="member_login" href="#">회원 로그인</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a class="admin_login" href="admin_login.do">관리자 로그인</a></h1>
		</header>
		
		<article class="log_content">
				<form class="log_form" method="post" action="<%=request.getContextPath() %>/member_login_ok.do">
					<div class="input_text">
						<input class="input_text1" type="text" name="mem_id" placeholder=" 아이디">
						<br>
						<input class="input_text2" type="password" name="mem_pwd" placeholder=" 비밀번호">
					</div>
					<br>
					<br>
					<input class="input_btn" type="submit" value="로그인">
				</form>
	
				<ul class="find_join">
					<li><a href="<%=request.getContextPath() %>/member_findPwd.do">비밀번호 찾기&nbsp;</a></li>
					<li><b class="bar">|</b><a href="<%=request.getContextPath() %>/member_findId.do">&nbsp;아이디 찾기&nbsp;</a></li>
					<li><b class="bar">|</b><a href="<%=request.getContextPath() %>/member_join.do">&nbsp;회원가입</a></li>
				</ul>
				
				<ul class="sns_login">
					<li><a href="https://kauth.kakao.com/oauth/authorize?client_id=617a393522b6cb65ea54d2ed4350878e&redirect_uri=http://localhost:8282/Semi_Challengers/member_kakaoLoginOk.do&response_type=code&scope=account_email,gender,birthday" ><img alt="카카오 로그인" src="<%=request.getContextPath() %>/uploadFile/kakao_login_medium_narrow.png"></a></li>
					<li><a href="">네이버로 시작</a></li>
				</ul>
				
				
		</article>
	</div>
	</body>
	
</html>
	