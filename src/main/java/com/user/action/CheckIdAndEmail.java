package com.user.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.user.model.UserDAO;

@WebServlet("/checkIdAndEmail.do")
public class CheckIdAndEmail extends HttpServlet {
   private static final long serialVersionUID = 1L;
       

    public CheckIdAndEmail() {
        super();
        // TODO Auto-generated constructor stub
    }


   protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // 아이디 찾기 폼페이지에서 넘어온 이름과 이메일이 일치하는 회원이 DB에 있는 지 확인하는 비즈니스 로직.
      
      String name = request.getParameter("name").trim();
      String email = request.getParameter("email").trim();
      
      UserDAO dao = UserDAO.getinstance();
      
      // ajax로 넘어온 이름과 이메일이 일치하는 회원이 DB의 회원 테이블에 존재하는 지 확인하는 메소드 호출.
      // 있으면 1, 없으면 0
      int count = dao.doesExistIdAndEmail(name,email);
      
      if(count>0) {
         
         String  memberId = dao.checkIdAndEmail(name,email);
         
           Map<String, String> map = new HashMap<>();
           
           map.put("mem_id", memberId);
           
           JSONObject jsonObj = new JSONObject(map);

           response.getWriter().print(jsonObj.toString());      
      }else{
         
           Map<String, Integer> map = new HashMap<>();
           
           map.put("count", count);
           
           JSONObject jsonObj = new JSONObject(map);

           response.getWriter().print(jsonObj.toString());               
      }
      
      
   
      
   }

}