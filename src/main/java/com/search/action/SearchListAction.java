package com.search.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ExampleDAO;
import com.search.model.SearchDAO;

public class SearchListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {

		String text = request.getParameter("keyword").trim();
		
		System.out.println("text >>> " +text);
		
		SearchDAO dao = SearchDAO.getinstance();
		
		String str = dao.getSearchList(text);
		
		PrintWriter out = response.getWriter();
		
		out.println(str);
		
		out.flush();
		
		System.out.println("str >>> " +str);
		
		
		return null;
	}

}
