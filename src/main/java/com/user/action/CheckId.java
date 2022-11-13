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

@WebServlet("/checkId.do")
public class CheckId extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CheckId() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// // 비밀번호 찾기 페이지1(member_fidPwd.jsp) 폼페이지에서 ajax로 넘어온 아이디가 DB의 회원 테이블에 존재하는 지 확인하는 비즈니스 로직.
		String id = request.getParameter("id").trim();
		
		UserDAO dao = UserDAO.getinstance();
		
		// ajax로 넘어온 아이디가 DB의 회원 테이블에 존재하는 지 확인하는 메소드 호출.
		// 있으면 1, 없으면 0
		int count = dao.doesEmailExist(id);
		
        Map<String, Integer> map = new HashMap<>();
        
        map.put("count", count);
        
        JSONObject jsonObj = new JSONObject(map);

        response.getWriter().print(jsonObj.toString());		
	}
}
