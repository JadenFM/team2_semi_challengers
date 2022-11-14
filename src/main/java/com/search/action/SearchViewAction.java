package com.search.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.search.model.SearchDAO;
import com.search.model.SearchDTO;

public class SearchViewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {

		int num = Integer.parseInt(request.getParameter("num").trim());
		
		SearchDAO dao = SearchDAO.getinstance();
		
		SearchDTO dto = dao.getContent(num);
	
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("search/search_content.jsp");
		
		return forward;
	}

}
