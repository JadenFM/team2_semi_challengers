package com.question.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.FAQ.model.FAQDTO;
import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.question.model.QuestionDAO;
import com.question.model.QuestionDTO;

public class Answer_Check_X_Action implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		
		QuestionDAO dao = QuestionDAO.getInstance();
		int rowsize = 10;
		int block = 10;
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page").trim());
		}
		int startNo = (page * rowsize) - (rowsize - 1);
		int lastNo = (page * rowsize);
		int startBlock = (((page - 1) / block) * block) + 1;
		int lastBlock = (((page - 1) / block) * block) + block;
		int totalRecord = dao.gettotalrecord_check_X();
		int allPage = (int) Math.ceil(totalRecord / (double) rowsize);
		if (lastBlock > allPage) {
			lastBlock = allPage;
		}

		List<QuestionDTO> list = dao.getAnswerCheckX(startNo, lastNo);
		request.setAttribute("list", list);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("page", page);
		request.setAttribute("block", block);
		request.setAttribute("startNo", startNo);
		request.setAttribute("lastNo", lastNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("lastBlock", lastBlock);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("question/answer_check/answer_check_X.jsp");
		return forward;
	}

}
