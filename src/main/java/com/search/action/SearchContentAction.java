package com.search.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class SearchContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		int num = Integer.parseInt(request.getParameter("num").trim());
		
		HttpSession session = request.getSession();
		
		session.setAttribute("chall_num", num);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(true);
		forward.setPath("member_challContent.do");
		
		return forward;
	}

}
