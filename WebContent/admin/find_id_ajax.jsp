<%@page import="com.admin.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String admin_name = request.getParameter("admin_name").trim();
	String admin_phone = request.getParameter("admin_phone").trim();
	AdminDAO dao = AdminDAO.getInstance();
	String result = dao.findid(admin_name,admin_phone);
	String info = "";
	System.out.println(result);
	if(!result.equals("<results><aaa></aaa></results>")){
		info =  dao.admin_info(admin_name,admin_phone);
	}else{
		System.out.println(result);
	}
	out.println(result);
	out.println(info);
%>