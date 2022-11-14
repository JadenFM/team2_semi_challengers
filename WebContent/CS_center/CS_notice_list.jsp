<%@page import="com.cs.model.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
int mem_num = 0;
if (session.getAttribute("memberNum") != null) {
	mem_num = (int)session.getAttribute("memberNum");
}

List<NoticeDTO> noticeList = (List<NoticeDTO>)request.getAttribute("noticeList");

int currentPage = (int)request.getAttribute("currentPage");
int rowsize = (int)request.getAttribute("rowsize");
int block = (int)request.getAttribute("block");
int totalRecord = (int)request.getAttribute("totalRecord");
int allPage = (int)request.getAttribute("allPage");
int startNo = (int)request.getAttribute("startNo");
int endNo = (int)request.getAttribute("endNo");
int startBlock = (int)request.getAttribute("startBlock");
int endBlock = (int)request.getAttribute("endBlock");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table class="full_table">  
	<tr class="contentTitle">
		<td colspan="2">
			<h1>공지사항</h1>
			<hr>
		</td>
	</tr>
</table>

<table class="table">
<c:set var="list" value="<%=noticeList %>" />

<c:set var="page_num" value="<%= currentPage%>"/>

<c:set var="rowsize" value="<%=rowsize %>" />
<c:set var="block" value="<%=block %>" />
<c:set var="totalRecord" value="<%=totalRecord %>" />
<c:set var="allPage" value="<%=allPage %>" />
<c:set var="startNo" value="<%= startNo %>" />
<c:set var="endNo" value="<%= endNo %>" />
<c:set var="startBlock" value="<%=startBlock %>" />
<c:set var="endBlock" value="<%= endBlock %>" />

<c:if test="${!empty list }">
	<c:forEach items="${list }" var="dto">
		<tr>
			<c:if test="${dto.getNotice_category().equals('notice')}">
				<td>
					<span>[공지]</span>
					&nbsp;
					<a href="#" onclick="getNoticeContent(${dto.getNotice_num()})">
					${dto.getNotice_title() }
					</a>
				</td>
			</c:if>
			<c:if test="${dto.getNotice_category().equals('event')}">
				<td>
					<span>[이벤트]</span>
					&nbsp;
					<a href="#" onclick="getNoticeContent(${dto.getNotice_num()})">
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

<script type="text/javascript">

function getNoticeList(page){
	
	$.ajax({
		url : "<%= request.getContextPath() %>/cs_notice_list.do?page="+page,
		datatype : "html",
		success : function(data){
			$("#CS_content").empty();
			$("#CS_content").html(data);
		},
		error : function(){
			toastr.warning('데이터 통신 에러');
		}		
	});
	
} // goReviewPage() 끝

function getNoticeContent(noticeNo){
	
	$.ajax({
		url : "<%=request.getContextPath()%>/CS_notice_content.do?no="+noticeNo,
		data : {
			page : <%= currentPage %>
		},
		datatype : "html",
		success : function(data){
			$("#CS_content").empty();
			$("#CS_content").html(data);
		},
		error : function(){
			toastr.warning('데이터 통신 에러');
		}
	});
}


</script>

<nav>
	 <ul class="pagination">
	  	<c:if test="${page_num > block }">
		    <li class="page-item"><a class='page-link' href="#" onclick="getNoticeList(1)" aria-label="Previous"><i class="bi bi-chevron-double-left"></i></a></li>
		    <li class="page-item"><a class='page-link' href="#" onclick="getNoticeList(${startBlock}-1)"><i class="bi bi-chevron-left"></i></a></li>
	    </c:if>
	    <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			<c:if test="${i == page_num}">
				<li class='page-item active' aria-current="page"><a class='page-link' href="#" onclick="getNoticeList(${i})">${i }</a>
			</c:if>
			<c:if test="${i != page_num  }">
				<li class='page-item' aria-current="page"><a class='page-link' href="#" onclick="getNoticeList(${i})">${i }</a>
			</c:if>
		</c:forEach>
		
	    <c:if test="${endBlock < allPage}">
			 <li class="page-item"><a class='page-link' href="#" onclick="getNoticeList(${endBlock}+1)"><i class="bi bi-chevron-right"></i></a>
			 <li class="page-item"><a class='page-link' href="#" onclick="getNoticeList(${allPage})" aria-label="Next"><i class="bi bi-chevron-double-right"></i></a></li>
		</c:if>
	    
	  </ul>
</nav>

</body>
</html>