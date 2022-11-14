package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallJoinDAO;

public class ChallJoin2 implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		
		int res = 0;
		if(session.getAttribute("chall_num") == null) {	// '임시' chall_num를 세션에 새로 설정
			int mem_num = (Integer)session.getAttribute("memberNum");
			ChallJoinDAO dao = ChallJoinDAO.getInstance();
			dao.deleteExistingChall(mem_num); // 기존 '임시'상태 챌린지 삭제
			res = dao.insertChall_0(mem_num); // 새로운 '임시'상태 챌린지 개설
			session.setAttribute("chall_num", res);
		}else {	// '임시저장' chall_num를 세션에 그대로 유지
			res = 2;
			// '챌린지 상태' 정보 가져오기
			// '공개 여부' 정보 가져오기
		}
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if(res>0) {
			forward.setRedirect(false);
			forward.setPath("user/member_challJoin_2.jsp");
		}else {
			out.println("<script>");
			out.println("alert('챌린지 개설 1차 저장 실패...')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
