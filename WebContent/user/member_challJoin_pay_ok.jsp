<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<style type="text/css">
	.join_hr {
		border: 0;
    	height: 1px;
    	background: #ff4d54;
    	opacity: 100;
	}
	/* 부트스트랩 적용 후 바뀌는 부분 조절(include) */      
   .container{
    margin-right: 0px;
    margin-left: 0px;   
    max-width: 100%;
    padding: 0px;
    box-sizing: content-box;
      }
   
    .search_text{
   box-sizing:content-box;
    }
    
    .rogoImg{
   box-sizing: content-box;
    }
    
    .top{
   margin: 16px 0px 16px 0px; 
    }
    
    .menu li{
    box-sizing: content-box;
    }
/* 부트스트랩 적용 후 바뀌는 부분(include) end */
</style>
</head>
<body>
	<jsp:include page="/include/chall_top.jsp" />
		<div align="center">
		<h5><b>개설이 완료되었습니다👏<br>
		앞으로 챌린지를 잘 부탁드려요!</b></h5>
		
		<br><br>
		<img id="image" height="300" width="300" border="2" src="<%=request.getContextPath()%>/memUpload/${challContent.getChall_mainImage() }" class="rounded mx-auto d-block">
		<br>
		<h6><b>${challContent.getChall_title() }</b></h6>
		인증빈도 : ${challContent.getChall_cycle() } <br>
		챌린지 기간 : ${challContent.getChall_duration() }주
		
		<br><br>
		<hr class="join_hr" width="20%" color="red">
		<span>참가 예치금</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><%=request.getAttribute("depositOriginal") %></span>원<br>
		<span>사용한 보유 예치금</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-<span><%=request.getAttribute("depositMinus") %></span>원<br>
		<span>충전 금액</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><%=request.getAttribute("payFinal") %></span>원<br>
		
		<br><br><br>
		<button class="btn btn-dark" onclick="location.href='member_challProof.do'">인증하러 가기</button>
		</div>
	<jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>