package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.model.AdminDAO;
import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.report.model.ReportDTO;
import com.user.model.UserDTO;

public class AdminControlAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		
		AdminDAO dao = AdminDAO.getInstance();
		
		int rowsize = 10;
		int page = 1;
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page").trim());
		}
		int block = 10;
		int startNo = (page * rowsize) - (rowsize - 1);
		int lastNo = (page * rowsize);
		int startBlock = (((page - 1)/ block) * block) + 1;
		int lastBlock = (((page - 1) / block) * block) + block;
		int totalRecord = dao.gettotalrecord();
		int allPage = (int)Math.ceil(totalRecord / (double)rowsize);
		if(lastBlock > allPage) {
	    	lastBlock = allPage;
	    }
		
		List<ReportDTO> list = dao.getReportList(startNo,lastNo);
		request.setAttribute("list",list);
		request.setAttribute("page",page);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("admin/admin_control.jsp");
		
		return forward;
	}
	
}
