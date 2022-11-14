<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린저스 : 비밀번호 찾기2</title>
<style type="text/css">

   body {
    width: 100vw;
    height: 100vh;
    margin : 0;
   }   
   
   /* 비밀번호 찾기 페이지 공통 CSS start */
   /* 아이디/비밀번호 찾기 페이지 공통 위치 start */   
   .findPwd_container{
      display: grid;
      place-items: center;
      grid-template-columns: 1fr 2fr 1fr;
      grid-template-rows: 300px 100px 50px 80px 300px 50px;
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
   
   .findPwd_top{
      grid-column: 2/3;
      grid-row: 2/3;
      align-items: center;
   }
   
   .findPwd_top ul{
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
      
   }
   
   .findPwd {
      display: inline-block;
      width: 200px;
      height: 50px;
      text-align: center;
      background-color:#289828;
      
   }
   
   .findPwd_top a{
      text-decoration: none;
      display:block;
      width: 200px;
      height: 50px;
      color: #000;
      font-size: 20px;
      
   }
   /* 아이디/비밀번호 찾기 페이지 공통 위치  end */
   
   
   .index{
      justify-self: center;
      grid-column: 2/3;
      grid-row: 3/4;   
      border-top: 3px solid lightgray;
   }
      
   .index_ul{
      
      padding: 0px;
      list-style: none;
      display: grid;
      grid-template-columns: 140px 120px 145px;
      grid-template-rows: 50px;
      margin: 0px;      
   }
   
   .index_ul li{
      padding: 0px;
   }
   
   /* 단계 별로 색상 주기 */
   .index_ul li:nth-child(2){
      color:#289828;
   }
   
   .bar {
      font-size:30px;
      color: lightgray; 
   }   
      
   .arrow{
      color: lightgray;
      font-weight: bold;
   }   

   .find_title {
      grid-column: 2/3;
      grid-row: 4/5;
   }   

   .title_des{
      font-size: 14px;
      font-weight: normal;
      float: right;
   }   
   
   .findPwd_content{
      grid-column: 2/3;
      grid-row: 5/6;
      padding-top: 20px;
      border-top: 3px solid lightgray;
      
   }   /* 비밀번호 찾기 페이지 공통 CSS end */

   .input_label{
      font-size: 18px;
      font-weight: bold;
   }
   
   .inputBox{
      margin: 10px 10px 0px 0px;
      width: 300px;
      height: 50px;
      border: 1px solid lightgray;
      padding: 0px 0px 0px 15px;
      border-radius: 5px;
      float: left;
   }
   
   .form_area{
      grid-column: 2/3;
      grid-row: 3/4;   
   }
   
   .findPwdNext_btn_div{
      grid-column: 2/3;
      grid-row: 5/6;      
   }
   
   .findPwdNext_btn{
      margin-top: 20px;
      width: 417.22px;
      height: 50px;   
      border: 0;
      color: white;
      font-size: 20px;
      font-weight: bold;
      border-radius: 5px;
       background-color: lightgray;
      
      /* 인증번호 확인 시 */
      /* background-color: #289828; */
      /* cursor: pointer; */
   }   
   
   .authNo_btn{
      margin-top: 10px;
      width: 95px;
      height: 50px;   
      border: 0;
      color: white;
      font-size: 13px;
      font-weight: bold;
      background-color: #289828;
      border-radius: 5px;
      cursor: pointer;   
   }
   
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
$(function(){
   
   // '인증번호 전송' 버튼 클릭 시 함수
   $("#authNoSend_btn").click(function(){
      if ($("#emailInput").val() === ''){
         alert('이메일을 입력해 주세요.');
      }else{
         // 이메일을 서버로 전송 > 유효성 검사 > 결과 반환 받기
         $.ajax({
            type: 'POST',  // http 요청 방식 (default: ‘GET’)
            async : false ,
            url: '<%=request.getContextPath()%>/admin_getMemberEmail.do',      
            // 요청이 전송될 URL 주소
            dataType:'json',  // 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
            data: {mem_id: $("#mem_id").val()} ,  // 요청 시 포함되어질 데이터.(아이디를 서버로 전송)
            success: function(res){   // 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
               if($("#emailInput").val() === res.mem_email){
               let mem_email = res.mem_email;
               sendAuthNo(mem_email);
               }
               else{
                  alert('회원가입 시 입력한 이메일 주소와 일치하지 않습니다.');
               }
            },
            error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
               alert('ajax 응답 오류');
            }
         });   // $.ajax() end
         
          return false;
      }
      
   });   // '인증번호 전송' 버튼 클릭 시 함수 end
   
   // ajax로 컨트롤러에 회원의 이메일 주소를 전송하는 함수
   function sendAuthNo(mem_email){
      var emailData = { "mem_email": mem_email };
      $.ajax({
         type: 'POST',  // http 요청 방식 (default: ‘GET’)
         async : false ,
         url: '<%=request.getContextPath()%>/admin_findPwdEmailAuth.do',   // 요청이 전송될 URL 주소
         dataType: 'json',  // 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
         data: emailData ,  // 요청 시 포함되어질 데이터.(아이디를 서버로 전송)
         success: function(res){   // 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
            // 메일로 인증번호를 보내고 보낸 인증번호를 응답받음.
            alert('이메일이 일치합니다!\n입력하신 이메일 주소로 인증번호를 전송했습니다.\n인증번호를 확인해주세요.');
            let authNum = res.authNum;
            //alert('응답받은 인증번호'+authNum);
            
               // '인증번호 확인' 버튼 클릭 시 함수
               $("#authNoCheck_btn").click(function(){
                  
                  if(authNum == $("#authNoCheckInput").val() ){   //이메일로 전송한 인증번호와 입력한 인증번호가 일치하는 경우.
                     alert('인증번호가 일치합니다.\n다음 페이지에서 비밀번호를 재설정 해주세요.');
                     $("#findPwdNext_btn").css('background-color','#289828');
                     $("#findPwdNext_btn").css('cursor','pointer');
                     $("#findPwdNext_btn").attr({disabled:false});
                     
                  }else{
                     alert('인증번호가 일치하지 않습니다.');
                  }
                  
               });   // '인증번호 확인' 버튼 클릭 시 함수 end            
            
         },
         error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
            alert('ajax 응답 오류');
         }
      });   // $.ajax() end
   }   // sendAuthNo() 함수 end
   
});

