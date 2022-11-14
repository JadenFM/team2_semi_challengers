package com.main.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.main.model.MainDAO;

public class MainGetMostChallAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		MainDAO dao = MainDAO.getinstance();
		
		String str = dao.getMostChall();
		
		PrintWriter out = response.getWriter();
		
		out.println(str);
		
		out.flush();
		
		return null;
	}

}
