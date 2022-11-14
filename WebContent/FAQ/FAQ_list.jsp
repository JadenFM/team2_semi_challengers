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
<script type="text/javascript">
	$(function(){
		$("#1").css('color','black');
		$("#2,#3,#4").css('color','lightgray');
		
		$("#2").click(function(){						// 인증
			$("#2").css('color','black');
			$("#1,#3,#4").css('color','lightgray');
			$.ajax({
				type : "post",
				url : "/Semi_Challengers/certification_list.do",
				data : {faq_category_num : "1"},
				datatype : "html",
				success : function(data){
					$(".body").hide();
					$(".asd").html(data);
				},
				error : function(){
					alert("에러가 발생하였습니다.")
				}
			})
		})
		$("#3").click(function(){						// 결제
			$("#3").css('color','black');
			$("#1,#2,#4").css('color','lightgray');
			$.ajax({
				type : "post",
				url : "/Semi_Challengers/payment_list.do",
				data : {faq_category_num : "2"},
				datatype : "html",
				success : function(data){
					$(".body").hide();
					$(".asd").html(data);
				},
				error : function(){
					alert("에러가 발생하였습니다.")
				}
			})
		})
		$("#4").click(function(){						// 상금
			$("#4").css('color','black');
			$("#1,#2,#3").css('color','lightgray');
			$.ajax({
				type : "post",
				url : "/Semi_Challengers/prize_list.do",
				data : {faq_category_num : "3"},
				datatype : "html",
				success : function(data){
					$(".body").hide();
					$(".asd").html(data);
				},
				error : function(){
					alert("에러가 발생하였습니다.")
				}
			})
		})
		$("#1").click(function(){
			$("#1").css('color','black');
			$("#2,#3,#4").css('color','lightgray');
			$.ajax({
				type : "post",
				url : "/Semi_Challengers/all_list.do",
				datatype : "html",
				success : function(data){
					$(".body").hide();
					$(".asd").html(data);
				},
				error : function(){
					alert("에러가 발생하였습니다.")
				}
			})
		})

		$(".search").on('keyup',function(){
			let searching = $(".search").val();
			$.ajax({
				type : "post",
				url : "FAQ/FAQ_search.jsp",
				data : {keyword : searching},
				datatype : "xml",
				success : function(data){
					$(".body").hide();
					let table = "";
					$(".asd").text('');
					$(data).find("search").each(function(){
						if($(this).find("faq_category_num").text() == "1"){
							table += "<div class='all'><div class='dlswmd'><b> 인증 </b>";
						}
						else if($(this).find("faq_category_num").text() == "2"){
							table += "<div class='all'><div class='rufwp'><b> 결제 </b>";
						}
						else if($(this).find("faq_category_num").text() == "3"){
							table += "<div class='all'><div class='tkdrma'><b> 상금 </b>";
						}
						table += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						table += "<a href='<%=request.getContextPath()%>/FAQ_modify.do?faq_num=" + $(this).find("faq_num").text() + "'>";
						table += "Q. " + $(this).find("faq_title").text() + "</a> <br> </div> </div>";
					})
					$(".asd").append(table);
					
				},
				error : function(){
					alert("에러가 발생하였습니다.")
				}
			})
		})
	});
</script>
<style type="text/css">
	.all_container{
		margin-left: 20%;
	}
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
.pagination {
	justify-content: center;
}

#FAQ th {
	text-align: center;
}

#FAQ td {
	text-align: center;
}

#FAQ_title {
	color: black;
	font-weight: bold;
}

#FAQ_content {
	color: gray;
	font-weight: normal;
	font-family: monospace;
	font-size: 12px;
}

.header {
	background-color: #F6F7F9;
	height: 247px;
	padding: 60px 0px 30px;
}

.h_container {
	margin-left: 19%;
}

.h_container2 {
	border: none;
	width: 30px;
	display: inline-block;
	height: 66px;
	background-color: white;
	border-radius: 7px;
}

.search {
	width: 350px;
	height: 66px;
	font-size: 20px;
	border: none;
	border-radius: 7px;
	position: absolute;
}

img {
	margin-top: 20px;
}

.header2 {
	background-color: #F6F7F9;
}

.h_bottom {
	margin-left: 100px;
}

.list li {
	display: inline-block;
	width: 70px;
}

.list li b {
	margin-left: 15px;
}

