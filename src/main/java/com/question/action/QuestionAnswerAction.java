package com.question.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.user.model.UserDAO;
import com.user.model.UserDTO;
import com.question.model.QuestionDAO;
import com.question.model.QuestionDTO;

public class QuestionAnswerAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		
		int p_q_num = Integer.parseInt(request.getParameter("p_q_num").trim());
		String p_q_answer_cont = request.getParameter("p_q_answer_cont").trim();
		int p_q_user_num = Integer.parseInt(request.getParameter("p_q_user_num").trim());
		
		QuestionDAO dao = QuestionDAO.getInstance();
		QuestionDTO dto = new QuestionDTO();
		dto.setP_q_num(p_q_num);
		dto.setP_q_answer_cont(p_q_answer_cont);
		int res = dao.writeanswer(dto);
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		if(res > 0) {
			out.println("<script>");
			out.println("alert('답변을 정상적으로 저장하였습니다.')");
			out.println("self.close()");
			out.println("</script>");
			UserDAO dao1 = UserDAO.getinstance();
			UserDTO u_content = dao1.getMemberInfo(p_q_user_num);
			request.setAttribute("u_content",u_content);
			forward.setRedirect(true);
			forward.setPath("category_question.do");
		}
		return forward;
	}
}