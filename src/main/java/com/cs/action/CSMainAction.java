package com.cs.action;

import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.cs.model.CScenterDAO;
import com.cs.model.NoticeDTO;


public class CSMainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		CScenterDAO dao = CScenterDAO.getinstance();
		
		// 페이징
		int rowsize = 5;
		int block = 3;
		int totalRecord = 0;
		int allPage = 0 ;
		int page = 0;
		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page").trim());
		}else {
			// 처음으로 "전체 게시물 목록" a 태그를 클릭한 경우
			page = 1; // 1페이지
		}
		
		int startNo = (page * rowsize) - (rowsize -1 );
		int endNo = (page * rowsize);
		int startBlock = (((page -1 ) / block) * block + 1);
		int endBlock = (((page -1 ) / block) * block + block);

		totalRecord = dao.getBoardCount();		
		
		allPage = (int)Math.ceil(totalRecord / (double)rowsize);
				
		if (endBlock > allPage) {
			endBlock = allPage;
		}
		
		List<NoticeDTO> list = dao.getNoticeList(page, rowsize);
		  
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("saterNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("NoticeList", list);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("CScenter/CS_main.jsp");
				
		return forward; 
	}

}