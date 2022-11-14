package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class ChallJoin1 implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		if(session.getAttribute("memberNum")==null) {
			// 로그인 안됐으면 로그인 창으로 
			forward.setPath("member_login.do");
		}else {
			forward.setPath("user/member_challJoin_1.jsp");
		}
		 
		return forward;
	}

}
