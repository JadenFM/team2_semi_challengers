<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../include/chall_top.jsp"/>
		<h3>공지사항 작성 폼 페이지</h3>
		<form method="post" action="<%=request.getContextPath() %>/FAQ_insert.do">
			<table border="1" cellspacing="0">
				<tr>
					<th>공지사항 제목</th>
					<td>
						<input name="faq_title">
					</td>
				</tr>
				<tr>
					<th>공지사항 내용</th>
					<td>
						<textarea rows="20" cols="100" name="faq_content"></textarea>
					</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>
						<input name="faq_category">
					</td>
				</tr>
			</table>
		</form>
	<jsp:include page="../include/chall_bottom.jsp"/>

</body>
</html>