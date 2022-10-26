<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript" src="searchJS/search_list.js"></script>
<script type="text/javascript" src="../searchJS/search_list.js"></script>

</head>
<body>

	<article align="center">
	
	<p>페이지 로딩 성공</p>
	<c:set var="text" value="${param.search_text }"></c:set>
	<input type="hidden" value="${text }" name="text" id="text" class="text">
	<form id="form_searchCycle">
		<input type="checkbox" name="cycle" value="cycle_default">빈도
		<input type="checkbox" name="cycle" value="daily">매일
		<input type="checkbox" name="cycle" value="2">주2일
		<input type="checkbox" name="cycle" value="4">주4일
	</form>
	
	<form id="form_searchDuration">	
		<input type="checkbox" name="duration" value="0">기간
		<input type="checkbox" name="duration" value="7">1주
		<input type="checkbox" name="duration" value="14">2주
		<input type="checkbox" name="duration" value="21">3주
	</form>

	<div id="load2">
		<table class="li">
			<tr>
				<th>검색 제목</th>
				<th>검색 내용</th>
			</tr>
		</table>
	</div>		
	
	

	</article>

</body>
</html>