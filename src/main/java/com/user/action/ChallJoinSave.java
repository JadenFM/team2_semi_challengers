package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallJoinDAO;

public class ChallJoinSave implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		
		String open = request.getParameter("openRadio").trim();
		
		ChallJoinDAO dao = ChallJoinDAO.getInstance();
		int chall_num = (Integer)session.getAttribute("chall_num");
		int res = dao.updateChall_1(open,chall_num);
		
		session.setAttribute("open", open);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(res>0) {
			forward.setRedirect(false);
			forward.setPath("member_challJoin_2.do");
		}else {
			out.println("<script>");
			out.println("alert('챌린지 개설 1차 저장 실패...')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
