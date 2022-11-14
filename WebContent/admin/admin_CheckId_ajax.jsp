<%@page import="com.admin.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String admin_id = request.getParameter("admin_id").trim();
	AdminDAO dao = AdminDAO.getInstance();
	int result = dao.checkid(admin_id);
	out.println(result);
%>