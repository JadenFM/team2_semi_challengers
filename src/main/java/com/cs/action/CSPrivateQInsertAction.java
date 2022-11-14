package com.cs.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.cs.model.CScenterDAO;
import com.cs.model.PrivateQDTO;

public class CSPrivateQInsertAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		int pq_user_num = Integer.parseInt(request.getParameter("pq_user_num").trim());
		String pq_title = request.getParameter("pq_title").trim();
		String pq_content = request.getParameter("pq_content");
		int pq_cate_no = Integer.parseInt(request.getParameter("pq_cate_no").trim());
		
		PrivateQDTO dto = new PrivateQDTO();
		dto.setP_q_user_num(pq_user_num);
		dto.setP_q_title(pq_title);
		dto.setP_q_content(pq_content);
		dto.setP_q_category_num(pq_cate_no);
		
		CScenterDAO dao = CScenterDAO.getinstance();
		int check = dao.insertPQ(dto);
		
		PrintWriter out = response.getWriter();
		out.print(check);
		
		return null;
	}

}
