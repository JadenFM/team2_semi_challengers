<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	//day1
	String pattern1_DB = "YYYYMMdd"; SimpleDateFormat simpleDateFormat1_DB = new SimpleDateFormat(pattern1_DB);
	Calendar cal1 = Calendar.getInstance();	String day1_DB = simpleDateFormat1_DB.format(cal1.getTime());
	String pattern1_out = "MM.dd (E)"; SimpleDateFormat simpleDateFormat1_out = new SimpleDateFormat(pattern1_out);
	String day1_out = simpleDateFormat1_out.format(cal1.getTime());
	// day2
	String pattern2_DB = "YYYYMMdd"; SimpleDateFormat simpleDateFormat2_DB = new SimpleDateFormat(pattern2_DB);
	Calendar cal2 = Calendar.getInstance();	cal2.add(Calendar.DAY_OF_MONTH, 1);	String day2_DB = simpleDateFormat2_DB.format(cal2.getTime());
	String pattern2_out = "MM.dd (E)"; SimpleDateFormat simpleDateFormat2_out = new SimpleDateFormat(pattern2_out);
	String day2_out = simpleDateFormat2_out.format(cal2.getTime());
	// day3
	String pattern3_DB = "YYYYMMdd"; SimpleDateFormat simpleDateFormat3_DB = new SimpleDateFormat(pattern3_DB);
	Calendar cal3 = Calendar.getInstance();	cal3.add(Calendar.DAY_OF_MONTH, 2);	String day3_DB = simpleDateFormat3_DB.format(cal3.getTime());
	String pattern3_out = "MM.dd (E)"; SimpleDateFormat simpleDateFormat3_out = new SimpleDateFormat(pattern3_out);
	String day3_out = simpleDateFormat3_out.format(cal3.getTime());
	// day4
	String pattern4_DB = "YYYYMMdd"; SimpleDateFormat simpleDateFormat4_DB = new SimpleDateFormat(pattern4_DB);
	Calendar cal4 = Calendar.getInstance();	cal4.add(Calendar.DAY_OF_MONTH, 3);	String day4_DB = simpleDateFormat4_DB.format(cal4.getTime());
	String pattern4_out = "MM.dd (E)"; SimpleDateFormat simpleDateFormat4_out = new SimpleDateFormat(pattern4_out);
	String day4_out = simpleDateFormat4_out.format(cal4.getTime());
	// day5
	String pattern5_DB = "YYYYMMdd"; SimpleDateFormat simpleDateFormat5_DB = new SimpleDateFormat(pattern5_DB);
	Calendar cal5 = Calendar.getInstance();	cal5.add(Calendar.DAY_OF_MONTH, 4);	String day5_DB = simpleDateFormat5_DB.format(cal5.getTime());
	String pattern5_out = "MM.dd (E)"; SimpleDateFormat simpleDateFormat5_out = new SimpleDateFormat(pattern5_out);
	String day5_out = simpleDateFormat5_out.format(cal5.getTime());
	// day6
	String pattern6_DB = "YYYYMMdd"; SimpleDateFormat simpleDateFormat6_DB = new SimpleDateFormat(pattern6_DB);
	Calendar cal6 = Calendar.getInstance();	cal6.add(Calendar.DAY_OF_MONTH, 5);	String day6_DB = simpleDateFormat6_DB.format(cal6.getTime());
	String pattern6_out = "MM.dd (E)"; SimpleDateFormat simpleDateFormat6_out = new SimpleDateFormat(pattern6_out);
	String day6_out = simpleDateFormat6_out.format(cal6.getTime());
	// day7
	String pattern7_DB = "YYYYMMdd"; SimpleDateFormat simpleDateFormat7_DB = new SimpleDateFormat(pattern7_DB);
	Calendar cal7 = Calendar.getInstance();	cal7.add(Calendar.DAY_OF_MONTH, 6);	String day7_DB = simpleDateFormat7_DB.format(cal7.getTime());
	String pattern7_out = "MM.dd (E)"; SimpleDateFormat simpleDateFormat7_out = new SimpleDateFormat(pattern7_out);
	String day7_out = simpleDateFormat7_out.format(cal7.getTime());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>3/5 : 챌린지 개설</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/jquery-3.6.1.js"></script>
