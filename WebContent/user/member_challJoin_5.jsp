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
<script type="text/javascript">
	
	function display(){
		
	    var categoryCode = document.getElementsByName("categoryCode");
	    for(i=0; i<categoryCode.length; i++){
	        if(categoryCode[i].checked == true){
	        	switch(categoryCode[i].value) {
	    		case "C001" :
	    			document.getElementById("image_main").src = "<%=request.getContextPath()%>/uploadFile/run.jpg"; 
	    			break;
	    		case "C002" :
	    			document.getElementById("image_main").src = "<%=request.getContextPath()%>/uploadFile/food.jpg"; 
	    			break;
	    		case "C003" :
	    			document.getElementById("image_main").src = "<%=request.getContextPath()%>/uploadFile/life.jpg"; 
	    			break;
	    		case "C004" :
	    			document.getElementById("image_main").src = "<%=request.getContextPath()%>/uploadFile/mind.jpg"; 
	    			break;
	    		case "C005" :
	    			document.getElementById("image_main").src = "<%=request.getContextPath()%>/uploadFile/hobby.jpg"; 
	    			break;
	    		case "C006" :
	    			document.getElementById("image_main").src = "<%=request.getContextPath()%>/uploadFile/eco.jpg"; 
	    			break;
	    		case "C008" :
	    			document.getElementById("image_main").src = "<%=request.getContextPath()%>/uploadFile/공부_코딩-이모지1.jpg"; 
	    			break;
	    		default :
	    			document.getElementById("image_main").src = "<%=request.getContextPath()%>/uploadFile/etc.jpg";
	    		}
	        }
	    }
	}
	
    function previewFile1() { 
        var preview = document.querySelector('#image_main'); 
        var file = document.querySelector('#image_main_input').files[0]; 
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
    
    onload = function() {
    	if('${open}' == 'admin') {
			$("#tempSave_btn").hide();
		}
    	var keyword1 = document.getElementById("kw1"); keyword1.style.display = 'none';
    	var keyword2 = document.getElementById("kw2"); keyword2.style.display = 'none';
    	var keyword3 = document.getElementById("kw3"); keyword3.style.display = 'none';
    	
    	let kwAdd_btn = document.getElementById("kwAdd_btn");
    	kwAdd_btn.onclick = function() {
    		if(keyword1.style.display == 'none'){
    			keyword1.style.display = 'block';
    		}else if(keyword1.style.display == 'block' && keyword2.style.display == 'none'){
    			keyword2.style.display = 'block';
    		}else if(keyword1.style.display == 'block' && keyword2.style.display == 'block' && keyword3.style.display == 'none'){
    			keyword3.style.display = 'block';
    		}else { }
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
    
    .form-control{
    width: 5%;
    }
/* 부트스트랩 적용 후 바뀌는 부분(include) end */
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
			<h3><b>이제 다 왔어요! 사람들이 쉽게 찾을 수 있게 완성해주세요!</b></h3>
			<hr class="join_hr" width="50%" color="red">
			<br>
			<c:choose>
				<c:when test="${open=='admin'}">
					<form id="form" method="post" enctype="multipart/form-data" action="admin_challJoin_final.do">
				</c:when>
				<c:otherwise>
					<form id="form" method="post" enctype="multipart/form-data">
				</c:otherwise>
			</c:choose>
			
			
			<h5>카테고리 선택</h5><!-- 필수항목 -->
			<a>어느 카테고리에 챌린지를 노출할까요?</a>
			<br>
			<c:if test="${!empty categoryList }">
				<c:forEach items="${categoryList }" var="dto" varStatus="i" begin="0" end="0">
					<input type="radio" class="btn-check" name="categoryCode" id="cateListRadio${i.index }" autocomplete="off" value="C001" onclick="display()" checked>
					<label class="btn btn-secondary" for="cateListRadio${i.index }">${dto.getCategory_name() }</label>
				</c:forEach>
				<c:forEach items="${categoryList }" var="dto" varStatus="i" begin="1">
					<input type="radio" class="btn-check" name="categoryCode" id="cateListRadio${i.index }" autocomplete="off" value="C00${i.index+1 }" onclick="display()">
					<label class="btn btn-secondary" for="cateListRadio${i.index }">${dto.getCategory_name() }</label>
				</c:forEach>
			</c:if>
			
  			
  			<br><br>
			<h5>대표사진</h5>
			<a>챌린지를 잘 설명할 수 있는 사진으로 선택해주세요. 멋진 썸네일은 인기의 비결!</a><br>
			
			<input type='text' name="main_img" id='main_img' style='display: none;'> 
			<img id="image_main" src='<%=request.getContextPath()%>/uploadFile/run.jpg' height="200" width="200" border="2" onclick='document.all.mainImgFile.click(); document.all.main_img.value=document.all.mainImgFile.value' class="rounded mx-auto d-block">
			<input type="file" name="mainImgFile" id="image_main_input" accept="image/jpg, image/jpeg, image/png, image/gif"
			  	onchange="previewFile1()" style='display: none;'>
			<!-- 미리보기 사진 위에 '사진선택'글자 반투명하게 오버랩시켜줘야 함 -->
			
			
			<br><br>
			<h5>검색 키워드 입력</h5>
			<a>어떻게 검색하면 챌린지를 찾을 수 있게 할까요? (최대 3개)</a><br>
			<!-- 키워드 입력창 삭제 버튼 만들어야 함 -->
			<input class="btn btn-info" type="button" id="kwAdd_btn" value="+ 추가하기">
			<span id="kw1"><input class="form-control" name="keyword1" placeholder="입력" class="add_btn" style="width:7%;"></span>
			<span id="kw2"><input class="form-control" name="keyword2" placeholder="입력" class="add_btn" style="width:7%;"></span>
			<span id="kw3"><input class="form-control" name="keyword3" placeholder="입력" class="add_btn" style="width:7%;"></span>
			
			
			
			<br><br>
			<button type="button" class="btn btn-dark" onclick="history.back()">이전</button>
			<!-- <button id="tempSave_btn" type="submit" class="btn btn-secondary" formaction="member_challJoin_5_save.do">임시저장</button> -->
			<button id="next" type="submit" class="btn btn-dark" formaction="member_challJoin_final.do">챌린지 개설하기</button>
			</form>
		</div>
		<br>
   		<div class="progress">
  			<div class="progress-bar" role="progressbar" aria-label="Example with label" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">75 %</div>
		</div>
		<br>
   <jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>