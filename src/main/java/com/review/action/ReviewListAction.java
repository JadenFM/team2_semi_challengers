package com.review.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.review.model.ReviewDAO;import com.review.model.ReviewDTO;

public class ReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		ReviewDAO dao = ReviewDAO.getinstance();
		
		int page = 0;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page").trim());
		}else {
			// 처음으로 "전체 게시물 목록" a 태그를 클릭한 경우
			page = 1; // 1페이지
		}
		int rowsize = 9;
		int block = 3;
		int totalRecord = 0;
		totalRecord = dao.getReviewCount();
		
		int allPage = 0 ;
		allPage = (int)Math.ceil(totalRecord / (double)rowsize);
		
		int startNo = (page * rowsize) - (rowsize -1 ); 
		int endNo = (page * rowsize);
		int startBlock = (((page -1 ) / block) * block + 1);
		int endBlock = (((page -1 ) / block) * block + block);
		
		if (endBlock > allPage) {
			endBlock = allPage;
		}

		List<ReviewDTO> reviewList = dao.getReviewList(page, rowsize);
	
		request.setAttribute("currentPage", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("reviewList", reviewList);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("review/review_list.jsp");
		
		return forward;
	}

}
