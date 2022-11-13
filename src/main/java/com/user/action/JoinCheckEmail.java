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

@WebServlet("/joinCheckEmail.do")
public class JoinCheckEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public JoinCheckEmail() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원가입 페이지에서 넘어온 이메일 주소가 DB의 회원 테이블에 존재하는 지 확인 후 
		// 이미 존재하면 1, 존재하지 않으면 0 을 응답하는 비즈니스 로직.
		
		String email = request.getParameter("mem_email").trim();
		
		UserDAO dao = UserDAO.getinstance();
		
		// ajax로 넘어온 이메일이 DB의 회원 테이블에 존재하는 지 확인하는 메소드 호출.
		// 있으면 1, 없으면 0
		int count = dao.checkEmailDuplication(email);
		
        Map<String, Integer> map = new HashMap<>();
        
        map.put("count", count);
        
        JSONObject jsonObj = new JSONObject(map);

        response.getWriter().print(jsonObj.toString());				
		
	}

}
