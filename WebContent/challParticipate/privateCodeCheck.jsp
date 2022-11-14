<%@page import="com.chall.model.ChallJoinDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String paramCode = request.getParameter("paramCode").trim();
	int challNum = (int)session.getAttribute("chall_num");
	ChallJoinDAO dao = ChallJoinDAO.getInstance();
	
	int res = dao.checkPrivateCode(challNum, paramCode);

	// ajax에게 응답을 해 주면 됨.
	out.println(res);
	
%>