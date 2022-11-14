<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.h_container {
	margin-left: 19%;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
function pagination(page){
	let searching = $(".search").val();
	$.ajax({
		type : "post",
		url : "admin/admin_challenge_search.jsp",
		data : {keyword : searching,
				page : page	
		},
		datatype : "xml",
		success : function(data){
			let page = $(this).find("pages").text();
			let startBlock = $(this).find("startBlock").text();
			let lastBlock = $(this).find("lastBlock").text();
			let allPage = $(this).find("allPage").text();
			$("#body").hide();
			let table = "";
			let pagi = "";
			$(".asd").text('');
			$(".pagination_search").text('');
			table += "<div class='con'> <div class='all'>";
			$(data).find("search").each(function(){
				table += "<div class='alll'>";
				table += "<a class='block' href='<%=request.getContextPath()%>/challenge_modify.do?chall_num=" + $(this).find("chall_num").text() + "&chall_category=선택&page=1'>";
				if($(this).find("chall_mainimage").text() == "null"){
					table += "<img src='<%=request.getContextPath() %>/uploadFile/main.jpg ' width='64' height='54'><br><br>";
				}else{
					table += "<img src='<%=request.getContextPath() %>/uploadFile/" +$(this).find("chall_mainimage").text()+ "' width='64' height='54'><br><br>";
				}
				table += "<h2>" + $(this).find("chall_title").text() +"</h2> <br> <span class='tkdtpqhrl'> 상세보기 + </span> </a></div>";
			})
			table += "</div></div><br><br><br><br>";
			$(".asd").append(table);
			$(data).find("pagination").each(function(){
				let page = $(this).find("pages").text();
				let startBlock = $(this).find("startBlock").text();
				let lastBlock = $(this).find("lastBlock").text();
				let allPage = $(this).find("allPage").text();						
				pagi += "<nav class='search_pagination'> <ul class='pagination'> <li class='page-item'>";
				pagi += "<a class='page-link' href='#' onclick='pagination(1)'>First</a>";
				pagi += "</li><li>";
				if(page == 1){
					pagi += "<a class='page-link' href='#' onclick='pagination(1)'>Previous</a></li>"
				}else{
					pagi += "<a class='page-link' href='#' onclick='pagination("+page+"-1)'>Previous</a> </li>";
				}
				for(let i=startBlock; i <=lastBlock; i++){
					console.log("i :"+ i);
					console.log("page : "+page);
					console.log("startBlock : "+startBlock);
					console.log("lastBlock : "+lastBlock);
					console.log("allPage : "+allPage);
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
	let timeout = null
	$(".search_pagination").hide();
	$(".search").on('propertychange change keyup paste input',function(){
		let keyword = $(this).val()
		clearTimeout(timeout);
	    timeout = setTimeout(function() {
		let searching = $(".search").val();
		$.ajax({
			type : "post",
			url : "admin/admin_challenge_search.jsp",
			data : {keyword : searching},
			datatype : "xml",
			success : function(data){
				$("#body").hide();
				let table = "";
				let pagi = "";
				$(".asd").text('');
				$(".pagination_search").text('');
				table += "<div class='con'> <div class='all'>";
				$(data).find("search").each(function(){
					table += "<div class='alll'>";
					table += "<a class='block' href='<%=request.getContextPath()%>/challenge_modify.do?chall_num=" + $(this).find("chall_num").text() + "&chall_category=선택&page=1'>";
					table += "<img src='<%=request.getContextPath() %>/uploadFile/" +$(this).find("chall_mainimage").text()+ "' width='64' height='54'><br><br>";
					table += "<h2>" + $(this).find("chall_title").text() +"</h2> <br> <span class='tkdtpqhrl'> 상세보기 + </span> </a></div>";
				})
				table += "</div></div><br><br><br><br>";
				$(".asd").append(table);
				$(data).find("pagination").each(function(){
					let page = $(this).find("pages").text();
					let startBlock = $(this).find("startBlock").text();
					let lastBlock = $(this).find("lastBlock").text();
					let allPage = $(this).find("allPage").text();						
					pagi += "<nav class='search_pagination'> <ul class='pagination'> <li class='page-item'>";
					pagi += "<a class='page-link' href='#' onclick='pagination(1)'>First</a>";
					pagi += "</li><li>";
					if(page == 1){
						pagi += "<a class='page-link' href='#' onclick='pagination(1)'>Previous</a></li>"
					}else{
						pagi += "<a class='page-link' href='#' onclick='pagination("+page+"-1)'>Previous</a> </li>";
					}
					for(let i=startBlock; i <=lastBlock; i++){
						console.log("i :"+ i);
						console.log("page : "+page);
						console.log("startBlock : "+startBlock);
						console.log("lastBlock : "+lastBlock);
						console.log("allPage : "+allPage);
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
<style type="text/css">

.search {
	width: 350px;
	height: 66px;
	font-size: 20px;
	border: none;
	border-radius: 7px;
	position: absolute;
}
</style>
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
				<input class="search" name="search" placeholder="챌린지 이름을 입력해주세요.">
			</div>
		</div>
</body>
</html>
