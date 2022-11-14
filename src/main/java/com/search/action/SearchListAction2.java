package com.search.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.main.model.MainDAO;
import com.search.model.SearchDAO;

public class SearchListAction2 implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		String str = "";
		
		String keyword = request.getParameter("keyword").trim();
		String category = request.getParameter("category").trim();
		
		System.out.println("리스트 액션 키워드 >>>" +keyword);
		System.out.println("리스트 액션 카테고리 >>>" +category);
		
		SearchDAO dao = SearchDAO.getinstance();
		
		if(!keyword.equals("") && keyword != null) {
			str = dao.getSearchKeyList2(keyword);
		}else if(!category.equals("") && category != null) {
			str = dao.getSearchCateList(category);
		}else {
			str = dao.getChallList();
		}
		
		
		
		if(str.equals("<chall_lists></chall_lists>")) {
			str = "1";
		}
		PrintWriter out = response.getWriter();
		
		out.println(str);
		
		out.flush();
		
		System.out.println("str >>> " +str);
		
		return null;
	}

}