package com.review.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.review.model.ReviewDAO;
import com.review.model.ReviewDTO;

public class ReviewPreviewAllAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {

		ReviewDAO dao = ReviewDAO.getinstance();
		
		int chall_no = Integer.parseInt(request.getParameter("challNo").trim());
		
		List<ReviewDTO> reviewChallAllList = dao.getReviewPreview(chall_no);
		request.setAttribute("reviewChallAllList", reviewChallAllList);
		request.setAttribute("chall_no", chall_no);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("review/review_main.jsp");
		return forward;
	}

}
