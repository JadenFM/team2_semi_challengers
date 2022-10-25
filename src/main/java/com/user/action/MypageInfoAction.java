package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.UserDAO;
import com.chall.model.UserDTO;

public class MypageInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// get방식으로 넘어온 회원 번호에 해당하는 회원정보를 DB에서 조회하여 마이페이지의 회원 정보 폼으로 이동시키는 비즈니스 로직.
		
		int member_num = Integer.parseInt(request.getParameter("no"));
		
		UserDAO dao = UserDAO.getinstance();
		
		UserDTO dto = dao.getMemberInfo(member_num);
		
		request.setAttribute("dto", dto);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user/member_mypage.jsp");
		
		return forward;
	}

}