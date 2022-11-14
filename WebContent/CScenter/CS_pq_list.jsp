
<%@page import="com.cs.model.CScenterDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%

int mem_num = (int)session.getAttribute("memberNum");

int rowsize = 5;
int block = 3;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<!-- toastr -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript" src="../searchJS/location.js"></script>
<script type="text/javascript" src="searchJS/location.js"></script>
<!-- bootstrp -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

<!-- js & css -->
<link rel="stylesheet" href="CScenter/CScenter.css?a">
<script type="text/javascript">

function getPrivateQList(page) {
	
	if (page == null){
		page = 1;
	}
	
	$.ajaxSetup({
		ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type : "post"								
	}); // ajaxSetup 끝
	
	$.ajax({
		url : "<%= request.getContextPath()%>/CS_privateQ_list.do?page="+page,
		async : false,
		data : {
			pq_user_no : <%= mem_num%>,
			rowsize : <%= rowsize %>,
			block : <%= block %>
		},
		datatype: "xml",
		success : function(data){
			
			$("#paging").empty();
			
			let result = "";
			let answerStatus = "";
			let answer = "";
			
			if ($(data).find("regdate").text() != null){
					$("#PQ_Accordian_wrap").empty();
				}
			
			$(data).find("PQNA").each(function(){
				
				if($(this).find("answerCont").text() == "null") {
						answerStatus = "<font color='#bd3232'>접수중</font>";
						answer = "<p>안녕하세요, 챌린저스입니다.</p>"
						+ "<p>고객님의 일대일 문의가 접수되었습니다.</p>"
						+ "<p>담당자가 확인하여 답변을 작성 중에 있습니다.</p>"
						+ "<p>빠르게 답변드릴 수 있도록 노력하겠습니다.</p>"
						+ "<p>감사합니다.</p>";
						
					}else if($(this).find("answerCont").text() != "null") {
						answerStatus = "<font color='#324bbd'>답변완료</font>";
						answer = "답변 등록일 : "+$(this).find("answerRegdate").text().substring(0, 10)+"<br><br>"+$(this).find("answerCont").text();
					}
				
				result += "<div class='question'><span>"+$(this).find("num").text()+"</span>";				
				result += "<span>"+$(this).find("title").text()+"</span>";
				result += "<span>"+$(this).find("regdate").text().substring(0,10)+"</span>";
				result += "<span>"+answerStatus + "</span></div>";
				result += "<div class='answer'>"+"<span>"+$(this).find("content").text()+"</span>"+"<br><br>"+
							"<div><span>"+answer+"</span></div>"+"</div>";
				
				
			});
			
			console.log("ajax success page 값 >>> "+page);
			let block = <%=block %>;
			console.log("ajax success block 값 >>> "+block);
			let allPage = $(data).find("allPage").text();
			console.log("ajax success allPage 값 >>> "+allPage);
			let startNo = $(data).find("startNo").text();
			console.log("ajax success startNo 값 >>> "+startNo);
			let endNo = $(data).find("endNo").text();
			console.log("ajax success endNo 값 >>> "+endNo);
			let startBlock = $(data).find("startBlock").text();
			console.log("ajax success startBlock 값 >>> "+startBlock);
			let endBlock = $(data).find("endBlock").text();
			console.log("ajax success endblock 값 >>> "+endBlock);
			
			let pagination = "<ul class='pagination'>";
			
			if (page > block){
				pagination += "<li id='goFirstPage'><a class='page-link' href='#' onclick='getPrivateQList(1)'><i class='bi bi-chevron-double-left'></i></a></li>";
				pagination += "<li id='goPrevPage'><a class='page-link' href='#' onclick='getPrivateQList("+startBlock+"-1)'><i class='bi bi-chevron-left'></i></a></li>";
			}
			
			for (var i = startBlock; i <= endBlock; i++){
				if (i == page){
					pagination += "<li class='page-item active' aria-current='page'><a class='page-link' href='#' onclick='getPrivateQList("+i+")'>"+i+"</a></li>";
				}else {
					pagination += "<li class='page-item' aria-current='page'><a class='page-link' href='#' onclick='getPrivateQList("+i+")'>"+i+"</a></li>";
				}
			}
			
			if (endBlock < allPage){
				pagination += " <li id='goNextPage'><a class='page-link' href='#' onclick='getPrivateQList("+endBlock+"+1)'><i class='bi bi-chevron-right'></i></a></li>";
				pagination += "<li id='goLastPage'><a class='page-link' href='#' onclick='getPrivateQList("+allPage+")'><i class='bi bi-chevron-double-right'></i></a></li>";
			}
			
			$("#PQ_Accordian_wrap").append(result);
			$("#paging").append(pagination);
			
			$(".question").click(function(){
				if ($(this).hasClass('show')){
					$(this).next(".answer").slideUp(200);
					$(this).removeClass('show');
				}else {
					$(this).next(".answer").stop().slideDown(200);
					$(this).addClass('show');
				}
			});
			
		},
		error : function(){
			toastr.warning('데이터 통신 에러');
		}
		
	}); // ajax 끝

} // function getPraviteQList(); 끝 

</script>

</head>
<body>

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
				<p><span>아직 일대일 문의를 등록하지 않으셨네요!</span></p>
				<p><span>오른쪽 하단의 문의하기 버튼을 이용해주세요.</span></p>
				</div>
			</div>
		</div>
		
		<script>
		
		function pqWrite(){
			
			console.log('plz~~~');
			
			$.ajax({
				url : "<%= request.getContextPath()%>/CScenter/CS_pq_write.jsp",
				data : {
					pq_user_no : <%= mem_num%>
				},
				datatype : "html",
				success : function(data) {
					$("#PQ_content").html(data);
					$("#PQ_write_button").remove();
					$("#paging").remove();
				},
				error : function() {
					toastr.warning('데이터 통신 에러');
				}
			});
		}
		
		</script>
		
		<script>
		
		$(function(){
			getPrivateQList(1);
			
		});
		
		</script>
		<br>
		
		<nav id="paging"></nav>
		
		<div id="PQ_write_button">
			<button class="btn btn-primary" onclick="pqWrite()">문의하기</button>
		</div>
		

</body>
</html>