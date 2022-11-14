package com.cs.model;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.cs.model.CScenterDAO;
import com.cs.model.NoticeDTO;

public class CSNoticeContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		int notice_no = Integer.parseInt(request.getParameter("no").trim());
		
		CScenterDAO dao = CScenterDAO.getinstance();
		NoticeDTO dto = dao.getNoticeContent(notice_no);
		NoticeDTO dtoPrev = dao.getNoticeContent(notice_no-1);
			System.out.println("prevNum >>> "+dtoPrev.getNotice_num());
			System.out.println("prevContent >>> "+dtoPrev.getNotice_content());
		NoticeDTO dtoNext = dao.getNoticeContent(notice_no+1);
			System.out.println("nextNum >>> "+dtoNext.getNotice_num());
			System.out.println("nextCont >>> "+dtoNext.getNotice_content());
		
		request.setAttribute("noticeContent", dto);
		request.setAttribute("noticeContentPrev", dtoPrev);
		request.setAttribute("noticeContentNext", dtoNext);
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("CScenter/CS_notice_content.jsp");	
		forward.setRedirect(false);
		
		return forward;
	}

}