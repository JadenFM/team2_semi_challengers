package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.model.AdminDAO;
import com.admin.model.AdminDTO;
import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class AdminLoginOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		
		String admin_id = request.getParameter("admin_id").trim();
		String admin_pwd = request.getParameter("admin_pwd").trim();
		AdminDAO dao = AdminDAO.getInstance();
		int res = dao.getAdminlogin(admin_id,admin_pwd);
		
		PrintWriter out =response.getWriter();
		HttpSession session = request.getSession();
		session.invalidate();
		
		HttpSession session1 = request.getSession();
		ActionForward forward = new ActionForward();
		
		if(res > 0) {
			AdminDTO dto = dao.getAdmin(admin_id);
			session1.setAttribute("admin_id",dto.getAdmin_id());
			session1.setAttribute("admin_name", dto.getAdmin_name());
			forward.setRedirect(false);
			forward.setPath("admin/admin_home.jsp");
		}else if(res == -1) {
			out.println("<script>");
			out.println("alert('비밀번호를 확인해 주십시오.')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('존재하지 않는 아이디입니다.')");
			out.println("history.back()");
			out.println("</script>");
		}	
		return forward;
	}
}
