package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallJoinDAO;
import com.chall.model.ChallJoinDTO;

public class AdminChallJoinCompleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {

		HttpSession session = request.getSession();
		int challNum = (Integer)session.getAttribute("chall_num");
		String ad_id = (String)session.getAttribute("admin_id");
		ChallJoinDAO dao = ChallJoinDAO.getInstance();
		// (list 테이블) status ‘임시저장’ → ‘진행중’
		dao.challJoinOk(challNum, ad_id);
		
		// (list 테이블) 챌린지 정보 가져오기
		ChallJoinDTO dto = dao.getChallContent(challNum);
		request.setAttribute("challContent", dto);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("admin_challContent.do");
		return forward;
	}

}
