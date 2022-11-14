<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
function pagination(page){
	let searching = $(".search").val();
	$.ajax({
		type : "post",
		url : "admin/admin_control_search.jsp",
		data : {keyword : searching,
				page : page	
		},
		datatype : "xml",
		success : function(data){
			$(".body").hide();
			let table = "";
			let pagi = "";
			$(".asd").text('');
			$(".pagination_search").text('');
			table += "<table class='member_list'> <tr> <th>신고 번호</th><th>신고자</th><th>피신고자</th><th>신고 제목</th><th class='asdasdasd'>신고 사유</th></tr>";
			$(data).find("report").each(function(){
				console.log($(this).find("report_num").text())
				console.log($(this).find("report_title").text())
				console.log($(this).find("report_cause").text())
				console.log($(this).find("mem_id_report").text())
				console.log($(this).find("mem_id_reported").text())
				console.log($(this).find("mem_name_reported").text())
				table += "<tr>";
				table += "<td class='number'>"+$(this).find("report_num").text()+"</td>";
				table += "<td>"+$(this).find("mem_id_report").text()+"</td>"
				if($(this).find("mem_id_reported").text() != ""){
					table += "<td>"+$(this).find("mem_id_reported").text()+"</td>";
				}else {
					table += "<td>"+$(this).find("mem_name_reported").text()+"</td>";
				}
				table += "<td>"+$(this).find("report_title").text()+"</td>";
				table += "<td><a href='<%=request.getContextPath()%>/report_content.do?report_num="+$(this).find("report_num").text()+"&page=1'>"+$(this).find("report_cause").text()+"</a></td>";
				table += "</tr>"; 
			})
			table += "</table>";
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
};
	$(function(){
		let timeout = null
		$(".search").on('propertychange change keyup paste input',function(){
			let keyword = $(this).val();
		    clearTimeout(timeout);
		    timeout = setTimeout(function() {
			let searching = $(".search").val();
		$.ajax({
			type : "post",
			url : "admin/admin_control_search.jsp",
			data : {keyword : searching},
			datatype : "xml",
			success : function(data){
				$(".body").hide();
				let table = "";
				let pagi = "";
				$(".asd").text('');
				$(".pagination_search").text('');
				table += "<table class='member_list'> <tr> <th>신고 번호</th><th>신고자</th><th>피신고자</th><th>신고 제목</th><th class='asdasdasd'>신고 사유</th></tr>";
				$(data).find("report").each(function(){
					table += "<tr>";
					table += "<td class='number'>"+$(this).find("report_num").text()+"</td>";
					table += "<td>"+$(this).find("mem_id_report").text()+"</td>"
					if($(this).find("mem_id_reported").text() != ""){
						table += "<td>"+$(this).find("mem_id_reported").text()+"</td>";
					}else {
						table += "<td>"+$(this).find("mem_name_reported").text()+"</td>";
					}
					table += "<td>"+$(this).find("report_title").text()+"</td>";
					table += "<td><a href='<%=request.getContextPath()%>/report_content.do?report_num="+$(this).find("report_num").text()+"&page=1'>"+$(this).find("report_cause").text()+"</a></td>";
					table += "</tr>"; 
				})
				table += "</table>";
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
	});
	
	</script>
	<style type="text/css">
		
		 .container{
	    margin-right: 0px;
	    margin-left: 0px;   
	    max-width: 100%;
	    padding: 0px;
	    box-sizing: content-box;
	      }
	   
	    .search_text{
	   box-sizing:content-box;
	    }
	    
	    .rogoImg{
	   box-sizing: content-box;
	    }
	    
	    .top{
	   margin: 16px 0px 16px 0px; 
	    }
	    
	    .menu li{
	    box-sizing: content-box;
	    }
	    
		.pagination {
			justify-content: center;
		}
		
		.header {
		background-color: #F6F7F9;
		height: 247px;
		padding: 60px 0px 30px;
	}

	.all_container{
			margin-left: 20%;
	}
	.h_container {
		margin-left: 19%;
	}
	.h_container2 {
		border: none;
		width: 30px;
		display: inline-block;
		height: 66px;
		background-color: white;
		border-radius: 7px;
	}

	.search {
		width: 350px;
		height: 66px;
		font-size: 20px;
		border: none;
		border-radius: 7px;
		position: absolute;
	}

	img {
		margin-top: 2%;
	}

	.header2 {
		background-color: #F6F7F9;
	}


	.h_bottom div{
		display: inline-block;
	}


	.h_underline {
		margin-top: 2%;
		border: solid;
		height: 3px;
	}

	.member_list{
		border-collapse: collapse;
		border-radius: 3px;
		
	}
	.member_list th{
		font-size: 20px;
		text-align: center;
		font-family: "paybooc-Light", sans-serif;
		font-weight: 600;
		transition: 0.25s;
		background-color: #519d9e;
		color: lightgray;
		width: 200px;
		border-radius: 3px;
	}
	.member_list tr{
		border-bottom: 1px solid;
	}
	.member_list td{
		height: 100px;
		font-weight: bold;
		text-align: center;
	}
	.number{
		background-color: #f5f4e1;
		border-radius: 3px;
		box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
	}
	.asdasdasd{
		width:500px;
	}

	.btn{
		  border: 3px solid #f8e6e0;
	      color: #6e6e6e;
	}
	.btn:hover {
		 background-color: #f8e6e0;
	     color: #6e6e6e;
	}

	</style>
</head>
<body>
	<jsp:include page="../include/admin_top.jsp"/>
		<c:set var="list" value="${list }"/>
		<c:set var="user_list" value="${user_list }"/>
		<div class="header">
			<div class="h_container">
				<h4>검색어를 입력해 주십시오.</h4>
				<div class="h_container2">
					<img .class="eee"
						src="https://chlngers.com/assets/svgs/icon-search-line-black.svg"
						width="30" height="30">
				</div>
				<input class="search" name="search" placeholder="아이디 또는 이름을 입력해 주세요.">
			</div>
		</div>
		<br>
		<br>
		<div class="all_container">
		<div class="asd">
		</div>
		</div>
		<div class="body">
		<div class="all_container">
		<c:if test="${!empty list }">
			<table class="member_list">
				<tr>
					<th>신고 번호</th>
					<th>신고자</th>
					<th>피신고자</th>
					<th>신고 제목</th>
					<th class="asdasdasd">신고 사유</th>
				</tr>
			<c:forEach items="${list }" var="dto">
				<tr align="center">
					<td class="number">${dto.report_num }</td>
					<td>${dto.mem_id_report }</td>
					<c:if test="${!empty dto.mem_id_reported }">
						<td>${dto.mem_id_reported }</td>
					</c:if>
					<c:if test="${empty dto.mem_id_reported }">
						<td>${dto.mem_name_reported }</td>
					</c:if>
					<td>${dto.report_title }</td>
					<td><a href="<%=request.getContextPath()%>/report_content.do?report_num=${dto.report_num}&page=${page}">${dto.report_cause }</a></td>
				</tr>
			</c:forEach>
			</table>
		</c:if>
		</div>
		<br>
		<br>
	<nav>
		  <ul class="pagination">
		    <li class="page-item">
		      <a class="page-link" 
		      		href="admin_control.do?page=1">First</a>
		    </li>
		    <c:if test="${page == 1 }">
		    <li>
		      <a class="page-link" 
		      		href="admin_control.do?page=1">Previous</a>
		    </li>
		    </c:if>
		    <c:if test="${page != 1 }">
		    <li>
		      <a class="page-link" 
		      		href="admin_control.do?page=${page - 1 }">Previous</a>
		    </li>
		    </c:if>
		    <c:forEach begin="${startBlock }"
	       				end="${lastBlock }" var="i">
		      
		      <c:if test="${i == page }">
		         <li class="page-item active" aria-current="page">
		           <a class="page-link" href="admin_control.do?page=${i }">${i }</a>
		         </li>
		      </c:if>
	      
		      <c:if test="${i != page }">
		         <li class="page-item">
		           <a class="page-link" href="admin_control.do?page=${i }">${i }</a>
		         </li>
		      </c:if>
	   		</c:forEach>
		    
		    <c:if test="${lastBlock < allPage }">
		      <li class="page-item">
		      	<a class="page-link" href="admin_control.do?page=${page + 1 }">Next</a>
		      </li>
		      <li class="page-item">
		      	<a class="page-link" href="admin_control.do?page=${allPage }">End</a>
		      </li>
		    </c:if>
		  </ul>
		</nav>
	</div>
	<div class="pagination_search"></div>
	<jsp:include page="../include/chall_bottom.jsp"/>
</body>
</html>