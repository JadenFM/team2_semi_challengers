package com.review.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.review.model.ReviewDAO;

public class ReviewDeleteAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
         throws IOException, Exception {
      
      ReviewDAO dao = ReviewDAO.getinstance();
      int review_num = Integer.parseInt(request.getParameter("review_num").trim());
      
      int check = dao.deleteReview(review_num);
      
      PrintWriter out = response.getWriter();
      out.println(check);
      return null;
   }

}
