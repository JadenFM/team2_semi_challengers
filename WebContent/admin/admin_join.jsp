<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

//주소 폼
//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.

// 선택한 이메일 도메인 셀렉트 박스의 value를 input 창의 value로 넣어주는 함수.
function chageDomainSelect(){
   
    $("#email_domain").val($("#input_domain").val());
    
} // chageDomainSelect() 함수 end


// 문서의 body 부분 읽고 제이쿼리 실행.
$(function(){
   
   /* 필수 입력값 */
   let idFlag = false;
   let pwdFlag = false;
   let nameFlag = false;
   let birthFlag = false;
   let emailFlag = false;
   let phoneFlag = false;
   let addrFlag = false;
   
   
   $(".error").hide();
   
   /* 공통 함수 start*/       
   // 에러메세지를 띄우는 함수
   function showMsg(msgDiv,msg){
          msgDiv.text(msg);
          msgDiv.css('color','red');
          msgDiv.show();
   }    
   
   // 에러메세지를 숨기는 함수
   function hideMsg(msgDiv){
          msgDiv.hide();              
   }    
      
      // 유효성 에러 메세지 띄우는 함수.
    function showSuccessMsg(obj, msg) {
        obj.attr('class', 'error_next_box');   // 클래스 속성값 변경
        obj.css('color','green');
        obj.html(msg);
        obj.show();
    }

    // 입력창 아래에 성공 메세지 띄우는 함수.
    function showSuccessMsg2(obj, msg) {
        obj.attr("class", "error_next_box green");
        obj.html(msg);
        obj.show();
    }   // showSuccessMsg() 함수 end
   
   /* 공통함수 end */
   
   
   // 입력창 포커스가 사라질 때 필수값, 유효성 검사.
   $("#id").blur(function() {
      checkId();
   });
    
   // '아이디' 입력창 검사
   function checkId(){
       let inputId = $("#id");
       let msgDiv = $("#idDiv");
       let msg = "필수입력입니다.";
          
         if (inputId.val() == ""){   
            /* showMsg(msgDiv,msg); */
        	 $("#idDiv").css("color","red");
             $("#idDiv").text("필수 입력사항입니다.");
         }else{
            // 아이디 유효성 검사
      // 아이디를 서버로 전송 > 유효성 검사 > 결과 반환 받기
      $.ajax({
         type: 'POST',  // http 요청 방식 (default: ‘GET’)
         async : false ,
         url: '<%=request.getContextPath()%>/admin_joinCheckId.do',   
         // 요청이 전송될 URL 주소, 서블릿으로 보내기
         dataType:'json',  // 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
         data: {id: $("#id").val()} ,  // 요청 시 포함되어질 데이터.(아이디를 서버로 전송)
         success: function(res){   // 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
            console.log(res.count);
            // 입력받은 아이디가 DB 회원 테이블에 존재하면 1, 존재하지 않으면 0
            if(res.count > 0){
               $("#idDiv").css("color","red");
               $("#idDiv").text("이미 존재하는 아이디입니다.");
            }else{
               showSuccessMsg(msgDiv, "멋진 아이디네요!");
            }
         },
         error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
            alert('ajax 응답 오류');
         }
      });   // $.ajax() end
      
       return false;               
         
         }      
   }   // checkRePwd() 함수 end   
   
   $("#pwd").blur(function() {
	      checkPwd();
	   });
    // '비밀번호1' 입력창 검사
   function checkPwd(){
       let inputPwd = $("#pwd");
      /*  let msgDiv = $("#idDiv");
       let msg = "필수입력입니다.";
       //let oMsg = $("#rePwdMsg"); */
       let pwdReg = /^[A-Za-z0-9`\-=\\\[\];',\./~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{8,16}$/; 
          
         if (inputPwd.val() == ""){   
            /* showMsg(msgDiv,msg); */
        	 $("#idPwd").css("color","red");
             $("#idPwd").text("필수 입력사항입니다.");
         }else{
            // 비밀번호 유효성 검사
            if(!pwdReg.test(inputPwd.val())){
               /* showMsg(msgDiv,"8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요."); */
            	$("#idPwd").css("color","red");
                $("#idPwd").text("8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.");
               
            }else {
            	$("#idPwd").css("color","green");
                $("#idPwd").text("멋진 비밀번호네요!");
               /* showErrorMsg(msgDiv, "멋진 비밀번호네요!"); */
            }
         }      
   }   // checkRePwd() 함수 end   
   
   $("#admin_pwd2").blur(function() {
	   checkRePwdCheck();
	   });
   // '비밀번호 재설정 확인' 입력창 검사
   function checkRePwdCheck(){
       let inputPwd_Check = $("#admin_pwd2");
       /* let msgDiv = $("#rePwdCheckMsg");
       let msg = "필수입력입니다."; */
       
         if (inputPwd_Check.val() == ""){   
        	 $("#idPwd_1").css("color","red");
             $("#idPwd_1").text("필수 입력사항입니다.");
         }else{
            // 비밀번호 확인 유효성 검사
            if(inputPwd_Check.val() !== $("#pwd").val() ){
            	$("#idPwd_1").css("color","red");
                $("#idPwd_1").text("비밀번호가 일치하지 않습니다.");
            }else {
            	$("#idPwd_1").css("color","green");
                $("#idPwd_1").text("비밀번호가 일치합니다!.");
               /* hideMsg(msgDiv);
               showErrorMsg(msgDiv, "비밀번호가 일치합니다!"); */
            /* $("#rePwdOk_btn").css('background-color','#ff4d54');
            $("#rePwdOk_btn").css('cursor','pointer');
            $("#rePwdOk_btn").attr({disabled:false});   */            
            }       
      }     
   }
});
   
    
</script>
<style type="text/css">

	body {
	 width: 100vw;
	 height: 100vh;
	 margin : 0;
	}
	
	/* 회원가입 페이지 위치 잡기 */	
	.join_container{
		display: grid;
		place-items: center;
		grid-template-columns: 20% 60% 20%;
		grid-template-rows: 300px 50px 50px 500px 100px;
	}
	.log_container {
		grid-column: 2/3;
		grid-row: 1/2;
		text-align: center;
		width: 542px;
	}
	h2 {
		margin: 0px;
		grid-column: 2/3;
		grid-row: 3/4;	
	}
	
	.join_form{
		grid-column: 2/3;
		grid-row: 4/5;	
		width: 460px;
	}
	
	/* 회원가입 페이지 CSS */	
	.join_title{
		font-size: 17px;
		font-weight: bolder;
		text-align: left;
		margin-top: 25px;
		margin-bottom: 5px;
		border-radius: 5px;
	}
	
	.input_box {
		width: 442.778px;
		height: 50px;
		border: 1px solid lightgray;
		padding: 0px 0px 0px 15px;
		border-radius: 5px;
	} 
	
	.input_select {
		width: 460px;
		height: 50px;
		border: 1px solid lightgray;
		padding: 0px 0px 0px 15px;
		border-radius: 5px;	
	}
	
	.input_box_email1 {
		width: 130.9px;
		height: 50px;
		border: 1px solid lightgray;
		padding: 0px 0px 0px 15px;
		border-radius: 5px;
	}
	
	.input_box_1 {
		margin-top: 10px;
		margin-bottom: 10px;
		width: 322px;
		height: 50px;
		border: 1px solid lightgray;
		padding: 0px 0px 0px 15px;
		border-radius: 5px;
	}
	
	
	.btn_mini {
		width: 115px;
		height: 50px;
		border: 0;
		color: white;
		border-radius: 5px;
		background-color: #289828;
		cursor: pointer;
	}
	
	.input_box_addr {
		margin: 0px 0px 10px 0px;
		width: 209.97px;
		height: 50px;
		border: 1px solid lightgray;
		padding: 0px 0px 0px 15px;
		border-radius: 5px;
	}
	
	.btn_join {
		width: 460px;
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

	<article class="join_container">
	<div class="log_container">
		<header class="log_header">
			<br>
			<br>
			<br>
				<a href="<%=request.getContextPath() %>/main.do"> <img alt="챌린저스 로고" src="<%=request.getContextPath() %>/uploadFile/challengers_manager_logo.png" width="250"> </a>
			<br>
			<br>
			<hr width="80%" color="#289828">
			<h1 class="login_title">관리자 회원가입</h1>
		</header>
	</div>
	<form class="join_form" method="post" action="<%=request.getContextPath() %>/admin_join_OK.do">		
		<div class="join_id">		
			<h3 class="join_title">아이디</h3>
			<input class="input_box" type="text" name="admin_id" id="id">
			<span id="idDiv"></span>
		</div>
		
		<!-- 비밀번호 입력 -->
		<div class="join_pwd">						
			<h3 class="join_title">비밀번호</h3>
			<input class="input_box" type="password" name="admin_pwd" id="pwd">
			<span id="idPwd"></span>
			<h3 class="join_title">비밀번호 확인</h3>
			<input class="input_box" type="password" id="admin_pwd2">
			<span id="idPwd_1"></span>
		</div>	
		
		<!-- 이름 입력 -->
		<div class="join_name">
			<h3 class="join_title">이름</h3>
			<input class="input_box" type="text" name="admin_name" id="name">
		</div>
		
		<!-- 이메일 입력 -->
		<div class="join_email">
			<h3 class="join_title">이메일</h3>
			<input class="input_box_email1" type="text" id="email_id" name="admin_email_head"> @ 								
			<input class="input_box_email1" type="text" id="email_domain" name="admin_email_body" value="${dto.emailDomain }">
			<select class="input_box_email1" id="input_domain" onchange="chageDomainSelect()" >
					<option >--선택--</option>
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="yahoo.com">yahoo.com</option>
					<option value="nate.com">nate.com</option>
					<option value="">직접입력</option>
			</select>
		</div>
		
		<!-- 전화번호 입력 -->
		<div class="join_mobile">
	                    	<h3 class="join_title">휴대전화</h3>
			<input class="input_box" type="tel" id="phoneNo" name="admin_phone" placeholder="&#39;-&#39;없이 입력해주세요." maxlength="11">
		</div>
		<br>
        <br>
        <div class="btn">
        	<input type="submit" class="btn_join" value="가입하기">
        </div>
        <div>
	        <br>
	        <br><br>
	        <br>
        </div>
		<!-- <th>아이디</th>
		<td><input name="admin_id"> <br> <span
			id="id_check"></span></td>
		<th>비밀번호</th>
		<td><input type="password" name="admin_pwd" ></td>
		<th>비밀번호 확인</th>
		<td><input type="password" > <span></span></td>
		<th>이 름</th>
		<td><input name="admin_name" ></td>
		<th>나 이</th>
		<td><input name="admin_age" ></td>
		<th>주 소</th>
		<td><input name="admin_addr" ></td>
		<th>연 락 처</th>
		<td><input name="admin_phone" ></td>
			<input type="submit" value="가입하기">
			<input type="reset" value="다시작성"> -->
	</form>
	</article>
</body>
</html>
