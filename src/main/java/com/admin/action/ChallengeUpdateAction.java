package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallengeDAO;
import com.chall.model.ChallengeDTO;

public class ChallengeUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		
		int chall_num = Integer.parseInt(request.getParameter("chall_num").trim());
		int page = Integer.parseInt(request.getParameter("page").trim());
		String chall_title = request.getParameter("chall_title").trim();
		String chall_category = request.getParameter("chall_category").trim();
		String chall_cycle = request.getParameter("chall_cycle").trim();
		String chall_guide = request.getParameter("chall_guide").trim();
		String chall_regitimestart = request.getParameter("chall_regitimestart").trim();
		String chall_regitimeend = request.getParameter("chall_regitimeend").trim();
		String chall_cont = request.getParameter("chall_cont").trim();
		String chall_depositdefault = request.getParameter("chall_depositdefault").trim();
		String chall_depositmax = request.getParameter("chall_depositmax").trim();
		String chall_maxpeople = request.getParameter("chall_maxpeople").trim();
		
		ChallengeDAO dao = ChallengeDAO.getinstance();
		ChallengeDTO dto = new ChallengeDTO();
		
		dto.setChall_num(chall_num);
		dto.setChall_title(chall_title);
		dto.setChall_category_code_fk(chall_category);
		dto.setChall_cycle(chall_cycle);
		dto.setChall_guide(chall_guide);
		dto.setChall_regitimestart(chall_regitimestart);
		dto.setChall_regitimeend(chall_regitimeend);
		dto.setChall_cont(chall_cont);
		dto.setChall_depositdefault(chall_depositdefault);
		dto.setChall_depositmax(chall_depositmax);
		dto.setChall_maxpeople(chall_maxpeople);
		
		int res = dao.Updatechallenge(dto);
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("challenge_control.do");
		}
		else {
			out.println("<script>");
			out.println("alert('수정 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}
}
