<%@page import="com.question.model.QuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	QuestionDTO content = (QuestionDTO)request.getAttribute("content");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	function question_answer() {
		// 형식) window.open("파일경로명","창이름", "가로폭/세로높이")
		window.open("<%=request.getContextPath()%>/question/question_answer.jsp?title=<%=content.getP_q_title()%>&p_q_num=<%=content.getP_q_num()%>&p_q_user_num=<%=content.getP_q_user_num()%>","답변","width=770px, height=380px")
		location.href="category_question.do";
		
	}
	
</script>
</head>
<body>
	<jsp:include page="../include/chall_top.jsp" />
	<div align="center">
		<c:set var="content" value="${content }" />
		<table border="1" cellspacing="0">
			<tr>
				<th>문의 번호</th>
				<td><input value="<%=content.getP_q_num()%>" readonly></td>
			<tr>
			<tr>
				<th>카테고리</th>
				<td><input value="<%=content.getP_q_category_num()%>" readonly></td>
			<tr>
			<tr>
				<th>챌린지</th>
				<td><input value="<%=content.getP_q_chall_num()%>" readonly></td>
			<tr>
			<tr>
				<th>제 목</th>
				<td><input value="<%=content.getP_q_title()%>" readonly></td>
			<tr>
			<tr>
				<th>내 용</th>
				<td><textarea rows="20" cols="100" readonly><%=content.getP_q_content() %></textarea> </td>
			<tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="답변하기" onclick="question_answer()">
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>