package com.review.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.review.model.ReviewDAO;
import com.review.model.ReviewDTO;

public class ReviewPreviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {

		ReviewDAO dao = ReviewDAO.getinstance();
		
		int chall_no = Integer.parseInt(request.getParameter("challNo").trim());
		System.out.println("넘어온 챌린지 번호~~~~" +chall_no);
		
		List<ReviewDTO> previewList = dao.getReviewPreview(chall_no);
		
		request.setAttribute("previewList", previewList);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("review/review_chall_preview.jsp");
		return forward;
	}

}