.h_underline {
	margin-top: 20px;
	border: solid;
	height: 3px;
}

.all a {
	color: black;
}

.dlswmd, .tkdrma, .rufwp {
	margin-top: 3%;
}

#dlswmd_1, #tkdrma_1, #rufwp_1 {
	color: #787878;
}
#dlswmd_cont , #rufwp_cont , #tkdrma_cont{
	margin-left: 10%;
	color: gray;
}
.list{
	margin-left: 14%;
}
.btn input {
	border: none;
	padding: 15px 30px;
	border-radius: 7px;
	font-family: "paybooc-Light", sans-serif;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
	text-decoration: none;
	font-weight: 600;
	transition: 0.25s;
	background-color: #519d9e;
	color: black;
}

.btn input:hover {
	background-color: #77af9c;
	color: #d7fff1;
}
</style>
</head>
<body>
	<jsp:include page="../include/admin_top.jsp" />
		<div class="header">
			<div class="h_container">
				<h4>검색어를 입력해 주십시오.</h4>
				<div class="h_container2">
					<img .class="eee"
						src="https://chlngers.com/assets/svgs/icon-search-line-black.svg"
						width="30" height="30">
				</div>
				<input class="search" name="search">
			</div>
		</div>
		<div class="header2">
			<div class="h_bottom">
				<ul class="list">
					<a href="#"><li id="1"><b>전체<b>
									<div class="h_underline"></div></li></a>
					<a href="#"><li id="2"><b>인증<b>
									<div class="h_underline"></div></li></a>
					<a href="#"><li id="3"><b>결제<b>
									<div class="h_underline"></div></li></a>
					<a href="#"><li id="4"><b>상금<b>
									<div class="h_underline"></div></li></a>
				</ul>
			</div>
		</div>
		<div class="all_container">
		<div class="asd"></div>
		</div>
		<div class="body">
		<div class="all_container">
		<c:set var="list" value="${list }" />

		<c:if test="${!empty list }">

			<div class="all">
				<c:forEach items="${list }" var="dto">
					<div class="dlswmd">
						<c:if test="${dto.faq_category_num == 1}">
							<b id="dlswmd_1">인증</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
								href="<%=request.getContextPath() %>/FAQ_modify.do?faq_num=${dto.faq_num }&page=${page }">
								Q. ${dto.faq_title }</a>
							<br>
						</c:if>
					</div>
				</c:forEach>
				<c:forEach items="${list }" var="dto">
					<div class="rufwp">
						<c:if test="${dto.faq_category_num == 2}">
							<b id="rufwp_1">결제</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
								href="<%=request.getContextPath() %>/FAQ_modify.do?faq_num=${dto.faq_num }&page=${page }">Q.
								${dto.faq_title }</a>
							<br>
						</c:if>
					</div>
				</c:forEach>
				<c:forEach items="${list }" var="dto">
					<div class="tkdrma">
						<c:if test="${dto.faq_category_num == 3}">
							<b id="tkdrma_1">상금</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
								href="<%=request.getContextPath() %>/FAQ_modify.do?faq_num=${dto.faq_num }&page=${page }">Q.
								${dto.faq_title }</a>
							<br>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</c:if>
		<div class="btn">
			<input type="button" value="글쓰기"
				onclick="location.href='<%=request.getContextPath()%>/FAQ_write.do'">
		</div>
		</div>
		<nav>
			<ul class="pagination">
				<li class="page-item"><a class="page-link"
					href="FAQ_control.do?page=1">First</a></li>
				<li><a class="page-link"
					href="FAQ_control.do?page=${page - 1 }">Previous</a></li>
				<c:forEach begin="${startBlock }" end="${lastBlock }" var="i">

					<c:if test="${i == page }">
						<li class="page-item active" aria-current="page"><a
							class="page-link" href="FAQ_control.do?page=${i }">${i }</a></li>
					</c:if>

					<c:if test="${i != page }">
						<li class="page-item"><a class="page-link"
							href="FAQ_control.do?page=${i }">${i }</a></li>
					</c:if>
				</c:forEach>

				<c:if test="${lastBlock < allPage }">
					<li class="page-item"><a class="page-link"
						href="FAQ_control.do?page=${page + 1 }">Next</a></li>
					<li class="page-item"><a class="page-link"
						href="FAQ_control.do?page=${allPage }">End</a></li>
				</c:if>
			</ul>
		</nav>
	
	</div>
	
	<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>