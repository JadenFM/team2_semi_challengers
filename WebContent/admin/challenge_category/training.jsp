<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src="<%=request.getContextPath() %>/admin/challenge.js"></script>
<script type="text/javascript">
	$(function(){
		$("#2").css('color','black');
		$("#1,#3,#4,#5,#6,#7,#8,#9,#10").css('color','lightgray');
	});
</script>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/admin/challenge.css">
<style type="text/css">
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
</style>
</head>
<body>
	<jsp:include page="../../include/admin_top.jsp" />
	<jsp:include page="../include_chall_search.jsp" />
		<div class="header2">
			<div class="h_bottom">
				<ul class="list">
					<a href="challenge_control.do"><li id="1"><b>전체<b>
									<div class="h_underline"></div></li></a>
					<a href="training_list.do?category_code=C001"><li id="2"><b>운동<b>
									<div class="h_underline"></div></li></a>
					<a href="eating_list.do?category_code=C002"><li id="3"><b>식습관<b>
									<div class="h_underline"></div></li></a>
					<a href="life_list.do?category_code=C003"><li id="4"><b>생활<b>
									<div class="h_underline"></div></li></a>
					<a href="mind_list.do?category_code=C004"><li id="5"><b>정서<b>
									<div class="h_underline"></div></li></a>
					<a href="hobby_list.do?category_code=C005"><li id="6"><b>취미<b>
									<div class="h_underline"></div></li></a>
					<a href="environment_list.do?category_code=C006"><li id="7"><b>환경&펫<b>
									<div class="h_underline"></div></li></a>
					<a href="etc_list.do?category_code=C007"><li id="8"><b>기타<b>
									<div class="h_underline"></div></li></a>
					<a href="study_list.do?category_code=C008"><li id="9"><b>공부<b>
									<div class="h_underline"></div></li></a>
					<a href="selfcare_list.do?category_code=C009"><li id="10"><b>셀프케어<b>
									<div class="h_underline"></div></li></a>
				</ul>
			</div>
		</div>
		<div class="asd"></div>
	<div id="body">
		<div class="con">
			<c:set var="list" value="${list }" />
			<div class="all">
				<c:forEach items="${list }" var="dto">
					<c:if test="${!empty dto.chall_mainimage  }">
				<div class="alll">
					<a class="block"
						href="<%=request.getContextPath()%>/challenge_modify.do?chall_num=${dto.chall_num}&chall_category=선택&page=${page}"><img
						src="<%=request.getContextPath() %>/uploadFile/${dto.chall_mainimage }"
						width="64" height="54"> <br>
					<br>
						<h2>${dto.chall_title }</h2> <br> <span class="tkdtpqhrl">
							상세보기 + </span></a>
				</div>
				</c:if>
				<c:if test="${empty dto.chall_mainimage  }">
				<div class="alll">
					<a class="block"
						href="<%=request.getContextPath()%>/challenge_modify.do?chall_num=${dto.chall_num}&chall_category=선택&page=${page}"><img
						src="<%=request.getContextPath() %>/uploadFile/admin/없음.png"
						width="64" height="54"> <br>
					<br>
						<h2>${dto.chall_title }</h2> <br> <span class="tkdtpqhrl">
							상세보기 + </span></a>
				</div>
				</c:if>
				</c:forEach>
				</ul>
			</div>
		</div>
		<br>
		<br>
		<br>
		<br>
		<nav>
			<ul class="pagination">
				<li class="page-item"><a class="page-link"
					href="training_list.do?page=1&category_code=C001">First</a></li>
				<c:if test="${page == 1 }">
		    <li>
		      <a class="page-link" 
		      		href="training_list.do?page=1&category_code=C001">Previous</a>
		    </li>
		    </c:if>
		    <c:if test="${page != 1 }">
		    <li>
		      <a class="page-link" 
		      		href="training_list.do?page=${page - 1 }&category_code=C001">Previous</a>
		    </li>
		    </c:if>
				<c:forEach begin="${startBlock }" end="${lastBlock }" var="i">

					<c:if test="${i == page }">
						<li class="page-item active" aria-current="page"><a
							class="page-link" href="training_list.do?page=${i }&category_code=C001">${i }</a></li>
					</c:if>

					<c:if test="${i != page }">
						<li class="page-item"><a class="page-link"
							href="training_list.do?page=${i }&category_code=C001">${i }</a></li>
					</c:if>
				</c:forEach>

				<c:if test="${lastBlock < allPage }">
					<li class="page-item"><a class="page-link"
						href="training_list.do?page=${page + 1 }&category_code=C001">Next</a></li>
					<li class="page-item"><a class="page-link"
						href="training_list.do?page=${allPage }&category_code=C001">End</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
	<div class="pagination_search"></div>
	<jsp:include page="../../include/chall_bottom.jsp" />
</body>
