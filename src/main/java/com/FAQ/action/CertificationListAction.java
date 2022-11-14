package com.FAQ.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.FAQ.model.FAQDAO;
import com.FAQ.model.FAQDTO;
import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class CertificationListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {

		int faq_category_num = Integer.parseInt(request.getParameter("faq_category_num").trim());
		FAQDAO dao = FAQDAO.getInstance();
		int rowsize = 10;
		int block = 10;
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page").trim());
		}
		int startNo = (page * rowsize) - (rowsize - 1);
		int lastNo = (page * rowsize);
		int startBlock = (((page - 1) / block) * block) + 1;
		int lastBlock = (((page - 1) / block) * block) + block;
		int totalRecord = dao.getTotalRecord_category(faq_category_num);
		int allPage = (int) Math.ceil(totalRecord / (double) rowsize);
		if (lastBlock > allPage) {
			lastBlock = allPage;
		}

		List<FAQDTO> list = dao.getCategoryList(startNo, lastNo, faq_category_num);
		request.setAttribute("list", list);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("page", page);
		request.setAttribute("block", block);
		request.setAttribute("startNo", startNo);
		request.setAttribute("lastNo", lastNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("lastBlock", lastBlock);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);

		
		ActionForward forward = new ActionForward(); 
		forward.setRedirect(false);
		forward.setPath("FAQ/categoryList/certification_list.jsp");
		return forward;
		
	}

}
