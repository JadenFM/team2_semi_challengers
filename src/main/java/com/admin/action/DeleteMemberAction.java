package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.user.model.UserDAO;

public class DeleteMemberAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		
		String mem_id = "";
		String mem_name = "";
		if(request.getParameter("mem_id_reported") != null) {
			mem_id = request.getParameter("mem_id_reported").trim();
		}else {
			mem_name = request.getParameter("mem_name_reported").trim();
		}
		
		UserDAO dao = UserDAO.getinstance();
		dao.DeleteMember(mem_id , mem_name);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("admin_control.do");
		return forward;
	}
}
