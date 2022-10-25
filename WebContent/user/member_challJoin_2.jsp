<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>2/5 : 챌린지 개설</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	

</script>
<style type="text/css">
	.innerText {
		text-align: left;
	}
</style>
</head>
<body>
	<jsp:include page="../include/chall_top.jsp" />
		<div align="center">
			<form action="member_challJoin_3.do" method="post">
			<h3><b>어떤 챌린지를 만드시겠어요?</b></h3> <br>
			<h6>마지막 단계에서 수정하기 어려우니 신중히 골라주세요!</h6>
			<hr width="50%" color="red">
			<br>
			<%-- <c:set var="test" value="${Test }"/>
			<a>Oracle Cloud - CHALLENGE_CATEGORY 테이블에 있는 자료 : ${test }</a> --%>
			
			<input type="radio" class="btn-check" name="openRadio" id="open-outlined" autocomplete="off" value="open">
			<label class="btn btn-outline-success" for="open-outlined"><b>&nbsp;&nbsp;공개 챌린지🙌</b>
			<br>&nbsp;여러 사람들이 모여 서로를 응원하고&nbsp;
			<br>도전을 자극하는 챌린지</label>
			
			<br><br>
			
			<input type="radio" class="btn-check" name="openRadio" id="private-outlined" value="private" autocomplete="off">
			<label class="btn btn-outline-danger" for="private-outlined"><b>비공개 챌린지🔒</b>
			<br>친구들끼리 모여 프라이빗하게 챌린지
			<br>(초대받은 사람만 참여할 수 있어요)</label>
			
			<br><br><br>
			<button type="submit" class="btn btn-dark">다음</button>
			</form>
		</div>
		<br>
   		<div class="progress">
  			<div class="progress-bar" role="progressbar" aria-label="Example with label" style="width: 3%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">0 %</div>
		</div>
		<br>
	<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>