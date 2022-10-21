package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class LogoutCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 로그아웃이라는 글자를 클릭하면 현재의 모든 정보(session)를 종료시켜주는 비즈니스 로직.
		
		HttpSession session = request.getSession();
		
		// 현재 사용중인 모든 세션을 종료시키는 메소드.
		session.invalidate();
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("main.jsp");
		
		return forward;		
		
	}

}