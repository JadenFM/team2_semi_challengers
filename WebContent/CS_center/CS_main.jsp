<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
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
<link rel="stylesheet" href="CSS/CS_center.css">
<!-- bootstrp -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

$(function(){
	
	$.ajaxSetup({
		ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type : "post"								
	}); // ajaxSetup 끝
	
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
	
	getNoticeList(1);
	
});	
	
	
function getFAQ(){
	
	$.ajax({
		url : "<%=request.getContextPath()%>/CS_FAQ.do",
		datatype : "html",
		success : function(data){
			$("#CS_content").empty();
			$("#CS_content").html(data);
		},
		error : function(){
			toastr.warning('데이터 통신 에러');
		}
	});
} // getFAQ() 끝


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

</script>
</head>
<body>

<jsp:include page="../include/chall_top.jsp" />

<div id="CS_container"> 

	<div id="CS_left_aside">
			<div>
				<ul>
					<li><a href="#" onclick="getNoticeList(1)">공지사항</a></li>
					<li><a href="#" onclick="getFAQ();">FAQ</a></li>
					<li><a href="#" onclick="getPQList(1)">일대일문의</a></li>
				</ul>
			</div>
	</div>
	
	<div id="CS_content">
	</div>  
	
</div>

<jsp:include page="../include/chall_bottom.jsp" />

</body>
</html>