</script>

</head>
<body>
   <%--자바스크립트에서 필요한 값 히든--%>
   
   <div class="findPwd_container">
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
   <!-- 아이디 찾기/ 비밀번호 찾기 공통 영역 start-->
      <nav class="findPwd_top">
         <ul>
            <li class="findId"><a href="<%=request.getContextPath() %>/admin_find_id.do">아이디 찾기</a></li> 
            <span class="bar">|</span>
            <li class="findPwd"><a href="#">비밀번호 찾기</a></li>
         </ul>
      </nav>
      <!-- 아이디 찾기/ 비밀번호 찾기 공통 영역 end-->
      <div class="index">
         <ul class="index_ul">
            <li>01. 아이디 입력<span class="arrow"> ></span></li>
            <li>02. 본인 확인<span class="arrow"> ></span></li>
            <li>03. 비밀번호 재설정</li>
         </ul>
      </div>   
      <h2 class="find_title">비밀번호 찾기</h2>
      <article class="findPwd_content">
         <div class="form_area">
            <form class="form" action="<%=request.getContextPath()%>/admin/admin_findPwd3.jsp" method="post">
           	 <input type="hidden" name="mem_id" id="mem_id" value="${param.get('admin_id')}">
                 <label class="input_label" for="text">이메일</label><span class="title_des">회원가입 시 입력한 이메일을 입력해 주세요.</span>
                 <br>
                 <input class="inputBox" id="emailInput" name="email" type="text" required />
                 <input type="button" id="authNoSend_btn" class="authNo_btn" value="인증번호 전송">
                 <br>
                 <br>
                 <label class="input_label" for="text">인증번호 확인</label><span class="title_des">이메일로 전송된 인증번호를 입력해 주세요.</span>
                 <br>
                 <input class="inputBox" id="authNoCheckInput" name="id" type="text" required />
                 <input type="button" id="authNoCheck_btn" class="authNo_btn" value="인증번호 확인">   
                <div class="findPwdNext_btn_div">
                   <input type="submit" id="findPwdNext_btn" class="findPwdNext_btn" value="다음" disabled="disabled">         
                </div>
             </form>
          </div>   
      </article>
   </div>
</body>
</html>