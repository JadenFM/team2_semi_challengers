package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallJoinDAO;
import com.chall.model.ChallJoinDTO;

public class ChallJoinPay implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		int chall_num = (Integer)session.getAttribute("chall_num");
		int memberNum = (Integer)session.getAttribute("memberNum");
		ChallJoinDAO dao = ChallJoinDAO.getInstance();
		ChallJoinDTO dto = dao.getChallContent(chall_num);
		request.setAttribute("challContent", dto);
		
		int mem_money = dao.getMemMoney(memberNum);
		request.setAttribute("mem_money", mem_money);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("user/member_challJoin_pay.jsp");
		return forward;
	}

}