<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../include/chall_top.jsp" />
	<br>
	<div align="center">
	<form method="post" action="<%=request.getContextPath() %>/admin_join_OK.do">
		<table border="1" cellspacing="0">
			<tr>
				<th>아이디</th>
				<td><input name="admin_id"> <br> <span
					id="id_check"></span></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="admin_pwd" ></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" > <span></span></td>
			</tr>
			<tr>
				<th>이 름</th>
				<td><input name="admin_name" ></td>
			</tr>
			<tr>
				<th>나 이</th>
				<td><input name="admin_age" ></td>
			</tr>
			<tr>
				<th>주 소</th>
				<td><input name="admin_addr" ></td>
			</tr>
			<tr>
				<th>연 락 처</th>
				<td><input name="admin_phone" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="가입하기">
					<input type="reset" value="다시작성">
				</td>
			</tr>
		</table>
	</form>
	</div>
	<jsp:include page="../include/chall_bottom.jsp" />
</body>
</html>