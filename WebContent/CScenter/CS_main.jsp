<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>

<script type="text/javascript">

	$(function(){
		
	});
	
</script>

</head>
<body>
	<jsp:include page="../include/chall_top.jsp" />
	<jsp:include page="../include/CS_top.jsp" />

	<div id="content">
		<jsp:include page="CS_notice_list.jsp" />
	</div>

	<jsp:include page="../include/CS_bottom.jsp" />
	<jsp:include page="../include/chall_bottom.jsp" />

</body>
</html>