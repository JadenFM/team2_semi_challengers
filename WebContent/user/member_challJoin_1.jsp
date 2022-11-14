<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.removeAttribute("chall_num");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>1/5 : 챌린지 개설</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src = "moment-with-locales.js"></script>
<script type="text/javascript">
	function check() {
		 location.href="member_challJoin_2.do";
	}
		
	onload = function() {
		let checkBox1 = document.getElementById("promise1");
		let checkBox2 = document.getElementById("promise2");
		let checkBox3 = document.getElementById("promise3");
		const target = document.getElementById('ok');
		// for문 왜 안먹지...
		/* for(let i=1; i<=3; i++) {
			checkBox+i.onclick = function() {
				if (checkBox1.checked == true && checkBox2.checked == true && checkBox3.checked == true){
					const target = document.getElementById('ok');
					 target.disabled = false;
				} else {
					const target = document.getElementById('ok');
					 target.disabled = true;
				}
			}
		} */
		
		checkBox1.onclick = function() {
			if (checkBox1.checked == true && checkBox2.checked == true && checkBox3.checked == true){
				 target.disabled = false;
			} else {
				 target.disabled = true;
			}
		}
		checkBox2.onclick = function() {
			if (checkBox1.checked == true && checkBox2.checked == true && checkBox3.checked == true){
				 target.disabled = false;
			} else {
				 target.disabled = true;
			}
		}
		checkBox3.onclick = function() {
			if (checkBox1.checked == true && checkBox2.checked == true && checkBox3.checked == true){
				 target.disabled = false;
			} else {
				 target.disabled = true;
			}
		}
	}
</script>
<style type="text/css">

	.join_hr {
		border: 0;
    	height: 3px;
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
			<hr class="join_hr" width="50%" color="red">
			<h3>챌린지 개설하기</h3>
			<hr class="join_hr" width="50%" color="red">
			<br>
			
			<h4><b>챌린지를 여는 이 순간부터, 당신은 챌린지를 이끌어나갈 '리더'가 됩니다😊</b></h4> <br>
			<h5>그 전에 3가지만 약속해주세요! </h5>
			<br><br><br>
			
			<label><input type="checkbox" class="promise" id="promise1"><b>모두에게 기분 좋은 챌린지가 되도록 노력해주실거죠?</b></label><br><br><br>
			<label><input type="checkbox" class="promise" id="promise2"><b>참가자들의 의지와 예치금이 모일 챌린지에요. 책임감 있게 관리해주실 수 있죠?</b></label><br><br><br>
			<label><input type="checkbox" class="promise" id="promise3"><b>공정한 인증샷 검토를 부탁드릴게요!</b></label>
			<h6>유저가 개설한 챌린지의 인증샷 검토를 챌린저스에서 하지 않아요. 챌린지를 개설한 리더가 직접 검토해요.</h6>
			<br>
			<hr width="50%" color="red">
			<br>
			<button id="ok" type="button" class="btn btn-dark" onclick="check()" disabled>네, 약속할게요!</button>
		</div>
   <jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>