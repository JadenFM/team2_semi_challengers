package com.cs.action;

import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.cs.model.CScenterDAO;
import com.cs.model.FAQDTO;


public class CSFAQAction implements Action { 

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		CScenterDAO dao = CScenterDAO.getinstance();
		  
		List<FAQDTO> list = dao.getFAQList();
		request.setAttribute("FAQList", list);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("CScenter/CS_FAQ.jsp");
		
		return forward;
	}

}