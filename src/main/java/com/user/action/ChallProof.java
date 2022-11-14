package com.user.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallJoinDAO;
import com.chall.model.ChallJoinDTO;
import com.chall.model.ChallProofDAO;
import com.chall.model.ChallProofDTO;

public class ChallProof implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		int chall_num = (Integer) session.getAttribute("chall_num");
		ChallJoinDAO join_dao = ChallJoinDAO.getInstance();
		ChallJoinDTO chall_dto = join_dao.getChallContent(chall_num);
		request.setAttribute("challContent", chall_dto);
		
		/*
		 * session.setAttribute("memberId", dto.getMem_id());
		 * session.setAttribute("memberName", dto.getMem_name());
		 * session.setAttribute("memberNum", dto.getMem_num());
		 */
		
		int memberNum = (Integer) session.getAttribute("memberNum");
		ChallProofDAO proof_dao = ChallProofDAO.getInstance();
		int deposit = proof_dao.getProofDeposit(chall_num, memberNum);				// 예치금 액수 가져옴
		List<ChallProofDTO> list = proof_dao.getProofInfoList(chall_num, memberNum);// 인증샷 정보 가져옴
		String lastestDate = proof_dao.latestProofDate(chall_num, memberNum);		// 가장 최근 인증일을 가져옴
		String lastestDate_fixed = "";
		if(lastestDate == null) {
			lastestDate = "";
		}else {
			Date lastestDate_format = new SimpleDateFormat("yyyy-MM-dd").parse(lastestDate);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy/MM/dd");
			lastestDate_fixed = simpleDateFormat.format(lastestDate_format); 
		}
		
		request.setAttribute("ChallDeposit", deposit);
		request.setAttribute("ProofList", list);
		request.setAttribute("LastestDate", lastestDate_fixed);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("user/member_challProof.jsp");
		return forward;
	}

}
