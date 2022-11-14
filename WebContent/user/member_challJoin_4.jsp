<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>4/5 : 챌린지 개설</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	onload = function() {
		if('${open}' == 'admin') {
			$("#tempSave_btn").hide();
		}
		const target = document.getElementById('ok');
	    let depositMaxTextArea = document.getElementById("depositMaxTextArea"); 	
	    let depositMaxCont = document.getElementById("depositMaxCont");
		depositMaxTextArea.style.display = 'none';
		depositMaxCont.style.display = 'none';
		$('#depositDefault').on('change', function() {	// 고정 예치금일 경우(default)
			let n = $(this).val();
		     n = Math.floor(n/1000) * 1000;
		     $(this).val(n);
		     if(Number($(this).val()) > 200000) { // 최대 200,000원 제한
		    	 $(this).val(200000);
		     }
		});
		
		let checkBox = document.getElementById("deposit");
		checkBox.onclick = function() {
			if (checkBox.checked == true){	// 고정 예치금 설정으로 변경했을 때
				depositMaxTextArea.style.display = 'none';
				depositDefaultCont.style.display = 'block';
				depositMaxCont.style.display = 'none';
				//let n = $('#depositDefault').val();  // 1,000원 단위로 입력되게 하기(체크박스 다시 체크 시)
			    //n = Math.floor(n/1000) * 1000;
			    $('#depositDefault').val(1000);
				$('#depositDefault').on('change', function() { // 1,000원 단위로 입력되게 하기
					let n = $(this).val();
				     n = Math.floor(n/1000) * 1000;
				     $(this).val(n);
				     if(Number($(this).val()) > 200000) { // 최대 200,000원 제한
				    	 $(this).val(200000);
				     }
				});
			} else {	// 최대 예치금 설정으로 변경했을 때
				depositMaxTextArea.style.display = 'block';
				depositDefaultCont.style.display = 'none';
				depositMaxCont.style.display = 'block';
			    $('#depositDefault').val(10000);
			    $('#depositMax').val(200000);
				$('#depositDefault').on('change', function() { // 10,000원 단위로 입력되게 하기
					 let n = $(this).val();
				     n = Math.floor(n/10000) * 10000;
				     $(this).val(n);
				     if(Number($(this).val()) > 200000) { // 최대 200,000원 제한
				    	 $(this).val(200000);
				     }
				});
				$('#depositMax').on('change', function() { // 10,000원 단위로 입력되게 하기
					 let n = $(this).val();
				     n = Math.floor(n/10000) * 10000;
				     $(this).val(n);
				     // depositDefault보다 작으면 depositDefault + 10,000원
				     if(Number($('#depositDefault').val()) > Number($(this).val())) {
				    	 $(this).val(Number($('#depositDefault').val())+10000);
				     }
				     if(Number($(this).val()) > 200000) { // 최대 200,000원 제한
				    	 $(this).val(200000);
				     }
				});
			}
		}
		
		let maxPeopleCont = document.getElementById("maxPeopleCont");
		let maxPeopleTextArea = document.getElementById("maxPeopleTextArea");
		let maxPeople = document.getElementById("flexSwitchCheckDefault");
		maxPeopleCont.style.display = 'none';
		maxPeopleTextArea.style.display = 'none';
		maxPeople.onclick = function() {
			$('#maxPeopleInput').on('change', function() {
			     if(Number($(this).val()) > 1000) { // 최대 예치금 제한
			    	 $(this).val(1000);
			     }
			     if(Number($(this).val()) < 2) { // 최소 예치금 제한
			    	 $(this).val(2);
			     }
			});
			if (maxPeople.checked == true){
				maxPeopleCont.style.display = 'block';
				maxPeopleTextArea.style.display = 'block';
				$('#maxPeopleInput').val(50);
			} else {
				maxPeopleCont.style.display = 'none';
				maxPeopleTextArea.style.display = 'none';
				$('#maxPeopleInput').val('');
			}
		}
		let code = document.getElementById("private_code");	
		
	    if('${open}'=='private'){		
	    	code.style.display = 'block';
	    }else{	
	    	code.style.display = 'none';
	    	target.disabled = false;
	    }
	    
		$('#code').keyup(function(){
    			target.disabled = false;
    		if($("#code").val() == '') {
    			target.disabled = true;
    		} else {
    			target.disabled = false;
    		}
    	});
	}
</script>
<style type="text/css">

	.join_hr {
		border: 0;
    	height: 3px;
    	background: #ff4d54;
    	opacity: 100;
	}
	
	.form-check {
		width: 0%;
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
    
    #depositDefault{
    width: 5%;
    display: inline;
    }
    #depositMaxTextArea{
    display: inline;
    }
    #depositMax{
    width: 6%;
    display: inline;
    }
    #code{
    width: 15%;
    display: inline;
    }
    #maxPeopleInput{
    width: 4%;
    display: inline;
    }
/* 부트스트랩 적용 후 바뀌는 부분(include) end */
	
</style>
</head>
<body>
   <jsp:include page="/include/chall_top.jsp" />
   
		<div align="center">
			<br>
			<h3><b>이 챌린지에 참여하기 위한 조건은 무엇인가요?</b></h3>
			<hr class="join_hr" width="50%" color="red">
			
			
			<form id="form" method="post">
			<h5><b>예치금</b></h5><!-- 필수항목 -->
			<div id="depositDefaultCont"><a>고정 예치금은 최소 1천원부터 가능합니다.(천원 단위 가능)</a></div>
			<div id="depositMaxCont"><a>최소 1만원 ~ 최대 20만원 (만원 단위 가능)</a></div>
			<input type="checkbox" id="deposit" checked>고정 예치금
			<br>
			<input class="form-control" id="depositDefault" name="depositDefault" value="1000" size="4">원
			<div id="depositMaxTextArea">~
			<input class="form-control" id="depositMax" name="depositMax" size="4">원</div>
			
  			
  			<div id="private_code">
  			<br><br><!-- 비공개 챌린지에만 나타나는 항목 -->
			<h5><b>비공개 참여 코드</b></h5><!-- 필수항목 -->
			<a>프라이빗한 챌린지를 위해, 우리만의 코드를 정해보세요.</a><br>
			<input class="form-control" type="text" name="privateCode" width="10" id="code" placeholder="예) 1234, 우리는챌린저스">
			</div>
			
			
			<br><br>
			<h5><b>최대 모집 인원 설정하기</b></h5>
			참가자 모집 인원을 제한하고 싶은 경우 설정할 수 있어요. 
			<div class="form-check form-switch">
			  <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
			</div>
			<div id="maxPeopleCont">(최소 2명 ~ 최대 1,000명)</div>
			<div id="maxPeopleTextArea"><input class="form-control" id="maxPeopleInput" name="maxPeople" size="2">명 </div>
			
			
			<br><br>
			<button type="button" class="btn btn-dark" onclick="history.back()">이전</button>
			<!-- <button id="tempSave_btn" type="submit" class="btn btn-secondary" formaction="member_challJoin_4_save.do">임시저장</button> -->
			<c:choose>
				<c:when test="${open=='admin'}">
					<button id="ok" type="submit" class="btn btn-dark" formaction="admin_challJoin_3.do" disabled>다음</button>
				</c:when>
				<c:otherwise>
					<button id="ok" type="submit" class="btn btn-dark" formaction="member_challJoin_5.do" disabled>다음</button>
				</c:otherwise>
			</c:choose>
			</form>
		</div>
		<br>
   		<div class="progress">
  			<div class="progress-bar" role="progressbar" aria-label="Example with label" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">50 %</div>
		</div>
		<br>
   <jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>