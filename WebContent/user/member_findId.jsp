<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린저스 : 아이디 찾기</title>
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
		grid-template-rows: 100px 50px 1fr 50px;
	}

	.findId_top{
		grid-column: 2/3;
		grid-row: 1/2;
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
		background-color:#ff4d54;
	}
	
	.findPwd {
		display: inline-block;
		width: 200px;
		height: 50px;
		text-align: center;
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
		grid-row: 2/3;
	}
	
	.findId_content{
		grid-column: 2/3;
		grid-row: 3/4;
		
	}
	
	.findId_form{
		display: grid;
		place-items: center;
		grid-template-columns: 5% 90% 5%;
		grid-template-rows: repeat(3,1fr);	
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
	
	.textbox1{
		grid-column: 2/3;
		grid-row: 1/2;	
		margin-bottom: 20px;	
	}
	
	.textbox2{
		grid-column: 2/3;
		grid-row: 2/3;	
		margin-bottom: 20px;	
	}
	
	.findId_btn{
		grid-column: 2/3;
		grid-row: 3/4;	
		width: 317.22px;
		height: 50px;	
		border: 0;
		color: white;
		font-size: 20px;
		font-weight: bold;
		background-color: #ff4d54;
		border-radius: 5px;
		cursor: pointer;
	}
	
	.bar {
		font-size:30px;
		color: lightgray; 
	}
	
</style>
<script type="text/javascript">
	

	$(function(){
    	
    	

	});

</script>
</head>
<body>
<!-- member_findIdOk.do 로 넘어가기-->
	<jsp:include page="../include/chall_top.jsp" />
	<div class="findId_container">
	
		<!-- 아이디 찾기/ 비밀번호 찾기 공통 영역 start-->
		<nav class="findId_top">
			<ul>
				<li class="findId"><a href="#">아이디 찾기</a></li>
				<span class="bar">|</span> 
				<li class="findPwd"><a href="<%=request.getContextPath() %>/user/member_findPwd.jsp">비밀번호 찾기</a></li>
			</ul>
		</nav>
		<!-- 아이디 찾기/ 비밀번호 찾기 공통 영역 end-->
		
		<h2>아이디 찾기</h2>
		<article class="findId_content">
			<form class = "findId_form" action="<%=request.getContextPath() %>/member_findIdCheck.do" method="post">
				<div class="textbox1">
			  		<label for="text">이  름</label>
			  		<br>
			  		<input class="inputBox" id="nameInput" name="name" required="" type="text" />
			   		<div class="error" id="nameDiv" ></div>
			 	</div>
			 				 	
				<div class="textbox2">
			  		<label for="email">이메일</label>
			  		<br>
			  		<input class="inputBox" id="emailInput" name="email"/>
			  	<div class="error" id="emailDiv"></div>
				</div>
			   	<input type="submit" class="findId_btn" value="아이디찾기">
			</form>
		</article>	
		</div>
	<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>