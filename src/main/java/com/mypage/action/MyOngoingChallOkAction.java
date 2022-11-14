package com.mypage.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class MyOngoingChallOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		// 마이페이지 - 나의 진행중인 챌린지 목록에서 이미지를 클릭했을 때 해당 챌린지 번호를 세션으로 가지고 상세 페이지로 이동하는 비즈니스 로직. 
		
		int myChall_num = Integer.parseInt(request.getParameter("chall_num"));
		
		HttpSession session = request.getSession();
		
		session.setAttribute("chall_num", myChall_num);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("member_challContent.do");
		return forward;
	}

}
