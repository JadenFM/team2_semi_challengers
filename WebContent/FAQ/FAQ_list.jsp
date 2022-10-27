<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<style type="text/css">

	.pagination {
		justify-content: center;
	}
	
</style>
<style type="text/css">
	
	#FAQ th{
		text-align: center;
	}
	#FAQ td{
		text-align: center;
	}
</style>
</head>
<body>
	<jsp:include page="../include/chall_top.jsp"/>
	<div align="center">
		<b>공지사항 리스트 페이지</b>
		<c:set var="list" value="${list }"/>
		<table id="FAQ" border="1" cellspacing="0" width="800">
			<tr>
				<th>번호</th>
				<th>공지사항 제목</th>
				<th>등록일자</th>
				<th>카테고리</th>
			</tr>
			<c:if test="${!empty list }">
			<c:forEach items="${list }" var="dto">
			<tr>
				<td>${dto.faq_num }</td>
				<td>${dto.faq_title }</td>
				<td>${dto.faq_regdate.substring(0,10) }</td>
				<td>
					<c:if test="${dto.faq_category_num == 1}" >
						인증
					</c:if>
					<c:if test="${dto.faq_category_num == 2}" >
						결제
					</c:if>
					<c:if test="${dto.faq_category_num == 3}">
						상금
					</c:if>
				</td>
				<td></td>
			</tr>
			</c:forEach>
			</c:if>
			<tr>
				<td><input type="button" value="글쓰기" onclick="location.href='<%=request.getContextPath()%>/FAQ_write.do'"></td>
			</tr>
		</table>
		<nav>
		  <ul class="pagination">
		    <li class="page-item">
		      <a class="page-link" 
		      		href="FAQ_control.do?page=1">First</a>
		    </li>
		    <li>
		      <a class="page-link" 
		      		href="FAQ_control.do?page=${page - 1 }">Previous</a>
		    </li>
		    <c:forEach begin="${startBlock }"
	       				end="${lastBlock }" var="i">
		      
		      <c:if test="${i == page }">
		         <li class="page-item active" aria-current="page">
		           <a class="page-link" href="FAQ_control.do?page=${i }">${i }</a>
		         </li>
		      </c:if>
	      
		      <c:if test="${i != page }">
		         <li class="page-item">
		           <a class="page-link" href="FAQ_control.do?page=${i }">${i }</a>
		         </li>
		      </c:if>
	   		</c:forEach>
		    
		    <c:if test="${lastBlock < allPage }">
		      <li class="page-item">
		      	<a class="page-link" href="FAQ_control.do?page=${page + 1 }">Next</a>
		      </li>
		      <li class="page-item">
		      	<a class="page-link" href="FAQ_control.do?page=${allPage }">End</a>
		      </li>
		    </c:if>
		  </ul>
		</nav>
	</div>
	<jsp:include page="../include/chall_bottom.jsp"/>
</body>
</html>