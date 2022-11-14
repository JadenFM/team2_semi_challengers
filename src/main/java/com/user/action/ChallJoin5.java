package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallCategoryDAO;
import com.chall.model.ChallCategoryDTO;
import com.chall.model.ChallJoinDAO;
import com.chall.model.ChallJoinDTO;

public class ChallJoin5 implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		
		String depositDefault = request.getParameter("depositDefault").trim();
		String depositMax = request.getParameter("depositMax").trim();
		String privateCode = request.getParameter("privateCode").trim();
		String maxPeople = request.getParameter("maxPeople").trim();
		
		ChallJoinDTO dto = new ChallJoinDTO();
		
		dto.setChall_depositDefault(depositDefault);
		dto.setChall_depositMax(depositMax);
		dto.setChall_privateCode(privateCode);
		dto.setChall_maxPeople(maxPeople);
		
		ChallJoinDAO dao = ChallJoinDAO.getInstance();
		
		HttpSession session = request.getSession();
		int chall_num = (Integer)session.getAttribute("chall_num");
		dto.setChall_num(chall_num);
		
		int res = dao.updateChall_3(dto);
		
		ChallCategoryDAO CateDao = ChallCategoryDAO.getInstance();
		List<ChallCategoryDTO> list = CateDao.getCategoryList();
		request.setAttribute("categoryList", list);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		if(res>0) {
			forward.setRedirect(false);
			forward.setPath("user/member_challJoin_5.jsp");
		}else {
			out.println("<script>");
			out.println("alert('챌린지 개설 3차 저장 실패...')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}