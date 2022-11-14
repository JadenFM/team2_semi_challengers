package com.report.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.report.model.ReportDAO;
import com.report.model.ReportDTO;

public class ReportContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		
		int report_num = Integer.parseInt(request.getParameter("report_num").trim());
		ReportDAO dao = ReportDAO.getInstance();
		ReportDTO content = dao.getReportContent(report_num);
		request.setAttribute("content",content);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("report/report_content.jsp");
		return forward;
	}

}
