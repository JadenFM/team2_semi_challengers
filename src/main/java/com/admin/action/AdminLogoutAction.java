package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class AdminLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		forward.setRedirect(true);
		forward.setPath("main.do");
		return forward;
	}

}
