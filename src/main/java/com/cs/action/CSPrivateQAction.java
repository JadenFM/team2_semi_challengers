package com.cs.action;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.cs.model.CScenterDAO;
import com.cs.model.PrivateQDTO;

public class CSPrivateQAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		  
		HttpSession session = request.getSession();	
		if (session.getAttribute("memberNum") != null) {
			
			forward.setPath("CScenter/CS_pq.jsp");
			forward.setRedirect(false);

		}else {
			out.println("<script>");
			out.println("alert('로그인이 필요합니다.')");
			out.println("location.href='user/member_login.jsp'");
			out.println("</script>");
		}
		
		return forward; 
		
	}

}