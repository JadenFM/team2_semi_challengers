package com.cs.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.cs.model.CScenterDAO;

public class CSPrivateQListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		int pq_user_no = Integer.parseInt(request.getParameter("pq_user_no").trim());
    	System.out.println("CS_pq.jsp에서 넘겨준 session 정보 >>> 유저 번호: " +pq_user_no);
    
    	CScenterDAO dao = CScenterDAO.getinstance();
    	
    	// 페이지 변수 선언
    	
    	
    	
    	// getPagedPQList 메서드 완성 후 메서드 교체
    	String str = dao.getPQList(pq_user_no);
    	System.out.println(str);
    	
    	PrintWriter out = response.getWriter();
    	out.println(str);
    			
		return null;
	}

}