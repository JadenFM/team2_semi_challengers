<%@page import="com.review.model.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <% 
    int mem_num = 0;
    if (session.getAttribute("memberNum") != null){
    	mem_num = (int)session.getAttribute("memberNum");
    }
    
    
    int chall_no = 0;
    if (request.getParameter("challNo") != null) {
    	chall_no = Integer.parseInt(request.getParameter("challNo").trim());
    }
    
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

$(document).ready(function(){
	$.ajaxSetup({
		ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type : "post"								
	}); // ajaxSetup 끝
	
	function goReviewPage(page){
		
		$.ajax({
			url : "<%= request.getContextPath() %>/review_list.do?page="+page,
			data : {
				chall_no : <%=chall_no%>
			},
			datatype : "html",
			success : function(data){
				$("#reviewContent").html(data);
			},
			error : function(){
				toastr.warning('데이터 통신 에러');
			}		
		});
		
	} // goReviewPage() 끝
	
	goReviewPage(1);
	
	
	function getChall(keyword){
		
		if (keyword == ""){
			keyword = "null";
		}
		
		if (keyword == null){
			keyword = "null";
		}
		
		console.log(keyword);
		
		$.ajax({
			url: "<%=request.getContextPath()%>/review_getChall.do",
			data : {
				keyword : keyword
			},
			datatype:"json",
			success : function(data){
				
				$("#chall-list-wrap").empty();
				if (data == "]"){
					$("#chall-list-wrap").append("<span>검색 결과가 없습니다.</span>");
				} else {
					const obj = JSON.parse(data);
					$.each(obj, function(index, item){
						let chall_dropdown = "<span><a href='#' onlick='return false;' class='chall-list'>"+item.chall_num+") "+item.chall_title+"</a></span><br>"
						$("#chall-list-wrap").append(chall_dropdown);
					});
				}
				
			},
			error : function(){
				toastr.warning('데이터 통신 오류');
			}
			
		});
	}
	
	$("#reviewWriteBtn").click(function(){
		if (<%=mem_num%> == 0){
			toastr.warning('로그인이 필요합니다.');
			setTimeout(function(){
				$(location).attr('href', "<%=request.getContextPath() %>/member_login.do");
			}, 1200);
		}else {
			$("#review-write-modal").modal('show');
		}
		
	});
	
	$("#review-write-chall-show").focus(function(){
		$(".dropdown-content").addClass('show');
		getChall();
	});

	
	 /* $(document).on("click", ".chall-list", function(){
		$("#review-write-chall").val($(this).text());
		$("#review-write-chall-show").val($(this).text());
	}); */
	 
	 $(document).on("click", ".chall-list", function(){
		let challValue = $(this).text();
		$("#review-write-chall-show").val(challValue);
	});
	
	
	$("#review-write-chall-show").focusout(function(){
		setTimeout(function(){
			$(".dropdown-content").removeClass('show');
		}, 200);
	});
	
	let timeout = null;
	
	$("#review-write-chall-show").keyup(function(){
		let keyword = $(this).val();
		clearTimeout(timeout);
		timeout = setTimeout(function(){
			getChall(keyword);	
		}, 150);
		
	});
	
	

	function reviewInsert(){
		
		let tempVal = $("#review-write-chall-show").val();
		let challResult = tempVal.split(')',1);
		console.log(challResult);
		$("#review-write-chall").val(challResult);
		let review_chall_num = $("#review-write-chall").val();
		console.log(review_chall_num);
		let review_star = $("input[name='review-write-star']:checked").val();
		console.log($("#review-write-star").val());
		let review_content = $("#review-write-content").val();
		console.log($("#review-write-content").val());
		
		$.ajax({
			url: "<%=request.getContextPath()%>/review_insert.do",
			data : {
				mem_num : <%= mem_num %>,
				review_chall_num : review_chall_num,
				review_star : review_star,
				review_content : review_content
			},
			datatype : "txt",
			success : function(data){
				if (data == 1){
					toastr.success('리뷰가 등록되었습니다.');
					$("#review-write-modal").modal('hide');
					$("#review-write-chall").val("");
					$("#review-write-chall-show").val("");
					$("input:radio[name='review-write-star']").prop('checked', false);
					$("#review-write-content").val("");
					goReviewPage(1);
				}else {
					toastr.error('필수 내용을 모두 입력하세요');
				}
			},
			error : function(){
				toastr.error('필수 내용을 모두 입력하세요');
			}
			
		});
	}
	
	$("#review-write-confirm").click(function(){
		reviewInsert();		
	});
	
});




</script>

</head>
<body>
<jsp:include page="../include/chall_top.jsp" />

<div id="reviewContent"></div>

<div id="review-btn">
	<button type="button" id="reviewWriteBtn" class="btn btn-primary">리뷰 작성</button>
</div>


<!-- 리뷰 작성 모달 -->
<div class="modal fade" id="review-write-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="review-write-title">리뷰 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<form class="reviewForm" autocomplete="off">
      		<label for="review-write-chall" class="form-label">챌린지<span>*</span></label>
      		<input type="hidden" id="review-write-chall">
      		<input type="text" id="review-write-chall-show" class="form-control" placeholder="검색" >
      		<div class="dropdown-content">
      			<div id="chall-list-wrap">
      			</div>
      		</div>
      		<br>
      		<!-- <label for="review-write-star" class="form-label">별점<span>*</span></label>
      		<input type="text" id="review-write-star" class="form-control" placeholder="별 이미지 css로 시각화">
      		 -->
      		<label for="review-write-star" class="form-label">별점<span>*</span></label>
      		<br>
      		<fieldset>
	      		<input class="starRadio" type="radio" name="review-write-star" value="5" id="rate1"><label class="starLabel" for="rate1">⭐</label><input class="starRadio" type="radio" name="review-write-star" value="4" id="rate2"><label class="starLabel" for="rate2">⭐</label><input class="starRadio" type="radio" name="review-write-star" value="3" id="rate3"><label class="starLabel" for="rate3">⭐</label><input class="starRadio" type="radio" name="review-write-star" value="2" id="rate4"><label class="starLabel" for="rate4">⭐</label><input class="starRadio" type="radio" name="review-write-star" value="1" id="rate5"><label class="starLabel" for="rate5">⭐</label>
		    </fieldset>
      		<br><br>
      		<label for="review-write-content" class="form-label">리뷰 내용<span>*</span></label>
      		<textarea id="review-write-content" class="form-control"></textarea>
      	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="review-close-btn">닫기</button>
        <button type="button" class="btn btn-primary" id="review-write-confirm">등록</button>
      </div>
    </div>
  </div>
</div>
<!-- 모달 -->

<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>