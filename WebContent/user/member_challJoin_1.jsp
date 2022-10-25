<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>1/5 : 챌린지 개설</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	function check() {
	  // Get the checkbox
	  let checkBox1 = document.getElementById("promise1");
	  let checkBox2 = document.getElementById("promise2");
	  let checkBox3 = document.getElementById("promise3");

	  if (checkBox1.checked == true && checkBox2.checked == true && checkBox3.checked == true){
		 location.href="member_challJoin_2.do";
	  } else {
		 location.href="#";
	  }
	}
	
</script>
</head>
<body>
   <jsp:include page="/include/chall_top.jsp" />
		<div align="center">
			<hr width="50%" color="red">
			<h3>챌린지 개설하기</h3>
			<hr width="50%" color="red">
			<br>
			
			<h3> 챌린지를 여는 이 순간부터, 당신은 챌린지를 이끌어나갈 '리더'가 됩니다^^</h3> <br>
			<h5>그 전에 3가지만 약속해주세요!</h5>
			<br><br><br>
			
			<label><input type="checkbox" class="promise" id="promise1">모두에게 기분 좋은 챌린지가 되도록 노력해주실거죠?</label><br><br><br>
			<label><input type="checkbox" class="promise" id="promise2">참가자들의 의지와 예치금이 모일 챌린지에요. 책임감 있게 관리해주실 수 있죠?</label><br><br><br>
			<label><input type="checkbox" class="promise" id="promise3">공정한 인증샷 검토를 부탁드릴게요!</label>
			<h6>유저가 개설한 챌린지의 인증샷 검토를 챌린저스에서 하지 않아요. 챌린지를 개설한 리더가 직접 검토해요.</h6>
			<br>
			<hr width="50%" color="red">
			<br>
			<button type="button" class="btn btn-dark" onclick="check()">네, 약속할게요!</button>
		</div>
   <jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>