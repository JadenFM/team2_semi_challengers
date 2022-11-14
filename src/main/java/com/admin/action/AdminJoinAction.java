package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.model.AdminDAO;
import com.admin.model.AdminDTO;
import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class AdminJoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String admin_id = request.getParameter("admin_id").trim();
		String admin_pwd = request.getParameter("admin_pwd").trim();
		String admin_name = request.getParameter("admin_name").trim();
		String admin_phone = request.getParameter("admin_phone").trim();
		String admin_email_head = request.getParameter("admin_email_head").trim();
		String admin_email_body = request.getParameter("admin_email_body").trim();
		String admin_email = admin_email_head+admin_email_body;
		
		AdminDTO dto = new AdminDTO();
		AdminDAO dao = AdminDAO.getInstance();
		
		dto.setAdmin_id(admin_id);
		dto.setAdmin_pwd(admin_pwd);
		dto.setAdmin_name(admin_name);
		dto.setAdmin_phone(admin_phone);
		dto.setAdmin_email(admin_email);
		
		int res = dao.adminJoin(dto);
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		if(res > 0 ) {
			forward.setRedirect(true);
			forward.setPath("admin_login.do");
		}else {
			out.println("<script>");
			out.println("alert('가입 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}
}
