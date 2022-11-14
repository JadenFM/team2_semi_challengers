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
      grid-template-columns: 1fr 3fr 1fr;
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
   
   #nameDiv, #emailDiv{
      width: 317px;
   }
   
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
   

   $(function(){
      
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
      
       $("#nameInput").blur(function(){
          checkName();
       });
       
      /* 공통함수 end */       
      // '이름' 입력창 검사
      function checkName(){
          let inputId = $("#nameInput");
          let msgDiv = $("#nameDiv");
          let msg = "필수입력입니다.";
          let nameReg = /^[가-힣a-zA-Z]+$/;
             
            if (inputId.val() == ""){   
               showMsg(msgDiv,msg);
            }else{
               // 이름 유효성 검사
               if(!nameReg.test(inputId.val())){
                  showMsg(msgDiv,"한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)")
               }else {
                  hideMsg(msgDiv);
                  showSuccessMsg(msgDiv,  inputId.val()+"님 이메일도 입력해 주세요!");
                  nameFlag = true;   // 이름 유효성 검사 통과
               }                  
         
          return false;               
            
            }                        
      }   // checkName() 함수 end 
      
      // ajax로 컨트롤러에 회원의 이메일 주소를 전송하는 함수
      $("#findId_btn").click(function(){

         $.ajax({
            type: 'POST',  // http 요청 방식 (default: ‘GET’)
            async : false ,
            url: '<%=request.getContextPath()%>/checkIdAndEmail.do',   // 요청이 전송될 URL 주소
            dataType: 'json',  // 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
            data: {"name":$("#nameInput").val(), "email":$("#emailInput").val() } ,  // 요청 시 포함되어질 데이터.(아이디를 서버로 전송)
            success: function(res){   // 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
               
               if(res.mem_id){
               alert('회원님의 아이디는 '+ res.mem_id +' 입니다.');
               }else{
                  alert('입력하신 이메일에 해당하는 아이디가 없습니다.');
               }
               // $("#frm").submit();
            },
            error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
               alert('ajax 응답 오류');
            }
         });   // $.ajax() end
         
      });
      
      

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
         <%-- <form id="frm" class = "findId_form" action="<%=request.getContextPath() %>/member_findIdCheck.do" method="post"> --%>
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
               <input type="button" class="findId_btn" id="findId_btn"  value="아이디찾기">
         <!-- </form> -->
      </article>   
      </div>
   <jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>