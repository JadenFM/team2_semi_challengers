package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallJoinDAO;

public class AdminChallJoinAction1 implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		
		String open = "admin";
		String ad_id = (String)session.getAttribute("admin_id");
		
		ChallJoinDAO dao = ChallJoinDAO.getInstance();
		dao.deleteExistingChall(ad_id); // 기존 '임시'상태 챌린지 삭제
		int res = dao.insertChall_1(open,ad_id); // 새로운 '임시'상태 챌린지 개설
		
		session.setAttribute("open", open);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(res>0) {
			forward.setRedirect(false);
			forward.setPath("user/member_challJoin_3.jsp");
		}else {
			out.println("<script>");
			out.println("alert('챌린지 개설 1차 저장 실패...')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
