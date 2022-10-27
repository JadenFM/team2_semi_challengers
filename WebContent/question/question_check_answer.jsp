<%@page import="com.question.model.QuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	QuestionDTO content = (QuestionDTO)request.getAttribute("q_content");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
	$(function(){
		$(".top_li_5").hide(1000);
	})
	
</script>
</head>
<body>
	<jsp:include page="../include/chall_top.jsp"/>
	<div align="center">
		<form method="post" action="question_update_check.do">
		<input type="hidden" name="p_q_num" value="<%=content.getP_q_num() %>">
		<input type="hidden" name="mem_id" value="${param.mem_id }">
		<table border="1" cellspacing="0">
			<tr>
				<th>문의 번호</th>
				<td><%=content.getP_q_num() %></td>
			</tr>
			<tr>
				<th>제 목</th>
				<td><%=content.getP_q_title() %></td>
			</tr>
			<tr>
				<th>문의 내용</th>
				<td><textarea rows="20" cols="100"><%=content.getP_q_content() %></textarea></td>
			</tr>
			<tr>
				<td><br></td>
			</tr>
			<tr>
				<th>답변 내용</th>
				<td><textarea rows="20" cols="100"><%=content.getP_q_answer_cont() %></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="확인">
			    </td>
			</tr>
		</table>
		</form>
	</div>
	<jsp:include page="../include/chall_bottom.jsp"/>
</body>
</html>