<script type="text/javascript">
onload = function() {
	
	if('${open}' == 'admin') {
		$("#tempSave_btn").hide();
	}
	const target = document.getElementById('ok');
	$("#title_text_check").hide();
	$('#title').keyup(function(){
		if($.trim($("#title").val()).length >= 3 && $.trim($("#guide").val()).length >= 15) {
			target.disabled = false;
		} else {
			target.disabled = true;
		}
		
	    let content = $(this).val();
	    $('#title_text_count').text("( "+content.length+" / 30 )");
	    
	    $("#title_text_check").hide();
		let userId = $("#title").val();
		if($.trim($("#title").val()).length > 0 && $.trim($("#title").val()).length < 3) {
			$("#title_text_check").show();
			return false;
		}
	});
	$("#guide_text_check").hide();
	$('#guide').keyup(function(){
		if($.trim($("#title").val()).length >= 3 && $.trim($("#guide").val()).length >= 15) {
			target.disabled = false;
		} else {
			target.disabled = true;
		}
		
	    let content = $(this).val();
	    $('#guide_text_count').text("( "+content.length+" / 100 )");
	    
	    $("#guide_text_check").hide();
		let userId = $("#guide").val();
		if($.trim($("#guide").val()).length > 0 && $.trim($("#guide").val()).length < 15) {
			$("#guide_text_check").show();
			return false;
		}
	});
	$('#cont').keyup(function(){
	    let content = $(this).val();
	    $('#cont_text_count').text("( "+content.length+" / 100 )");
	});
	
}
// 이미지 미리보기 메서드
function previewFile1() { 
    var preview = document.querySelector('#image_success'); 
    var file = document.querySelector('#image_success_input').files[0]; 
    var reader  = new FileReader(); 
    reader.onloadend = function () { 
          preview.src = reader.result; 
   } 
   if (file) { 
         reader.readAsDataURL(file); 
     } else { 
         preview.src = ""; 
  } 
} 
function previewFile2() { 
    var preview = document.querySelector('#image_fail'); 
    var file = document.querySelector('#image_fail_input').files[0]; 
    var reader  = new FileReader(); 
    reader.onloadend = function () { 
          preview.src = reader.result; 
   } 
   if (file) { 
         reader.readAsDataURL(file); 
     } else { 
         preview.src = ""; 
  } 
}
function previewFile3() { 
    var preview = document.querySelector('#image_cont'); 
    var file = document.querySelector('#image_cont_input').files[0]; 
    var reader  = new FileReader(); 
    reader.onloadend = function () { 
          preview.src = reader.result; 
   } 
   if (file) { 
         reader.readAsDataURL(file); 
     } else { 
         preview.src = ""; 
  } 
}
// 이미지 미리보기 메서드 end

// 파일 5개 이상 업로드 방지 메서드
 
/*var // Define maximum number of files.
  max_file_number = 3,
  // Define your form id or class or just tag.
  $form = $('#form'), 
  // Define your upload field class or id or tag.
  $file_upload = $('#file3', $form), 
  // Define your submit class or id or tag.
  $button = $('#submit', $form); 

  // Disable submit button on page ready.
  $button.prop('disabled', 'disabled');

  $file_upload.on('change', function () {
    var number_of_images = $(this)[0].files.length;
    if (number_of_images > max_file_number) {
      alert(`You can upload maximum ${max_file_number} files.`);
      $(this).val('');
      $button.prop('disabled', 'disabled');
    } else {
      $button.prop('disabled', false);
    }
  });*/
//파일 5개 이상 업로드 방지 메서드 end

</script>
<style type="text/css">
	.join_hr {
		border: 0;
    	height: 3px;
    	background: #ff4d54;
    	opacity: 100;
	}
	.required {
		color: red;
		font-size: 20px;
		font-weight: bold;
	}
	.category {
		font-size: 20px;
		font-weight: bold;
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
    #title {
    	width: 15%;
    }
    #guide {
    	width: 30%;
    }
    #cont {
    	width: 30%;
    }
