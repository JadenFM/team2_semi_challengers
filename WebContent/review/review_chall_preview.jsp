<%@page import="com.review.model.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%
    
    List<ReviewDTO> previewList = (List<ReviewDTO>)request.getAttribute("previewList");
    
    int mem_num = 0;
    if (session.getAttribute("memberNum") != null) {
    	mem_num = (int)session.getAttribute("memberNum");
    }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS -->
<link rel="stylesheet" href="review/CSS/review.css">
<!-- bootstrp -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">



</script>
</head>
<body>

<c:set var="list" value="<%=previewList %>" />
<c:forEach var="dto" items="${ list}">
	<div style="display:inline-block;">
		<div class="review-wrap">
			<input type="hidden" value="${dto.getReview_mem_num() }">
			<div class="review-content-header">
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
		        	<span style="flex: 3;">참여 챌린지 : ${dto.getReview_chall_title() }</span>
		        	<span style="flex:5;"></span>
		        	<c:set var="review_mem_num" value="<%=mem_num %>"/>
		        	<c:if test="${review_mem_num == dto.getReview_mem_num() }">
		        	<span style="flex:2; text-align: right;"><a href="#">삭제</a>│<a href="#">수정</a></span>
		        	</c:if>
		        	<c:if test="${review_mem_num != dto.getReview_mem_num() }">
		        	<span style="flex:2; text-align: right;"></span>
		        	</c:if>
		        </div>
	    	</div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<!-- 모달 끝 -->
</c:forEach>


</body>
</html>