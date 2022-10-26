package com.question.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.question.model.QuestionDAO;

public class QuestionUpdateCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {

		int p_q_num = Integer.parseInt(request.getParameter("p_q_num").trim());
		QuestionDAO dao = QuestionDAO.getInstance();
		int res = dao.updateAnswerCheck(p_q_num);
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("main.do");
		}else {
			out.println("<script>");
			out.println("alert('확인 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}
}
