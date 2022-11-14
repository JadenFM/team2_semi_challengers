package com.cs.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.cs.model.CScenterDAO;
import com.cs.model.FAQDTO;
import com.review.model.ReviewDAO;

public class CSFAQSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		CScenterDAO dao = CScenterDAO.getinstance();
		String keyword = "";
		
		 List<FAQDTO> FAQList = new ArrayList<FAQDTO>();
		
		if (request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword").trim();
			FAQList = dao.searchFAQList(keyword);
			 
		}
	
		request.setAttribute("FAQList", FAQList);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("CS_center/CS_FAQ_search.jsp");
		
		return forward;
	}

}
