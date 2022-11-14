<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<% 


%> 
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>챌린저스 : 참가중인 챌린지</title>
	<style type="text/css">
		
		body {
		 width: 100vw;
		 height: 100vh;
		 margin : 0;
		}
		
		/* 참가중인 챌린지 페이지 전체 CSS */
		.ongoingChall_container{
			display: grid;
			place-items: center;
			width: 100%;
			grid-template-columns: 1fr 3fr 1fr;
			grid-template-rows: 100px 130px 130px 3fr 100px;	
		}
		
		.ongoingChall_title {
			grid-column: 2/3;
			grid-row: 1/2;		
		}
		
		.ongoingChall_navi{
			padding-top: 20px;
			border-top: 3px solid #ff4d54;
			grid-column: 2/3;
			grid-row: 2/3;	
		}
		
		.ongoingChal_status{
			grid-column: 2/3;
			grid-row: 3/4;		
		}
		
		.ongoingChall_content{
			grid-column: 2/3;
			grid-row: 4/5;		
		}
		
		.paging{
			grid-column: 2/3;
			grid-row: 5/6;		
		}
		
		/* 챌린지 카테고리 CSS */
		.ongoingChall_navi_ul{
	
			list-style: none;
			display: grid;
			place-items: center;
			width: 100%;
			height: 60px;
			text-align: center;
			grid-template-columns: repeat(10,1fr);
			grid-template-rows: 10px 50px 10px;
			font-size: 24px;
			padding: 0px;
		}
		
		.ongoingChall_navi_ul li{
			width: 110px;
			padding: 10px;
		}
		
		.ongoingChall_navi_ul li:hover {
			background-color: black;
			color: white;
			border-radius: 10px;
		}
		
		

		.ongoingChall_navi_ul li:nth-child(1){
			grid-column: 1/2;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.ongoingChall_navi_ul li:nth-child(2){
			grid-column: 2/3;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.ongoingChall_navi_ul li:nth-child(3){
			grid-column: 3/4;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.ongoingChall_navi_ul li:nth-child(4){
			grid-column: 4/5;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.ongoingChall_navi_ul li:nth-child(5){
			grid-column: 5/6;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.ongoingChall_navi_ul li:nth-child(6){
			grid-column: 6/7;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.ongoingChall_navi_ul li:nth-child(7){
			grid-column: 7/8;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.ongoingChall_navi_ul li:nth-child(8){
			grid-column: 8/9;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.ongoingChall_navi_ul li:nth-child(9){
			grid-column: 9/10;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.ongoingChall_navi_ul li:nth-child(10){
			grid-column: 10/11;
			grid-row: 2/3;	
		} /* 챌린지 카테고리 CSS end*/
		
		
		/* 챌린지 상태 CSS */
		.status_ul{
			padding: 0;
			list-style: none;
			display: grid;
			place-items: center;
			width: 800px;
			height: 80px;
			text-align: center;
			grid-template-columns: 1fr 1fr 1fr 1fr;
			grid-template-rows: 10px 50px 10px;
			border-radius: 10px;	
			box-shadow: 0px 20px 60px 1px lightgray;	
			font-size: 18px
		}
		
		.status_ul li {
			padding : 0px;
			width: 200px;
		}
		
		.status_ul li:nth-child(1){
			grid-column: 1/2;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.status_ul li:nth-child(2){
			grid-column: 2/3;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.status_ul li:nth-child(3){
			grid-column: 3/4;
			grid-row: 2/3;	
			border-right: 1px solid lightgray;
		}
		
		.status_ul li:nth-child(4){
			grid-column: 4/5;
			grid-row: 2/3;	
		}
		
		.statusTitle{
			color: gray;
			font-weight: bold;
		}
		/* 챌린지 상태 CSS end*/
		
		.ongoingChall_content table {
			width: 1000px;
			font-size: 18px;
			text-align: center;
			border-radius: 20px;
			border-spacing: 0px;
			border-collapse : collapse;
			border-style: hidden;
  			box-shadow: 0 0 0 1px lightgray;
			
		}
		
		th {
		 border-right: solid 1px lightgray;
		}
		
		td {
		 border-top: solid 1px lightgray;
		 border-right: solid 1px lightgray;
		}
	
	</style>
	</head>
	<body>
		<jsp:include page="../include/chall_top.jsp" />
		
		<div class="ongoingChall_container" >
		
			<h2 class="ongoingChall_title" >나의 진행 중인 챌린지</h2>
			
			<nav class="ongoingChall_navi">
				<ul class="ongoingChall_navi_ul">
					<li>전체</li>			
					<li>운동</li>			
					<li>식습관</li>			
					<li>생활</li>			
					<li>정서</li>			
					<li>취미</li>			
					<li>환경.펫</li>			
					<li>공부</li>			
					<li>셀프케어</li>			
					<li>기타</li>			
				</ul>
			</nav>
				<c:set var="dto" value="${Dto }" />
				<c:set var="count" value="${Count }" />
				<c:set var="member_xp" value="${member_xp }" />
				<c:set var="completePercentage" value="${completePercentage }" />
				<div class="ongoingChal_status">
					<ul class="status_ul">
						<li>
						<div class="statusTitle" >현재 참여 챌린지</div>
						<span class="statusContent">${Count }개</span>
						</li>
						<li>
						<div class="statusTitle" >전체 참여 챌린지</div>
						<span class="statusContent">${dto.getChallenge_count() }개</span>
						</li>
						<li>
						<div class="statusTitle">평균 달성률</div>
						<span class="statusContent">${completePercentage }%</span>
						</li>
						<li>
						<div class="statusTitle">누적 경험치</div>
						<span class="statusContent">${dto.getMem_xp() }XP</span>
						</li>
					</ul>
				</div>
				
				<article class="ongoingChall_content">
					<table id="ongoingChall_table">
						<tr>
							<th></th> <th>[챌린지 번호] 챌린지 이름</th>
							<th>챌린지 기간</th> <th>챌린지 상태</th>
						</tr>
						
						<c:set var="list" value="${List }" />
						<c:if test="${!empty list }">
							<c:forEach items="${list }" var="listDto">
								<tr>
									<td><a href="<%=request.getContextPath() %>/member_myOngoingChallContent.do?chall_num=${listDto.getChall_num() }"><img width="200px" src="<%=request.getContextPath()%>/uploadFile/${listDto.getChall_mainimage()}"></img></a></td>
									
									<td>
									[${listDto.getChall_num() }] ${listDto.getChall_title() }
									</td>
									
									<td>
									${listDto.getChall_duration()}주 
									</td>
									
									<td>
									${listDto.getChall_status() }
									</td>
									
								</tr>
							</c:forEach>
						</c:if>
						
						<c:if test="${empty list }">
							<tr>
								<td colspan="4" align="center">
									<h3>참여중인 챌린지가 없습니다.</h3>
								</td>
							</tr>					
						</c:if>
					
					</table>
				</article>

		</div>
		
		<jsp:include page="../include/chall_bottom.jsp" />
	</body>
</html>