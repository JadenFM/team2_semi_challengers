<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<table class="full_table">  
	<tr class="contentTitle">
		<td colspan="2">
			<h1>공지사항</h1>
			<hr>
		</td>
	</tr>
</table>

<table class="table">
<c:set value="${NoticeList}" var="list" /> 
<c:if test="${!empty list }">
	<c:forEach items="${list }" var="dto">
		<tr>
			<c:if test="${dto.getNotice_category().equals('notice')}">
				<td>
					<span>[공지]</span>
					&nbsp;
					<a href="<%=request.getContextPath()%>/CS_notice_content.do?no=${dto.getNotice_num()}">
					${dto.getNotice_title() }
					</a>
				</td>
			</c:if>
			<c:if test="${dto.getNotice_category().equals('event')}">
				<td>
					<span>[이벤트]</span>
					&nbsp;
					<a href="<%=request.getContextPath()%>/CS_notice_content.do?no=${dto.getNotice_num()}">
					${dto.getNotice_title() }
					</a>
				</td>
			</c:if>
			<td>
				${dto.getNotice_regdate().substring(0, 10) }
			</td>
		</tr>
	</c:forEach>
</c:if>
<c:if test="${empty list }">
	<tr>
		<td>조회할 공지사항이 없습니다.</td>
	</tr>
</c:if>

</table>

	<div style="text-align :right">
		<span>검색 &nbsp; <input type="text" class="form-control" style="display: inline-block; width:25%;"></span>
	</div>

<nav>
	  <ul class="pagination">
	  	<c:if test="${page > block }">
		    <li class="page-item"><a class='page-link' href="CS_main.do?page=1"><i class="bi bi-chevron-double-left"></i></a></li>
		    <li class="page-item"><a class='page-link' href="CS_main.do?page=${startBlock -1}"><i class="bi bi-chevron-left"></i></a></li>
	    </c:if>
	    <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			<c:if test="${i == page }">
				<li class="page-item active" aria-current="page"><a class='page-link' href="CS_main.do?page=${i }">${i }</a>
			</c:if>
			<c:if test="${i != page }">
				<li class="page-item" aria-current="page"><a class='page-link' href="CS_main.do?page=${i }">${i }</a>
			</c:if>
		</c:forEach>
		
	    <c:if test="${endBlock < allPage}">
			 <li class="page-item"><a class='page-link' href="CS_main.do?page=${endBlock + 1}"><i class="bi bi-chevron-right"></i></a>
			 <li class="page-item"><a class='page-link' href="CS_main.do?page=${allPage}"><i class="bi bi-chevron-double-right"></i></a></li>
		</c:if>
	    
	  </ul>
	</nav>
	
	