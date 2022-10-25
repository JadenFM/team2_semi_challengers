package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class ChallJoin4 implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		
		String title = request.getParameter("title").trim();
		String cycle = request.getParameter("cycle").trim();
		int duration = Integer.parseInt(request.getParameter("duration").trim());
		String startDate = request.getParameter("startDate").trim();
		String guide = request.getParameter("guide").trim();
		String success_img = request.getParameter("success").trim();
		String fail_img = request.getParameter("fail").trim();
		String startTime = request.getParameter("startTime").trim();
		String endTime = request.getParameter("endTime").trim();
		String cont = request.getParameter("cont").trim();
		String discript_imgs = request.getParameter("discript_imgs").trim();
		
		HttpSession session = request.getSession();
		session.setAttribute("title", title);
		session.setAttribute("cycle", cycle);
		session.setAttribute("duration", duration);
		session.setAttribute("startDate", startDate);
		session.setAttribute("guide", guide);
		session.setAttribute("success_img", success_img);
		session.setAttribute("fail_img", fail_img);
		session.setAttribute("startTime", startTime);
		session.setAttribute("endTime", endTime);
		session.setAttribute("cont", cont);
		session.setAttribute("discript_imgs", discript_imgs);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("user/member_challJoin_4.jsp");
		return forward;
	}

}