</style>
</head>
<body>
	<c:if test="${open=='admin'}">
		<jsp:include page="/include/admin_top.jsp" />
	</c:if>
	<c:if test="${open!='admin'}">
   		<jsp:include page="/include/chall_top.jsp" />
   </c:if>
		<div align="center">
			<br>
			<h3><b>챌린지를 만들어주세요!</b></h3>
			<hr class="join_hr" width="50%" color="red">
			<br>

    
    		<form id="form" method="post" enctype="multipart/form-data">
    		
			<!-- 필수항목 --><span class="category">챌린지 제목</span><span class="required">*</span><br>
  			<input class="form-control" name="title" maxlength="30" id="title" placeholder="예) 1만보 걷기"><span id="title_text_count">( 0 / 30 )</span><br>
			<span id="title_text_check" style="color: red">최소 3글자 이상 입력해주세요.</span>
			
			
			<br><br>
			<!-- 필수항목 --><span class="category">인증 빈도</span><span class="required">*</span><br>
			<!-- (후순위) 인증 빈도에 따라 시작일과 설명 문구 변경해줘야 함 -->
			<input type="radio" class="btn-check" name="cycle" id="option1" value="매일" autocomplete="off" checked>
			<label class="btn btn-secondary" for="option1">매일</label>
			<input type="radio" class="btn-check" name="cycle" id="option2" value="평일 매일" autocomplete="off">
			<label class="btn btn-secondary" for="option2">평일 매일</label>
			<input type="radio" class="btn-check" name="cycle" id="option3" value="주말 매일" autocomplete="off">
			<label class="btn btn-secondary" for="option3">주말 매일</label>
			<input type="radio" class="btn-check" name="cycle" id="option4" value="주 1일" autocomplete="off">
			<label class="btn btn-secondary" for="option4">주 1일</label>
			<input type="radio" class="btn-check" name="cycle" id="option5" value="주 2일" autocomplete="off">
			<label class="btn btn-secondary" for="option5">주 2일</label>
			<input type="radio" class="btn-check" name="cycle" id="option6" value="주 3일" autocomplete="off">
			<label class="btn btn-secondary" for="option6">주 3일</label>
			<input type="radio" class="btn-check" name="cycle" id="option7" value="주 4일" autocomplete="off">
			<label class="btn btn-secondary" for="option7">주 4일</label>
			<input type="radio" class="btn-check" name="cycle" id="option8" value="주 5일" autocomplete="off">
			<label class="btn btn-secondary" for="option8">주 5일</label>
			<input type="radio" class="btn-check" name="cycle" id="option9" value="주 6일" autocomplete="off">
			<label class="btn btn-secondary" for="option9">주 6일</label>
			
			
			<br><br>
			<!-- 필수항목 --><span class="category">챌린지 기간</span><span class="required">*</span><br>
				<input type="radio" class="btn-check" name="duration" id="duRadio1" autocomplete="off" value="1" checked>
				<label class="btn btn-secondary" for="duRadio1">1주 동안</label>
			<c:forEach begin="2" end="8" var="i">
				<input type="radio" class="btn-check" name="duration" id="duRadio${i }" autocomplete="off" value="${i }">
				<label class="btn btn-secondary" for="duRadio${i }">${i }주 동안</label>
			</c:forEach>
			
			
			<br><br>
			<!-- 필수항목 --><span class="category">시작일</span><span class="required">*</span><br>
			<input type="radio" class="btn-check" name="startDate" id="staDateRadio1" value="<%=day1_DB %>" autocomplete="off" checked>
			<label class="btn btn-secondary" for="staDateRadio1"><%=day1_out %></label>
			<input type="radio" class="btn-check" name="startDate" id="staDateRadio2" value="<%=day2_DB %>" autocomplete="off">
			<label class="btn btn-secondary" for="staDateRadio2"><%=day2_out %></label>
			<input type="radio" class="btn-check" name="startDate" id="staDateRadio3" value="<%=day3_DB %>" autocomplete="off">
			<label class="btn btn-secondary" for="staDateRadio3"><%=day3_out %></label>
			<input type="radio" class="btn-check" name="startDate" id="staDateRadio4" value="<%=day4_DB %>" autocomplete="off">
			<label class="btn btn-secondary" for="staDateRadio4"><%=day4_out %></label>
			<input type="radio" class="btn-check" name="startDate" id="staDateRadio5" value="<%=day5_DB %>" autocomplete="off">
			<label class="btn btn-secondary" for="staDateRadio5"><%=day5_out %></label>
			<input type="radio" class="btn-check" name="startDate" id="staDateRadio6" value="<%=day6_DB %>" autocomplete="off">
			<label class="btn btn-secondary" for="staDateRadio6"><%=day6_out %></label>
			<input type="radio" class="btn-check" name="startDate" id="staDateRadio7" value="<%=day7_DB %>" autocomplete="off">
			<label class="btn btn-secondary" for="staDateRadio7"><%=day7_out %></label>
			
			<!-- 선택한 시작일과 챌린지 기간을 실시간으로 텍스트로 보여주기 -->
			
			<br><br>
			<!-- 필수항목 --><span class="category">인증 방법</span><span class="required">*</span><br>
  			<textarea class="form-control" name="guide" cols="55" rows="3" id="guide" maxlength="100" placeholder="예) 오늘 날짜와 걸음 수가 적힌 만보기 캡쳐 화면 업로드"></textarea><span id="guide_text_count">( 0 / 100 )</span>
  			<br>
  			<span id="guide_text_check" style="color: red">최소 15글자 이상 입력해주세요.</span>
  			<br>
  			<a>* 챌린지가 시작되면 인증 방법을 수정할 수 없습니다. 신중히 작성해주세요. <br>
  			* 참가자들이 혼란을 겪지 않도록 정확한 기준과 구체적인 인증방법을 적어주세요. <br>
  			* 유저 챌린지에서 발생한 분쟁에는 챌린저스가 관여하지 않습니다.</a>
  			
  			
  			<br><br>
			<span class="category">인증샷 예시</span><br>
			<table>
			  <tr>
			    <td>
				<input type='text' name="success_img" id='success_img' style='display: none;'> 
				<img id="image_success" src='<%=request.getContextPath()%>/uploadFile/regi_shot_success.jpg' height="300" width="300" border="2" onclick='document.all.successImgFile.click(); document.all.success_img.value=document.all.successImgFile.value' class="rounded mx-auto d-block">
			    </td>
			    <td>
				<input type='text' name="fail_img" id='fail_img' style='display: none;'> 
				<img id="image_fail" src='<%=request.getContextPath()%>/uploadFile/regi_shot_fail.jpg' height="300" width="300" border="2" onclick='document.all.failImgFile.click(); document.all.fail_img.value=document.all.failImgFile.value' class="rounded mx-auto d-block">
				</td>
			  <tr>
			  <tr align="center">
			  	<td>O</td>
			  	<td>X</td>
			  </tr>
			  <tr>
			  	<td><input type="file" name="successImgFile" id="image_success_input" accept="image/jpg, image/jpeg, image/png, image/gif"
			  	onchange="previewFile1()" style='display: none;'></td>
			  	<td><input type="file" name="failImgFile" id="image_fail_input" accept="image/jpg, image/jpeg, image/png, image/gif"
			  	onchange="previewFile2()" style='display: none;'></td>
			  </tr>
			</table>
			
			
			<br><br>
			<!-- 필수항목 --><span class="category">인증 가능 시간</span><span class="required">*</span><br>
			<table>
				<tr align="center">
					<td>시작 시간</td>
					<td>종료 시간</td>
				</tr>
				<tr>
					<td><input name="startTime" type="time" value="00:00"></td>
					<td><input name="endTime" type="time" value="23:59"></td>
				</tr>
			</table>
			
			
			<br><br>
			<span class="category">챌린지 소개</span><br>
			<a>사진과 글을 추가해 챌린지를 소개해보세요. <br>
  			혹시 알아요 리더님의 글에 반해서 의지가 불타오를지!</a><br>
  			<textarea class="form-control" name="cont" cols="55" rows="3" id="cont" maxlength="100" placeholder="예) 매일 1만보 걷고 건강해지기! 오늘부터 같이 해봐요 :)"></textarea>
  			<br>
  			<span id="cont_text_count">( 0 / 100 )</span>
			
			<br><br>
			<span class="category">소개 사진 올리기</span><br>
			<input type='text' name="cont_img" id='cont_img' style='display: none;'> 
			<img id="image_cont" src='<%=request.getContextPath()%>/uploadFile/regi_shot_fail.jpg' height="150" width="150" border="2" onclick='document.all.contImgFile.click(); document.all.cont_img.value=document.all.contImgFile.value' class="rounded mx-auto d-block">
			<input type="file" name="contImgFile" id="image_cont_input" accept="image/jpg, image/jpeg, image/png, image/gif"
			  	onchange="previewFile3()" style='display: none;'>
			
			
			<br><br>
			<button type="button" class="btn btn-dark" onclick="history.back()">이전</button>
			<!-- <button id="tempSave_btn" type="submit" class="btn btn-secondary" formaction="member_challJoin_3_save.do">임시저장</button> -->
			<c:choose>
				<c:when test="${open=='admin'}">
					<button id="ok" type="submit" class="btn btn-dark" formaction="admin_challJoin_2.do" disabled>다음</button>
				</c:when>
				<c:otherwise>
					<button id="ok" type="submit" class="btn btn-dark" formaction="member_challJoin_4.do" disabled>다음</button>
				</c:otherwise>
			</c:choose>
		</form>
		</div>
		
		<br>
   		<div class="progress">
  			<div class="progress-bar" role="progressbar" aria-label="Example with label" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25 %</div>
		</div>
		<br>
   <jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>