package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.question.model.QuestionDAO;
import com.report.model.ReportDAO;
import com.user.model.UserDAO;

public class DeleteMemberAction implements Action {

   @Override
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
      
      String mem_id = "";
      String mem_name = "";
      
      UserDAO dao = UserDAO.getinstance();
      
      if(request.getParameter("mem_id_reported") != null) {
         mem_id = request.getParameter("mem_id_reported").trim();
         mem_name = dao.getMemberName(mem_id);
      }else {
         mem_name = request.getParameter("mem_name_reported").trim();
         mem_id = dao.getMemberId(mem_name);
      }
      dao.DeleteMember(mem_id , mem_name);
      ReportDAO dao1 = ReportDAO.getInstance();
      dao1.deleteReport(mem_id , mem_name);
      
      
      QuestionDAO dao2 = QuestionDAO.getInstance();
      dao2.deleteQuestion(mem_id);
      
      ActionForward forward = new ActionForward();
      PrintWriter out = response.getWriter();
      
      
         forward.setRedirect(true);
         forward.setPath("admin_control.do");
      
      return forward;
   }
}