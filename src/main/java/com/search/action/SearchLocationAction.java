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
			System.out.println("로케이션 파라미터 키워드 >>> " +keyword);
		}else {
			System.out.println("키워드 null");
		}
		
		if(!request.getParameter("category").trim().equals("")) {
			String category = request.getParameter("category").trim();
			request.setAttribute("category", category);
			System.out.println("로케이션 파라미터 카테고리 >>> " +category);
		}else {
			System.out.println("카테고리 null");
		}
		ActionForward forword = new ActionForward();
		
		
		
		forword.setRedirect(false);
		forword.setPath("search/search.jsp");
		
		
		
		return forword;
	}

}
