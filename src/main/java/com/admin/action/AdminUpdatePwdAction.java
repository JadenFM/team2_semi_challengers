package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.model.AdminDAO;
import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class AdminUpdatePwdAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		String admin_pwd = request.getParameter("rePwd").trim();
		String mem_id = request.getParameter("mem_id").trim();
		AdminDAO dao = AdminDAO.getInstance();
		int res = dao.updateAdminPwd(admin_pwd,mem_id);
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("admin_login.do");
		}
		return forward;
	}
}
