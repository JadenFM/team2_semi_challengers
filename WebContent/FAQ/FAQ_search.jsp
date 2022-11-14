<%@page import="com.FAQ.model.FAQDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String search = request.getParameter("keyword").trim();
	FAQDAO dao = FAQDAO.getInstance();
	String result = dao.findout(search);
	out.println(result);
%>
