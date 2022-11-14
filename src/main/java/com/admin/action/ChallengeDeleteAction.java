package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallengeDAO;

public class ChallengeDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		
		int chall_num = Integer.parseInt(request.getParameter("chall_num").trim());
		ChallengeDAO dao = ChallengeDAO.getinstance();
		dao.Deletechallenge(chall_num);
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("challenge_control.do");
		return forward;
	}

}
