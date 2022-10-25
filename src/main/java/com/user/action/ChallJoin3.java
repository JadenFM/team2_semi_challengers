package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class ChallJoin3 implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		response.setContentType("text/html; charset=UTF-8");
		
		String open = request.getParameter("openRadio").trim();
		
		HttpSession session = request.getSession();
		session.setAttribute("open", open);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("user/member_challJoin_3.jsp");
		return forward;
	}

}
