<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
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
    
	.pagination {
		justify-content: center;
	}
	
	.header {
	background-color: #F6F7F9;
	height: 247px;
	padding: 60px 0px 30px;
}

.h_container {
	margin-left: 120px;
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
.h_bottom div{
	display: inline-block;
}

.list li {
	display: inline-block;
	width: px;
	margin-left: 200px;
}

.list li b {
}

.h_underline {
	margin-top: 20px;
	border: solid;
	height: 3px;
}

/* .member_list{
	margin-left: 120px;
} */
.member_list th{
	font-size: 20px;
	text-align: center;
	border-radius: 7px;
	border-radius: 7px;
	font-family: "paybooc-Light", sans-serif;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
	text-decoration: none;
	font-weight: 600;
	transition: 0.25s;
	background-color: #519d9e;
	color: black;
}
.member_list td{
	height: 100px;
	font-weight: bold;
	text-align: center;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
}

.btn{
	  border: 3px solid #f8e6e0;
      color: #6e6e6e;
}
.btn:hover {
	 background-color: #f8e6e0;
     color: #6e6e6e;
}

</style>
</head>
<body>
	<jsp:include page="../include/admin_top.jsp"/>
		<c:set var="list" value="${list }"/>
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
		<br>
		<br>
		<div align="center">
		<table class="member_list" width="1000px">
		<c:if test="${!empty list }">
			<tr>
						<th>신고 번호</th>
						<th>신고자</th>
						<th>피신고자</th>
						<th>신고 누적 횟수</th>
						<th>신고 제목</th>
						<th>신고 사유</th>
						<th>회원 삭제</th>
			</tr>
			<c:forEach items="${list }" var="dto">
			<tr>
						<td>${dto.report_num }</td>
						<td>${dto.mem_id_report }</td>
						<c:if test="${!empty dto.mem_id_reported }">
							<td>${dto.mem_id_reported }</td>
						</c:if>
						<c:if test="${empty dto.mem_id_reported }">
							<td>${dto.mem_name_reported }</td>
						</c:if>
						<td>${dto.report_count }</td>
						<td>${dto.report_title }</td>
						<td><a href="<%=request.getContextPath()%>/report_content.do?report_num=${dto.report_num}&page=${page}">${dto.report_cause }</a></td>
						<td><input class="btn" type="button" onclick="location.href='<%=request.getContextPath()%>/admindelete.do?report_num=${dto.report_num }&page=${page }'" value="삭제하기"></td>
			</tr>
			</c:forEach>
		</c:if>
		</table>
		</div>
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
	<jsp:include page="../include/chall_bottom.jsp"/>
</body>
</html>