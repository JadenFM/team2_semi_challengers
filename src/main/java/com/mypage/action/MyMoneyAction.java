package com.mypage.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.mypage.model.MoneyLogDTO;
import com.mypage.model.MyChallDAO;
import com.user.model.UserDAO;
import com.user.model.UserDTO;

public class MyMoneyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		//	해당 회원의 회원 예치금을 불러와서 뷰페이지로 이동시켜주는 비즈니스 로직.
		
		HttpSession session = request.getSession();	
		int member_num = (int) session.getAttribute("memberNum");
		
		MyChallDAO dao = MyChallDAO.getinstance();
		
		//	해당 회원의 예치금 로그를 불러오는 메소드 호출
		List<MoneyLogDTO> list = dao.getMoneyLog(member_num);
		
		// 해당 회원의 예치금 로그
		
		request.setAttribute("List", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("mypage/member_myMoney.jsp");
		
		return forward;
	}

}
