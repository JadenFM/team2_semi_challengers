<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			grid-template-rows: 100px 1fr 100px;	
		}
		
		.ongoingChall_title {
			grid-column: 2/3;
			grid-row: 1/2;	
			font-size: 24px;
			font-weight: bold;	
		}
		
		.ongoingChal_content{
			border-top: solid 3px #ff4d54;
			grid-column: 2/3;
			grid-row: 2/3;		
		}
		
		.money_table{
			width: 500px;
			text-align: center;
			border: solid 1px lightgray; 
			border-radius: 20px;
			border-spacing: 0px;
			font-size: 20px;
			padding: 10px;
		}
		
		th{
			border-bottom: solid 1px lightgray; 
		}
		
		th,td{
			border-collapse : collapse;
			padding: 10px;
		}
		
		

</style>
</head>
<body>
	<jsp:include page="../include/chall_top.jsp" />
	
		<div class="ongoingChall_container" >
		
			<h2 class="ongoingChall_title" >나의 예치금</h2>

				<article class="ongoingChal_content">
					<h3>예치금 전체 내역</h3>
					<table class="money_table">
						<tr>
							<th>날짜</th> <th>관련 챌린지</th> <th>내용</th> <th>금액</th> <th>잔액</th>
						</tr>
						
						<c:set var="list" value="${List }" />
						<c:if test="${!empty list }">
							<c:forEach items="${list }" var="dto">
								<tr>
									<td>${dto.getLog_date() }</td> <td>${dto.getChall_num() }</td> <td>${dto.getMoney_log_kind() }</td> <td>${dto.getMoney_log_content() }</td> <td>${dto.getMoney_log_my_deposit() }</td>
								</tr>	
							</c:forEach>
						</c:if>	
						
						<c:if test="${empty list }">
							<tr>
								<td colspan="5" align="center">
									<h3>예치금 내역이 없습니다.</h3>
								</td>
							</tr>					
						</c:if>			
					</table>
						
				</article>
				
		
		</div>
	
	<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>