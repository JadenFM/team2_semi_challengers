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
		int admin_age = Integer.parseInt(request.getParameter("admin_age").trim());
		String admin_addr = request.getParameter("admin_addr").trim();
		String admin_phone = request.getParameter("admin_phone").trim();
		
		AdminDTO dto = new AdminDTO();
		AdminDAO dao = AdminDAO.getInstance();
		
		dto.setAdmin_id(admin_id);
		dto.setAdmin_pwd(admin_pwd);
		dto.setAdmin_name(admin_name);
		dto.setAdmin_age(admin_age);
		dto.setAdmin_addr(admin_addr);
		dto.setAdmin_phone(admin_phone);
		
		int res = dao.adminJoin(dto);
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		if(res > 0 ) {
			forward.setRedirect(false);
			forward.setPath("/admin/admin_home.jsp");
		}else {
			out.println("<script>");
			out.println("alert('가입 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}
}
