<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function() {
		$(".findId_btn").click(function() {
			let admin_name = $("#nameInput").val();
			let admin_phone = $("#phoneInput").val();
			$.ajax({
				type : "post",
				url : "admin/find_id_ajax.jsp",
				data : {
					admin_name : admin_name,
					admin_phone : admin_phone
				},
				datatype : "xml",
				success : function(data) {
					let table = "";
					$(data).find("aaa").each(function(){
						console.log($(this).find("result").text());
						if($(this).find("result").text() != "none"){
							$("#search_btn11").hide();
							$(".typing_name").css("color","#289828");
							$(".typing_name").text($(this).find("result").text()+"개의 아이디를 발견하였습니다.");
							$(data).find("member_email").each(function(){
								console.log($(this).find("admin_name").text());
								console.log($(this).find("admin_id").text());
								table += "<br><div class='textbox2'><br><label for='email'>이메일</lable><br>";
								table += "<input class='inputBox' id='emailInput' name='email' readonly value="+$(this).find("admin_email").text()+">";
								table += "<input type='hidden' name='name' value="+$(this).find("admin_name").text()+">";
								table += "</div>"
								table += "<input type='hidden' name='id' value="+$(this).find("admin_id").text()+"><br>";
							 })
							 table += "<input type='submit' class='findId_btn' value='메일 발송'>";
							$(".typing_name").after(table);
						}else{
							$(".typing_name").css("color","red");
							$(".typing_name").text("아이디가 존재하지 않습니다.");
							$(".typing_name").after();
						}
					})
				},
				error : function() {
					alert("에러 발생")
				}
			})
		})
	})
</script>
<style type="text/css">

	body {
	 width: 100vw;
	 height: 100vh;
	 margin : 0;
	}	
	
	/* 비밀번호 찾기 페이지 위치 잡기 */
	/* 아이디/비밀번호 찾기 페이지 공통 위치 start */	
	
	.findId_container{
		display: grid;
		place-items: center;
		grid-template-columns: 20% 60% 20%;
		grid-template-rows: 300px 100px 50px 400px 50px;
	}
	.log_container {
		grid-column: 2/3;
		grid-row: 1/2;
		text-align: center;
		width: 542px;
	}
	.login_title{
		font-size: 25px;
	}

	.findId_top{
		grid-column: 2/3;
		grid-row: 2/3;
		align-items: center;
	}
	
	.findId_top ul{
		display: inline-block;
		width: 100%;
		list-style: none;
		padding: 0px;
		margin: 0px;
		line-height: 50px;		
	}
	
	.findId {
		display: inline-block;
		width: 200px;
		height: 50px;
		text-align: center;
		background-color:#289828;
	}
	
	.findPwd {
		display: inline-block;
		width: 200px;
		height: 50px;
		text-align: center;
		border-left: 1px solid lightgray;
	}
	
	.findId_top a{
		text-decoration: none;
		display:block;
		width: 200px;
		height: 50px;
		color: #000;
		font-size: 20px;
		
	}
	/* 아이디/비밀번호 찾기 페이지 공통 위치  end */
		
	
	.findId_container h2{
		grid-column: 2/3;
		grid-row: 3/4;
	}
	
	.findId_content{
		grid-column: 2/3;
		grid-row: 4/5;
		
	}
	
	.findId_form{
		display: grid;
		place-items: center;
		grid-template-columns: 5% 90% 5%;
		grid-template-rows: repeat(4,110px);	
	}
	
	.findId_content label{
		font-weight: bold;
		text-align: left;
	}
	
	.inputBox{
		margin: 0px;
		width: 300px;
		height: 50px;
		border: 1px solid lightgray;
		padding: 0px 0px 0px 15px;
		border-radius: 5px;
	}
	.inputBox_phone{
	margin: 0px;
		width: 300px;
		height: 50px;
		border: 1px solid lightgray;
		padding: 0px 0px 0px 15px;
		border-radius: 5px;
	}
	
	.textbox1{
		grid-column: 2/3;
		grid-row: 2/3;	
		margin-bottom: 20px;	
	}
	
	.textbox2{
		grid-column: 2/3;
		grid-row: 3/4;	
		margin-bottom: 20px;	
	}
	
	.textbox3{
		grid-column: 2/3;
		grid-row: 4/5;	
		margin-bottom: 20px;	
	}
	
	.findId_btn{
		grid-column: 2/3;
		grid-row: 5/6;	
		width: 317.22px;
		height: 50px;	
		border: 0;
		color: white;
		font-size: 20px;
		font-weight: bold;
		background-color: #289828;
		border-radius: 5px;
		cursor: pointer;
	}
	
	
</style>
</head>
<body>
	<c:set var="content" value="${content }"/>
	<div class="findId_container">
	<div class="log_container">
		<header class="log_header">
			<br>
			<br>
			<br>
				<a href="<%=request.getContextPath() %>/main.do"> <img alt="챌린저스 로고" src="<%=request.getContextPath() %>/uploadFile/challengers_manager_logo.png" width="250"> </a>
			<br>
			<br>
			<hr width="80%" color="#289828">
			<h1 class="login_title">관리자 로그인</h1>
		</header>
	</div>
		<nav class="findId_top">
			<ul>
				<li class="findId"><a href="#">아이디 찾기</a></li> 
				<li class="findPwd"><a href="<%=request.getContextPath() %>/admin_find_pwd.do">비밀번호 찾기</a></li>
			</ul>
		</nav>
		<h2>아이디 찾기</h2>
		<article class="findId_content">
		<form method="post" action="<%=request.getContextPath() %>/mail.Send.do">
			<div class="textbox1">
		  		<label for="text">이  름</label>
		  		<br>
		  		<input class="inputBox" id="nameInput" name="admin_name" required>
		 	</div>
		 	<div class="textbox2">
		  		<label for="text">연락처</label>
		  		<br>
		  		<input class="inputBox_phone" id="phoneInput" name="admin_phone" required placeholder="&#39;-&#39;없이 입력해주세요.">
		   		<br><span class="typing_name"></span>
		 	</div>
			<input type="button" id="search_btn11" class="findId_btn" value="검 색">					
		</form>
		</article>
	</div>
</body>
</html>