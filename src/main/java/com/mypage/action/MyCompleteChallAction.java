package com.mypage.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallengeDTO;
import com.mypage.model.MyChallDAO;
import com.user.model.UserDTO;

public class MyCompleteChallAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		// 참가했던 챌리지 중 챌린지 상태가 '완료'인 챌린지 목록을 DB로부터 불러와서 뷰페이지로 넘겨주는 비즈니스 로직.
		
		HttpSession session = request.getSession();	
		int member_num = (int) session.getAttribute("memberNum");
		
		MyChallDAO dao = MyChallDAO.getinstance();
		
		// 해당 회원이 참가중인 챌린지 수를 반환하는 메소드 호출.
		int count = dao.getOngoingChallCount(member_num);
		
		// 해당 회원의 전체 챌린지 참여 수, 완수한 챌린지 수, 경험치를 반환하는 메소드 호출
		UserDTO dto = dao.getUserChallengeInfo(member_num);
		
		double challenge_count = dto.getChallenge_count();
		double challenge_complete_count=dto.getChallenge_complete_count();
		
		double completePercentage = (challenge_complete_count/challenge_count)*100;	// 평균 달성률 = 완수한 챌린지 수/전체 챌린지 참여 수
				
		// 해당 회원이 참가했던, 챌린지 상태가 '완료'인 챌린지 목록을 반환하는 메소드 호출.
		List<ChallengeDTO> list = dao.getCompelteChallList(member_num);
		
		request.setAttribute("Dto", dto);
		request.setAttribute("completePercentage", completePercentage);
		request.setAttribute("Count", count);
		request.setAttribute("List", list);		

		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("member_myCompleteChallOk.do");				
		
		return forward;
	}
}