package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallengeDAO;
import com.chall.model.ChallengeDTO;

public class StudyListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		
		System.out.println("asd");
		String category_code = request.getParameter("category_code").trim();
		int rowsize = 12;
		int block = 10;
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page").trim());
		}
		int startNo = (page * rowsize) - (rowsize - 1);
		int lastNo = (page * rowsize);
		int startBlock = (((page - 1)/block)*block)+1;
		int lastBlock = (((page - 1)/block)*block)+block;
		ChallengeDAO dao = ChallengeDAO.getinstance();
		int totalRecord = dao.getTotalRecord_category(category_code);
		int allPage = (int)Math.ceil(totalRecord / (double)rowsize);
		if(lastBlock > allPage) {
			lastBlock = allPage;
		}
		
		List<ChallengeDTO> list = dao.getCategoryList(category_code , startNo , lastNo);
		
		request.setAttribute("list",list);
		request.setAttribute("rowsize",rowsize);
		request.setAttribute("page",page);
		request.setAttribute("block", block);
		request.setAttribute("startNo", startNo);
		request.setAttribute("lastNo",lastNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("lastBlock", lastBlock);
		request.setAttribute("totalRecord",totalRecord);
		request.setAttribute("allPage", allPage);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("admin/challenge_category/study.jsp");
		return forward;
	}
	
}
