package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class ChallJoinFinal implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		
		String categoryName = request.getParameter("categoryName").trim();
		String mainImgFile = request.getParameter("mainImgFile").trim();
		String keyword = request.getParameter("keyword").trim();
		
		HttpSession session = request.getSession();
		session.setAttribute("categoryName", categoryName);
		session.setAttribute("mainImgFile", mainImgFile);
		session.setAttribute("keyword", keyword);

		ActionForward forward = new ActionForward();
		//forward.setRedirect(true);
		//forward.setPath("챌린지_개설_최종_뷰페이지.do");
		forward.setRedirect(false);
		forward.setPath("user/member_challJoin_final_test.jsp");
		return forward;
	}

}
