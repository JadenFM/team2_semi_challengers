package com.search.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class SearchLocationAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		if(!request.getParameter("keyword").trim().equals("")) {
			String keyword = request.getParameter("keyword").trim();
			request.setAttribute("keyword", keyword);
			System.out.println("키워드 받음");
		}
		
		if(!request.getParameter("category").trim().equals("")) {
			System.out.println("카테고리 받음");
			String category = request.getParameter("category").trim();
			request.setAttribute("category", category);
		}
		
		
		ActionForward forword = new ActionForward();
		
		
		
		forword.setRedirect(false);
		forword.setPath("search/search.jsp");
		
		
		
		return forword;
	}

}
