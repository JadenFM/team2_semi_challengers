package com.user.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallCategoryDAO;
import com.chall.model.ChallCategoryDTO;

public class ChallJoin5 implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		
		int depositDefault = Integer.parseInt(request.getParameter("depositDefault").trim());
		int depositMax = Integer.parseInt(request.getParameter("depositMax").trim());
		String privateCode = request.getParameter("privateCode").trim();
		int maxPeople = Integer.parseInt(request.getParameter("maxPeople").trim());
		
		HttpSession session = request.getSession();
		session.setAttribute("depositDefault", depositDefault);
		session.setAttribute("depositMax", depositMax);
		session.setAttribute("privateCode", privateCode);
		session.setAttribute("maxPeople", maxPeople);

		ChallCategoryDAO dao = ChallCategoryDAO.getinstance();
		List<ChallCategoryDTO> list = dao.getCategoryList();
		request.setAttribute("categoryList", list);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("user/member_challJoin_5.jsp");
		return forward;
	}

}
