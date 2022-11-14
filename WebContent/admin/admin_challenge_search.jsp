<%@page import="com.chall.model.ChallengeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String search = request.getParameter("keyword").trim();
	ChallengeDAO dao = ChallengeDAO.getinstance();
	int rowsize = 12;
	int block = 10;
	int pages = 1;
	if(request.getParameter("page") != null){
		pages = Integer.parseInt(request.getParameter("page").trim());
	}
	int startNo = (rowsize * pages) - (rowsize - 1);
	int lastNo = (rowsize * pages);
	int startBlock = (((pages - 1)/block)*block)+1;
	int lastBlock = (((pages - 1)/block)*block)+block;
	int totalRecord = dao.getTotalRecord_search(search);
	int allPage = (int)Math.ceil(totalRecord / (double)rowsize);
	if(lastBlock > allPage){
		lastBlock = allPage;
	}
	String pagination = dao.pagination(rowsize,block,pages,startNo,lastNo,startBlock,lastBlock,totalRecord,allPage);
	String result = dao.findout(search,startNo,lastNo);
	
	out.println(result);
	out.println(pagination);
%>