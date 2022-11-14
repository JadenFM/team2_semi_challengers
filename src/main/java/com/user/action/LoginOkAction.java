package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.user.model.UserDAO;
import com.user.model.UserDTO;

import com.question.model.QuestionDAO;
import com.question.model.QuestionDTO;

public class LoginOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 로그인 폼 페이지에서 넘어온 아이디와 비밀번호가 DB에 있는 지 확인하는 비즈니스 로직.
		
		String member_id = request.getParameter("mem_id").trim();
		String member_pwd = request.getParameter("mem_pwd").trim();
		
		UserDAO dao = UserDAO.getinstance();

		
		// 회원인 지 여부를 확인하는 메소드 호출.
		int check = dao.userCheck(member_id, member_pwd);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) { // 회원인 경우
			
			UserDTO dto = dao.getMember(member_id);
			
			// QNA 답변 알림 정보
			QuestionDAO dao_q = QuestionDAO.getInstance();
			List<QuestionDTO> list = dao_q.getAnswerCheck(dto.getMem_num());
			
			// 세션 객체 생성
			HttpSession session = request.getSession();	

			// 세션 정보 받아오기 
			session.setAttribute("memberId", dto.getMem_id());
			session.setAttribute("memberName", dto.getMem_name());
			session.setAttribute("memberNum", dto.getMem_num());
			session.setAttribute("list",list);
			forward.setRedirect(true);
			
			// 메인 페이지로 이동
			forward.setPath("main.do");
			
		}else if (check == -1) { // 비밀번호가 틀린 경우
			out.println("<script>");
			out.println("alert('비밀번호가 틀립니다. 확인 요망')");
			out.println("history.back()");
			out.println("</script>");
		}else {	// 회원이 아닌 경우(아이디가 없거나 아이디가 틀린 경우)
			out.println("<script>");
			out.println("alert('없는 아이디입니다. 아이디를 확인하세요.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}