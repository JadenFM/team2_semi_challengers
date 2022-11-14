package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallJoinDAO;
import com.chall.model.ChallJoinDTO;
import com.user.model.UserDTO;

public class AdminChallContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		int challNum = (Integer) session.getAttribute("chall_num");
		ChallJoinDAO dao = ChallJoinDAO.getInstance();
		ChallJoinDTO chall_dto = dao.getChallContent(challNum);
		request.setAttribute("challContent", chall_dto);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("user/member_challContent.jsp");
		return forward;
	}
}
