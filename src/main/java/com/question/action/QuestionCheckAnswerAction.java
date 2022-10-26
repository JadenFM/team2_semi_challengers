package com.question.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.UserDTO;
import com.question.model.QuestionDAO;
import com.question.model.QuestionDTO;

public class QuestionCheckAnswerAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		
		int mem_num = Integer.parseInt(request.getParameter("mem_num").trim());
		int p_q_check = Integer.parseInt(request.getParameter("p_q_check").trim());
		
		QuestionDAO dao = QuestionDAO.getInstance();
		QuestionDTO q_content = dao.getQuestionByMem_num(mem_num,p_q_check);
		request.setAttribute("q_content",q_content);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("question/question_check_answer.jsp");
		return forward;
	}
	
}
