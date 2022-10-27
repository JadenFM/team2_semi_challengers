package com.question.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.UserDAO;
import com.chall.model.UserDTO;
import com.question.model.QuestionDAO;
import com.question.model.QuestionDTO;

public class QuestionUpdateCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {

		int p_q_num = Integer.parseInt(request.getParameter("p_q_num").trim());
		String mem_id = request.getParameter("mem_id").trim();
		
		QuestionDAO dao = QuestionDAO.getInstance();
		int res = dao.updateAnswerCheck(p_q_num);
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		if(res > 0) {
			UserDAO dao1 = UserDAO.getinstance();
			UserDTO dto = dao1.getMember(mem_id);
			QuestionDAO dao_q = QuestionDAO.getInstance();
			List<QuestionDTO> list = dao_q.getAnswerCheck(dto.getMem_num());
			HttpSession session = request.getSession();
			session.setAttribute("list",list);
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
