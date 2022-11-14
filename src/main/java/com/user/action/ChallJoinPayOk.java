package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallJoinDAO;
import com.chall.model.ChallJoinDTO;
import com.chall.model.ChallProofDAO;

public class ChallJoinPayOk implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		int depositOriginal = Integer.parseInt(request.getParameter("dpOG"));	// 참가 예치금
		int depositMinus = Integer.parseInt(request.getParameter("dpMi"));		// 사용한 보유 예치금
		int payFinal = Integer.parseInt(request.getParameter("payF"));			// 최종 충전 금액
		request.setAttribute("depositOriginal", depositOriginal);
		request.setAttribute("depositMinus", depositMinus);
		request.setAttribute("payFinal", payFinal);
		
		HttpSession session = request.getSession();
		int chall_num = (Integer)session.getAttribute("chall_num");
		int memberNum = (Integer)session.getAttribute("memberNum");
		ChallJoinDAO join_dao = ChallJoinDAO.getInstance();
		ChallProofDAO proof_dao = ChallProofDAO.getInstance();
		// (list 테이블) 결제 완료 시 ongoingPeople +1 / status ‘임시저장’ → ‘진행중’
		join_dao.challJoinOk(chall_num);
		// (회원 테이블) 결제 완료 시 해당 회원의 challenge_made_count +1, 예치금(mem_money) 차감
		join_dao.memChallJoinUpdate(memberNum, depositMinus);
		// (인증 테이블) 결제 완료 시 ‘참가예치금’을 해당 회원의 ‘나의 예치금’으로 설정
		proof_dao.proofInsert(chall_num, memberNum, depositOriginal);
		
		// (list 테이블) 챌린지 정보 가져오기
		ChallJoinDTO dto = join_dao.getChallContent(chall_num);
		request.setAttribute("challContent", dto);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("user/member_challJoin_pay_ok.jsp");
		return forward;
		
	}

}
