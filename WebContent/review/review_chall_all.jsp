<%@page import="com.review.model.ReviewDTO"%>
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
    
    List<ReviewDTO> reviewList = (List<ReviewDTO>)request.getAttribute("reviewList"); 
    
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

<!-- CSS -->
<link rel="stylesheet" href="CSS/review.css">
<!-- bootstrp -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>

<script type="text/javascript">
$(function(){
	
	$(".review-wrap").click(function(){
		$(this).next("#modalBox").modal('show');
	});
});

</script>

</head>
<body>

<c:set var="list" value="<%=reviewList %>" />

<c:set var="page_num" value="<%= currentPage%>"/>

<c:set var="rowsize" value="<%=rowsize %>" />
<c:set var="block" value="<%=block %>" />
<c:set var="totalRecord" value="<%=totalRecord %>" />
<c:set var="allPage" value="<%=allPage %>" />
<c:set var="startNo" value="<%= startNo %>" />
<c:set var="endNo" value="<%= endNo %>" />
<c:set var="startBlock" value="<%=startBlock %>" />
<c:set var="endBlock" value="<%= endBlock %>" />

<div id="reviewList">

	<c:forEach var="dto" items="${list }" varStatus="status">
		
		<div class="review-wrap">
			<input type="hidden" value="${dto.getReview_mem_num() }">
			<div class="review-content-header">
				<c:set var="review_mem_num" value="<%=mem_num %>"/>
				<c:if test="${review_mem_num == dto.getReview_mem_num() }">
					<div class="review-update" align="right"><a href="#">삭제</a>│<a href="#">수정</a></div>
				</c:if>
				<c:if test="${review_mem_num != dto.getReview_mem_num() }">
					<div class="review-update">&nbsp;</div>
				</c:if>
				<div class="review-name"><span style="font-weight:bold;">${dto.getReview_mem_name() }</span>님</div>
				    
				<div class="wrap-star" >
					<span class="raitingStar"><c:forEach begin="1" end="${dto.getReview_star() }" step="1">⭐</c:forEach></span><span class="emptyStar"><c:forEach begin="1" end="${5 - dto.getReview_star() }" step="1">⭐</c:forEach></span>
				</div>
			</div>
			<div class="review-content-wrap">
				<c:if test="${dto.getReview_content().length() > 30 }">
					<div class="content">${dto.getReview_content().substring(0, 30) }<span style="font-size:0.7em; color: gray;">…</span></div>
					<div class="more" style="text-align:right;"><span style="font-size:0.7em; color: gray; cursor: pointer;">자세히보기</span></div>
				</c:if>
				<c:if test="${dto.getReview_content().length() <= 30 }">
					<div class="content">${dto.getReview_content() } </div>
				</c:if>
			</div>
		</div>
		<!-- 모달 -->
		<div class="modal fade" id="modalBox">
		  <div class="modal-dialog modal-dialog-centered" >
		    <div class="modal-content" style="text-align: left !important;">
		    	<div class="modal-header" style="display: block !important;">
		    		<div><span style="font-size: 1.2em; font-weight:bold;">${dto.getReview_mem_name() }</span>님의 리뷰입니다.</div>
		    		<div class="review-title-wrap" style="display: flex; text-align: justify;">
				      	<span style="font-size:0.7em; color: gray; flex: 3.5">리뷰 작성일 : ${dto.getReview_regdate().substring(0, 16).replace("T", " ") }</span>
				      	<span style="flex: 3;" class="review-title-space">&nbsp;&nbsp;&nbsp;</span>
				      	    <div class="wrap-star" style="flex: 3.5;">
								<span class="raitingStar"><c:forEach begin="1" end="${dto.getReview_star() }" step="1">⭐</c:forEach></span><span class="emptyStar"><c:forEach begin="1" end="${5 - dto.getReview_star() }" step="1">⭐</c:forEach></span>
							</div>
			    	</div>
		    	</div>
		    	<div class="modal-body">
		    		<p>${dto.getReview_content()}</p>
		    	</div>
		    	<div class="modal-footer" style="display :block !important">
		    		<div class="review-foot" style="display:flex;">
			        	<span style="flex: 3;">참여 챌린지 : ${dto.getReview_chall_title() }</span><span style="flex:5;"></span><span style="flex:2; text-align: right;"><a href="#">삭제</a>│<a href="#">수정</a></span>
			        </div>
		    	</div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<!-- 모달 끝 -->
	</c:forEach>
	
	<%-- <c:forEach begin="${startNo }" end="${endNo }" step="1" var="a">
		<div class="review-wrap">
			<input type="hidden" value="${list[a].getReview_mem_num() }">
			<div><span>${list[a].getReview_mem_name() }</span>님의 리뷰입니다.</div>
			<div class="wrap-star">별점 : ${list[a].getReview_star() }</div>
			<div class="review-content-wrap">
				<c:if test="${list[a].getReview_content().length() > 60 }">
					<div class="content">${list[a].getReview_content().substring(0, 60) } …</div>
					<div class="more">자세히보기</div>
				</c:if>
				<c:if test="${list[a].getReview_content().length() <= 60 }">
					<div class="content">${list[a].getReview_content() } </div>
				</c:if>
			</div>
		</div>
		<!-- 모달 -->
		<div class="modal fade" id="modalBox">
		  <div class="modal-dialog modal-dialog-centered" >
		    <div class="modal-content">
		      <div class="modal-body">
		        <p>${list[a].getReview_content()}</p>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		<!-- 모달 끝 -->
	</c:forEach> --%>
	
</div>

<script>

function goReviewPage(page){
	
	$.ajax({
		url : "<%= request.getContextPath() %>/review_list.do?page="+page,
		datatype : "html",
		success : function(data){
			$("#reviewContent").html(data);
		},
		error : function(){
			toastr.warning('데이터 통신 에러');
		}		
	});
	
} // goReviewPage() 끝


</script>

<div id="review-page-block">
	<ul class="pagination">
	  	<c:if test="${page_num > block }">
		    <li class="page-item"><a class='page-link' href="#" onclick="goReviewPage(1)" aria-label="Previous"><i class="bi bi-chevron-double-left"></i></a></li>
		    <li class="page-item"><a class='page-link' href="#" onclick="goReviewPage(${startBlock}-1)"><i class="bi bi-chevron-left"></i></a></li>
	    </c:if>
	    <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			<c:if test="${i == page_num}">
				<li class='page-item active' aria-current="page"><a class='page-link' href="#" onclick="goReviewPage(${i})">${i }</a>
			</c:if>
			<c:if test="${i != page_num  }">
				<li class='page-item' aria-current="page"><a class='page-link' href="#" onclick="goReviewPage(${i})">${i }</a>
			</c:if>
		</c:forEach>
		
	    <c:if test="${endBlock < allPage}">
			 <li class="page-item"><a class='page-link' href="#" onclick="goReviewPage(${endBlock}+1)"><i class="bi bi-chevron-right"></i></a>
			 <li class="page-item"><a class='page-link' href="#" onclick="goReviewPage(${allPage})" aria-label="Next"><i class="bi bi-chevron-double-right"></i></a></li>
		</c:if>
	    
	  </ul>
</div>

</body>
</html>