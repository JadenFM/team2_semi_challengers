<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
		function pagination(page){
			let searching = $(".search").val();
			$.ajax({
				type : "post",
				url : "question/question_search.jsp",
				data : {keyword : searching,
						page : page	
				},
				datatype : "xml",
				success : function(data){
					$(".search_pagination").show();
					$(".body").hide();
					let table = "";
					let pagi = "";
					$(".asd").text('');
					$(".pagination_search").text('');
					$(data).find("question").each(function(){
						table += "<div class='all'><div class='ekqquso'> <b id='oo'>" + $(this).find("p_q_num").text() + "</b>";
						table += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						table += "<ul class='ekqqus_title'> <li>";
						table += "<a href='<%=request.getContextPath()%>/question_content.do?p_q_num=" + $(this).find("p_q_num").text() + "&p_q_user_num=" +$(this).find("p_q_user_num").text() + "'>";
						table += $(this).find("p_q_title").text() + "</a></li><li>";
						if($(this).find("p_q_answer_cont").text() != "null"){
							table += "O";
						}else if($(this).find("p_q_answer_cont").text() == "null") {
							table += "X"
						}
						table += "</li></ul><br></div></div>"
					})
					$(".asd").append(table);
					$(data).find("pagination").each(function(){
						let page = $(this).find("pages").text();
						let startBlock = $(this).find("startBlock").text();
						let lastBlock = $(this).find("lastBlock").text();
						let allPage = $(this).find("allPage").text();						
						pagi += "<nav class='search_pagination'> <ul class='pagination'> <li class='page-item'>";
						pagi += "<a class='page-link' href='#' onclick='pagination(1)'>First</a>";
						pagi += "</li><li>";
						pagi += "<a class='page-link' href='#' onclick='pagination("+page+"-1)'>Previous</a> </li>";
						for(let i=startBlock; i <=lastBlock; i++){
							console.log("i :"+ i);
							if(page == i){
								pagi += "<li class='page-item active'>";
								pagi += "<a class='page-link' href='#' onclick='pagination("+i+")'>"+i+"</a> </li>";
							}
							if(page != i){
								pagi += "<li class='page-item'>";
								pagi += "<a class='page-link' href='#' onclick='pagination("+i+")'>"+i+"</a> </li>";
							}
						}
							if(lastBlock < allPage){
								pagi += "<li class='page-item'>";
								pagi += "<a class='page-link' href='#' onclick='pagination("+page+"+1)'>Next</a></li>";
								pagi += "<li class='page-link' href='#' onclick='pagination("+allPage+")'>End</a> </li></ul></nav>";
							}
						$(".pagination_search").append(pagi);
					})
					
				},
				error : function(){
					alert("에러가 발생하였습니다.")
				}
			})
		}
	
	$(function(){
		<%-- $(".search_pagination").hide();
		$(".search").on('keyup',function(){
			let searching = $(".search").val();
			$.ajax({
				type : "post",
				url : "question/question_search.jsp",
				data : {keyword : searching},
				datatype : "xml",
				success : function(data){
					$(".body").hide();
					let table = "";
					let pagi = "";
					$(".asd").text('');
					$(".pagination_search").text('');
					$(data).find("question").each(function(){
						table += "<div class='all'><div class='ekqquso'> <b id='oo'>" + $(this).find("p_q_num").text() + "</b>";
						table += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						table += "<ul class='ekqqus_title'> <li>";
						table += "<a href='<%=request.getContextPath()%>/question_content.do?p_q_num=" + $(this).find("p_q_num").text() + "&p_q_user_num=" +$(this).find("p_q_user_num").text() + "'>";
						table += $(this).find("p_q_title").text() + "</a></li><li>";
						if($(this).find("p_q_answer_cont").text() != "null"){
							table += "O";
						}else if($(this).find("p_q_answer_cont").text() == "null") {
							table += "X"
						}
						table += "</li></ul><br></div></div>"
					})
					$(".asd").append(table);
					$(data).find("pagination").each(function(){
						let page = $(this).find("pages").text();
						let startBlock = $(this).find("startBlock").text();
						let lastBlock = $(this).find("lastBlock").text();
						let allPage = $(this).find("allPage").text();						
						pagi += "<nav class='search_pagination'> <ul class='pagination'> <li class='page-item'>";
						pagi += "<a class='page-link' href='#' onclick='pagination(1)'>First</a>";
						pagi += "</li><li>";
						pagi += "<a class='page-link' href='#' onclick='pagination("+page+"-1)'>Previous</a> </li>";
						for(let i=startBlock; i <=lastBlock; i++){
							console.log("i :"+ i);
							if(page == i){
								pagi += "<li class='page-item active'>";
								pagi += "<a class='page-link' href='#' onclick='pagination("+i+")'>"+i+"</a> </li>";
							}
							if(page != i){
								pagi += "<li class='page-item'>";
								pagi += "<a class='page-link' href='#' onclick='pagination("+i+")'>"+i+"</a> </li>";
							}
						}
							if(lastBlock < allPage){
								pagi += "<li class='page-item'>";
								pagi += "<a class='page-link' href='#' onclick='pagination("+page+"+1)'>Next</a></li>";
								pagi += "<li class='page-link' href='#' onclick='pagination("+allPage+")'>End</a> </li></ul></nav>";
							}
						$(".pagination_search").append(pagi);
					})
					
				},
				error : function(){
					alert("에러가 발생하였습니다.")
				}
			})
		})
		
		
		 --%>
			/* 검색 레이어 ajax 딜레이 설정*/
	let timeout = null
	$(".search_pagination").hide();
	$(".search").on("propertychange change keyup paste input", function() {
	    let keyword = $(this).val();
	    clearTimeout(timeout);
	    timeout = setTimeout(function() {
	    	let searching = $(".search").val();
			$.ajax({
				type : "post",
				url : "question/question_search.jsp",
				data : {keyword : searching},
				datatype : "xml",
				success : function(data){
					$(".body").hide();
					let table = "";
					let pagi = "";
					$(".asd").text('');
					$(".pagination_search").text('');
					$(data).find("question").each(function(){
						table += "<div class='all'><div class='ekqquso'> <b id='oo'>" + $(this).find("p_q_num").text() + "</b>";
						table += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						table += "<ul class='ekqqus_title'> <li>";
						table += "<a href='<%=request.getContextPath()%>/question_content.do?p_q_num=" + $(this).find("p_q_num").text() + "&p_q_user_num=" +$(this).find("p_q_user_num").text() + "'>";
						table += $(this).find("p_q_title").text() + "</a></li><li>";
						if($(this).find("p_q_answer_cont").text() != "null"){
							table += "O";
						}else if($(this).find("p_q_answer_cont").text() == "null") {
							table += "X"
						}
						table += "</li></ul><br></div></div>"
					})
					$(".asd").append(table);
					$(data).find("pagination").each(function(){
						let page = $(this).find("pages").text();
						let startBlock = $(this).find("startBlock").text();
						let lastBlock = $(this).find("lastBlock").text();
						let allPage = $(this).find("allPage").text();						
						pagi += "<nav class='search_pagination'> <ul class='pagination'> <li class='page-item'>";
						pagi += "<a class='page-link' href='#' onclick='pagination(1)'>First</a>";
						pagi += "</li><li>";
						pagi += "<a class='page-link' href='#' onclick='pagination("+page+"-1)'>Previous</a> </li>";
						for(let i=startBlock; i <=lastBlock; i++){
							console.log("i :"+ i);
							if(page == i){
								pagi += "<li class='page-item active'>";
								pagi += "<a class='page-link' href='#' onclick='pagination("+i+")'>"+i+"</a> </li>";
							}
							if(page != i){
								pagi += "<li class='page-item'>";
								pagi += "<a class='page-link' href='#' onclick='pagination("+i+")'>"+i+"</a> </li>";
							}
						}
							if(lastBlock < allPage){
								pagi += "<li class='page-item'>";
								pagi += "<a class='page-link' href='#' onclick='pagination("+page+"+1)'>Next</a></li>";
								pagi += "<li class='page-link' href='#' onclick='pagination("+allPage+")'>End</a> </li></ul></nav>";
							}
						$(".pagination_search").append(pagi);
					})
					
				},
				error : function(){
					alert("에러가 발생하였습니다.")
				}
			})
	    }, 100);
	})
		
		
		
	})
</script>
</head>
<body>
	<div class="header">
			<div class="h_container">
				<h4>검색어를 입력해 주십시오.</h4>
				<div class="h_container2">
					<img class="eee"
						src="https://chlngers.com/assets/svgs/icon-search-line-black.svg"
						width="30" height="30">
				</div>
				<input class="search" name="search">
			</div>
		</div>
</body>
</html>
