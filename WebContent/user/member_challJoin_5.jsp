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
		
	    var categoryName = document.getElementsByName("categoryName");
	    for(i=0; i<categoryName.length; i++){
	        if(categoryName[i].checked == true){
	        	switch(categoryName[i].value) {
	    		case "운동" :
	    			document.getElementById("mainImg").src = "<%=request.getContextPath()%>/uploadFile/run.png"; 
	    			break;
	    		case "식습관" :
	    			document.getElementById("mainImg").src = "<%=request.getContextPath()%>/uploadFile/food.png"; 
	    			break;
	    		case "생활" :
	    			document.getElementById("mainImg").src = "<%=request.getContextPath()%>/uploadFile/life.png"; 
	    			break;
	    		case "정서" :
	    			document.getElementById("mainImg").src = "<%=request.getContextPath()%>/uploadFile/mind.png"; 
	    			break;
	    		case "취미" :
	    			document.getElementById("mainImg").src = "<%=request.getContextPath()%>/uploadFile/hobby.png"; 
	    			break;
	    		case "환경" :
	    			document.getElementById("mainImg").src = "<%=request.getContextPath()%>/uploadFile/eco.png"; 
	    			break;
	    		default :
	    			document.getElementById("mainImg").src = "<%=request.getContextPath()%>/uploadFile/etc.png";
	    		}
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
	
</style>
</head>
<body>
   <jsp:include page="/include/chall_top.jsp" />
   
		<div align="center">
			<br>
			<h3><b>이제 다 왔어요! 사람들이 쉽게 찾을 수 있게 완성해주세요!</b></h3>
			<hr class="join_hr" width="50%" color="red">
			<br>
			<form id="form" method="post" action="member_challJoin_final.do">
			
			
			<h5>카테고리 선택</h5>
			<a>어느 카테고리에 챌린지를 노출할까요?</a>
			<br>
			<c:if test="${!empty categoryList }">
				<c:forEach items="${categoryList }" var="dto" varStatus="i">
					<input type="radio" class="btn-check" name="categoryName" id="cateListRadio${i.index }" autocomplete="off" value="${dto.getCategory_name() }" onclick="display()">
					<label class="btn btn-secondary" for="cateListRadio${i.index }">${dto.getCategory_name() }</label>
				</c:forEach>
			</c:if>
			
			
  			
  			<br><br>
			<h5>대표사진</h5>
			<a>챌린지를 잘 설명할 수 있는 사진으로 선택해주세요. 멋진 썸네일은 인기의 비결!</a><br>
			<br>
			<input type="file" name="mainImgFile">
			<img id="mainImg" alt="대표 사진" height="200" width="200" border="2" src="<%=request.getContextPath()%>/uploadFile/run.png" class="rounded mx-auto d-block">
			
			
			<br><br>
			<h5>검색 키워드 입력</h5>
			<a>어떻게 검색하면 챌린지를 찾을 수 있게 할까요? (최대 3개)</a><br>
			<button onclick="">+ 추가하기</button>
			<input name="keyword" placeholder="입력" class="add_btn" style="width:7%;">
			<input name="keyword" placeholder="입력" class="add_btn" style="width:7%;">
			<input name="keyword" placeholder="입력" class="add_btn" style="width:7%;">
			
			
			
			
			<br><br>
			<button type="button" class="btn btn-dark" onclick="history.back()">이전</button>
			<button type="submit" class="btn btn-dark">다음</button>
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