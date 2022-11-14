<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>Private 챌린지 코드 확인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(function() {
		$("#code").keyup(function() {
			let privateCode = $("#code").val();
			$.ajax({
				type : "post",
				url : "challParticipate/privateCodeCheck.jsp",
				data : {paramCode : privateCode},
				datatype : "jsp",
				success : function(data) {
					if(data == 1) {  // 등록된 비공개 코드와 일치하는 경우
						const ok_btn = document.getElementById("ok");
						ok_btn.disabled = false;
					}else {
						const ok_btn = document.getElementById("ok");
						ok_btn.disabled = true;
					}
				},
				
				error : function(data) {
					alert("데이터 통신 오류");
				}
			});
		});
	});
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

	#code {
    	width: 15%;
    }
</style>
</head>
<body>
   <jsp:include page="/include/chall_top.jsp" />
		<div align="center">
			<hr class="join_hr" width="50%" color="red">
			<h3>비공개 챌린지입니다. 참여코드를 입력해주세요.</h3>
			<hr class="join_hr" width="50%" color="red">
			<br>
			
			
			<input class="form-control" name="code" id="code" placeholder="참여코드 입력">
			<span id="CodeCheck"></span>
			<hr width="50%" color="red">
			<br>
			<button type="button" class="btn btn-dark" onclick="history.back()">이전</button>
			<button id="ok" type="button" class="btn btn-dark" onclick="location.href='member_challContent.do?CodeOk=1'" disabled>확인</button>
		</div>
   <jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>