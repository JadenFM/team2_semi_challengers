<%@page import="com.question.model.QuestionDAO"%>
<%@page import="com.user.model.UserDTO"%>
<%@page import="com.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src="<%=request.getContextPath() %>/question/question.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/question/question.css">
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
    .h_container {
	margin-left: 19%;
}
.all_1 {
 	font-size: 17px;
}
.ekqquso , .ekqqusx {
	margin-top: 1.5%;
}
.list li b {
	margin-left: 1%;
}
.list{
	margin-left: 14%;
}
.ekqqus_title{
	display: inline-block;
}
.pagination {
		justify-content: center;
	}
	
	
.header {
	background-color: #F6F7F9;
	height: 247px;
	padding: 60px 0px 30px;
	
}

.all_container{
		margin-left: 20%;
}
.all_container a{
	color : black;
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
}



.h_underline {
	margin-top: 20px;
	height: 3px;
}


.all_1 a {
	color: black;
}

.ekqqus_title li{
	display: inline-block;
	width: 400px;
	font-weight: bold;
}

#oo , #xx{
	color: #787878;
}
	
</style>
</head>
<body>
	<jsp:include page="../include/admin_top.jsp" />
	<jsp:include page="include_question_search.jsp" />
		<c:set var="list" value="${list }" />
		<c:set var="user_content" value="${user_content }"/>
		
		<div class="header2">
			<div class="h_bottom">
				<ul class="list">
					<a href="category_question.do"><li id="1"><b>전 체<b>
									<div class="h_underline"></div></li></a>
					<a href="answer_check_O.do"><li id="2"><b>답 변 O<b>
									<div class="h_underline"></div></li></a>
					<a href="answer_check_X.do"><li id="3"><b>답 변 X<b>
									<div class="h_underline"></div></li></a>
				</ul>
			</div>
		</div>
		<br>
		<div class="all_container">
			<div class="asd"></div>
		</div>
		<div class="body">
		<div class="all_container">
		<div class="all_1">
		<c:forEach items="${list }" var="dto">
			<div class="ekqqusx">
				<c:if test="${empty dto.p_q_answer_cont}">
					<b id="xx">${dto.p_q_num }</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<ul class="ekqqus_title">
						<li><a href="<%=request.getContextPath()%>/question_content.do?p_q_num=${dto.p_q_num}&page=${page}&p_q_user_num=${dto.p_q_user_num }">${dto.p_q_title}</a></li>
						<li>
							<c:if test="${!empty dto.p_q_answer_cont}">
								O
							</c:if>
							<c:if test="${empty dto.p_q_answer_cont}">
								X
							</c:if>
						</li>
					</ul>
				<br>
				</c:if>
			</div>
		</c:forEach>
		<c:forEach items="${list }" var="dto">
			<div class="ekqquso">
				<c:if test="${!empty dto.p_q_answer_cont}">
					<b id="oo">${dto.p_q_num }</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<ul class="ekqqus_title">
						<li><a href="<%=request.getContextPath()%>/question_content.do?p_q_num=${dto.p_q_num}&page=${page}&p_q_user_num=${dto.p_q_user_num }">${dto.p_q_title}</a></li>
						<li>
							<c:if test="${!empty dto.p_q_answer_cont}">
								O
							</c:if>
							<c:if test="${empty dto.p_q_answer_cont}">
								X
							</c:if>
						</li>
					</ul>
				<br>
				</c:if>
			</div>
		</c:forEach>
		</div>
		</div>
		<br>
		<br>
		<br>
		<nav>
		  <ul class="pagination">
		    <li class="page-item">
		      <a class="page-link" 
		      		href="category_question.do?page=1">First</a>
		    </li>
		    <li>
		      <a class="page-link" 
		      		href="category_question.do?page=${page - 1 }">Previous</a>
		    </li>
		    <c:forEach begin="${startBlock }"
	       				end="${lastBlock }" var="i">
		      
		      <c:if test="${i == page }">
		         <li class="page-item active" aria-current="page">
		           <a class="page-link" href="category_question.do?page=${i }">${i }</a>
		         </li>
		      </c:if>
	      
		      <c:if test="${i != page }">
		         <li class="page-item">
		           <a class="page-link" href="category_question.do?page=${i }">${i }</a>
		         </li>
		      </c:if>
	   		</c:forEach>
		    
		    <c:if test="${lastBlock < allPage }">
		      <li class="page-item">
		      	<a class="page-link" href="category_question.do?page=${page + 1 }">Next</a>
		      </li>
		      <li class="page-item">
		      	<a class="page-link" href="category_question.do?page=${allPage }">End</a>
		      </li>
		    </c:if>
		  </ul>
		</nav>
		</div>
		<div class="pagination_search"></div>
	<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>