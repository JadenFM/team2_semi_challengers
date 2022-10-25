<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>5/5 : 챌린지 개설</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<style type="text/css">

	.join_hr {
		border: 0;
    	height: 3px;
    	background: #ff4d54;
    	opacity: 100;
	}
	
</style>
</head>
<body>
   <jsp:include page="/include/chall_top.jsp" />
   
		<div align="center">
			<br>
			<h3><b>챌린지 개설 최종 페이지</b></h3>
			<hr class="join_hr" width="50%" color="red">
			<br>
			[session값]<br>
			공개여부 : ${open }<br>
			제목 : ${title }<br>
			인증빈도 : ${cycle }<br>
			챌린지 기간 : ${duration }<br>
			시작일 : ${startDate }<br>
			인증방법 : ${guide }<br>
			인증샷 성공 예시 이미지 : ${success_img }<br>
			인증샷 실패 예시 이미지 : ${fail_img }<br>
			인증 가능 시간_시작 : ${startTime }<br>
			인증 가능 시간_종료 : ${endTime }<br>
			챌린지 소개 : ${cont }<br>
			소개 이미지 : ${discript_imgs } <br>
			예치금(기본) : ${depositDefault }<br>
			예치금(최대) : ${depositMax }<br>
			비공개 코드 : ${privateCode }<br>
			최대 참여 인원 : ${maxPeople }<br>
			카테고리 : ${categoryName}<br>
			메인 이미지 : ${mainImgFile }<br>
			키워드 : ${keyword }<br><br><br>
		</div>
		<br>
   		<div class="progress">
  			<div class="progress-bar" role="progressbar" aria-label="Example with label" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">75 %</div>
		</div>
		<br>
   <jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>