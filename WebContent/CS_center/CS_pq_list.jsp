<%@page import="com.cs.model.PrivateQDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("replaceEnter", "\n"); %>
<%

int mem_num = 0;
if (session.getAttribute("memberNum") != null) {
	mem_num = (int)session.getAttribute("memberNum");
}

List<PrivateQDTO> pqList = (List<PrivateQDTO>)request.getAttribute("pqList"); 

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
<script type="text/javascript">

function pqWrite(){
	
	console.log('plz~~~');
	
	$.ajax({
		url : "<%= request.getContextPath()%>/CS_center/CS_pq_write.jsp",
		data : {
			pq_user_no : <%= mem_num%>
		},
		datatype : "html",
		success : function(data) {
			$("#PQ_content").html(data);
			$("#PQ_write_button").remove();
			$(".pagination").remove();
		},
		error : function() {
			toastr.warning('데이터 통신 에러');
		}
	});
}


</script>
</head>
<body>


<c:set var="list" value="<%=pqList %>" />

<c:set var="page_num" value="<%= currentPage%>"/>

<c:set var="rowsize" value="<%=rowsize %>" />
<c:set var="block" value="<%=block %>" />
<c:set var="totalRecord" value="<%=totalRecord %>" />
<c:set var="allPage" value="<%=allPage %>" />
<c:set var="startNo" value="<%= startNo %>" />
<c:set var="endNo" value="<%= endNo %>" />
<c:set var="startBlock" value="<%=startBlock %>" />
<c:set var="endBlock" value="<%= endBlock %>" />

<table class="full_table">
	<tr class="contentTitle">
		<td colspan="2">
			<h1>일대일문의</h1>
			<hr>
		</td>
	</tr>
</table>

<div id = "PQ_content">
	<div id="PQ_table_th">
		<span>접수번호</span>
		<span>문의</span>
		<span>등록일</span>
		<span>상태</span>
	</div>
	
	<div id="PQ_Accordian_wrap">
		<div align ="center">
		<c:if test="${!empty list }">
		<c:forEach items="${list }" var="dto">
				<div class="question">
					<span>${dto.getP_q_num()}</span>
					<span>${dto.getP_q_title()}</span>
					<span>${dto.getP_q_regdate().substring(0,10) }</span>
					<span>
						<c:if test="${dto.getP_q_answer_cont() != null }">
							<font color='#324bbd'>답변완료</font>
						</c:if>
						<c:if test="${dto.getP_q_answer_cont() == null }">
							<font color='#bd3232'>접수중</font>
						</c:if>
					</span>
				</div>
				<div class="answer" style="text-align: left;">
					<c:if test="${dto.getP_q_answer_cont() != null }">
						<span>${dto.getP_q_content() }</span>
						<br><br>
						<div>
							<span>답변 등록일 : ${dto.getP_q_regdate() }</span>
							<br>
		
							<span>${dto.getP_q_answer_cont() }</span>
						</div>
					</c:if>
					<c:if test="${dto.getP_q_answer_cont() == null }">
						
						<span>${dto.getP_q_content() }</span>
						<br><br>
						<div>
							<p>안녕하세요, 챌린저스입니다.</p>
							<p>고객님의 일대일 문의가 접수되었습니다.</p>
							<p>담당자가 확인하여 답변을 작성 중에 있습니다.</p>
							<p>빠르게 답변드릴 수 있도록 노력하겠습니다.</p>
							<p>감사합니다.</p>
						</div>
					</c:if>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${empty list }">
			<p><span>아직 일대일 문의를 등록하지 않으셨네요!</span></p>
			<p><span>오른쪽 하단의 문의하기 버튼을 이용해주세요.</span></p>
		</c:if>
		</div>
	</div>
</div>
<br><br>
<nav>
	 <ul class="pagination">
	  	<c:if test="${page_num > block }">
		    <li class="page-item"><a class='page-link' href="#" onclick="getPQList(1)" aria-label="Previous"><i class="bi bi-chevron-double-left"></i></a></li>
		    <li class="page-item"><a class='page-link' href="#" onclick="getPQList(${startBlock}-1)"><i class="bi bi-chevron-left"></i></a></li>
	    </c:if>
	    <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			<c:if test="${i == page_num}">
				<li class='page-item active' aria-current="page"><a class='page-link' href="#" onclick="getPQList(${i})">${i }</a>
			</c:if>
			<c:if test="${i != page_num  }">
				<li class='page-item' aria-current="page"><a class='page-link' href="#" onclick="getPQList(${i})">${i }</a>
			</c:if>
		</c:forEach>
		
	    <c:if test="${endBlock < allPage}">
			 <li class="page-item"><a class='page-link' href="#" onclick="getPQList(${endBlock}+1)"><i class="bi bi-chevron-right"></i></a>
			 <li class="page-item"><a class='page-link' href="#" onclick="getPQList(${allPage})" aria-label="Next"><i class="bi bi-chevron-double-right"></i></a></li>
		</c:if>
	    
	  </ul>
</nav>



<div id="PQ_write_button">
	<button class="btn btn-primary" onclick="pqWrite()">문의하기</button>
</div>

<script type="text/javascript">

function getPQList(page){
	
	if (<%=mem_num%> == 0){
		toastr.warning('로그인이 필요합니다.');
		setTimeout(function(){
			$(location).attr('href', "<%=request.getContextPath() %>/member_login.do");
		}, 1200);
	}else {
		
		$.ajax({
			url : "<%=request.getContextPath()%>/CS_PQ_list.do?page="+page,
			data : {
				mem_num : <%=mem_num%>
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

} // getFAQ() 끝

$(function(){
	$(".question").click(function(){
		if ($(this).hasClass('show')){
			$(this).next(".answer").slideUp(200);
			$(this).removeClass('show');
		}else {
			$(this).next(".answer").stop().slideDown(200);
			$(this).addClass('show');
		}
	});
});

</script>

</body>
</html>