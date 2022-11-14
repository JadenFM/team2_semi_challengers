<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
	<nav>
			<ul class="pagination">
				<li class="page-item"><a class="page-link"
					href="all_list.do?page=1">First</a></li>
				<li><a class="page-link"
					href="all_list.do?page=${page - 1 }">Previous</a></li>
				<c:forEach begin="${startBlock }" end="${lastBlock }" var="i">

					<c:if test="${i == page }">
						<li class="page-item active" aria-current="page"><a
							class="page-link" href="all_list.do?page=${i }">${i }</a></li>
					</c:if>

					<c:if test="${i != page }">
						<li class="page-item"><a class="page-link"
							href="all_list.do?page=${i }">${i }</a></li>
					</c:if>
				</c:forEach>

				<c:if test="${lastBlock < allPage }">
					<li class="page-item"><a class="page-link"
						href="all_list.do?page=${page + 1 }">Next</a></li>
					<li class="page-item"><a class="page-link"
						href="all_list.do?page=${allPage }">End</a></li>
				</c:if>
			</ul>
		</nav>
</body>
</html>