<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" 
		action="<%=request.getContextPath()%>/question_answer.do">
		<input type="hidden" name="p_q_num" value="${param.p_q_num }">
		<input type="hidden" name="p_q_user_num" value="${param.p_q_user_num }">
		<table border="1" cellspacing="0">
			<tr>
				<th><b>"${param.title }"에 대한 답변입니다.</b></th>
			</tr>
			<tr>
				<td><textarea rows="20" cols="100" name="p_q_answer_cont"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit"  value="답변하기" >
				</td>
			</tr>
		</table>
	</form>
</body>
</html>