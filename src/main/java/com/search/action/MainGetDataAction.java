package com.search.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ExampleDAO;
import com.search.model.SearchDAO;

public class MainGetDataAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {

		SearchDAO dao = SearchDAO.getinstance();
		
		String str = dao.getChallData();
		
		PrintWriter out = response.getWriter();
		
		out.println(str);
		
		out.flush();
		
		return null;
	}

}
