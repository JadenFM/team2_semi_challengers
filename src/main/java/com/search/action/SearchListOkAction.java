package com.search.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ExampleDAO;
import com.search.model.SearchDAO;

public class SearchListOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {

		String cycle = "cycle_default";
		int duration = 0;
		
		String text = request.getParameter("search_text").trim();
		
		if(request.getParameter("select_cycle").trim() != null) {
			cycle = request.getParameter("select_cycle").trim();
		}
		
		if(request.getParameter("select_duration").trim() != null) {
			duration = Integer.parseInt(request.getParameter("select_duration").trim());
		}
		
		SearchDAO dao = SearchDAO.getinstance();
		
		String str = dao.getSearchOptionList(text, cycle, duration);
		
		PrintWriter out = response.getWriter();
		
		out.println(str);
		
		return null;
	}

}
