package com.user.action;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallJoinDAO;
import com.chall.model.ChallJoinDTO;
import com.google.gson.annotations.JsonAdapter;
import com.chall.model.ChallProofDAO;
import com.user.model.UserDTO;

public class ChallContent implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		
		// 챌린지 정보 받아오기
		int chall_num = (Integer) session.getAttribute("chall_num");
		ChallJoinDAO join_dao = ChallJoinDAO.getInstance();
		ChallJoinDTO chall_dto = join_dao.getChallContent(chall_num);
		request.setAttribute("challContent", chall_dto);
		
		// 개설자 정보 받아오기
		int createrNum = chall_dto.getChall_creater_num();
		UserDTO user_dto = join_dao.getMemInfo(createrNum);
		request.setAttribute("userInfo", user_dto);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		int mem_num = 0;
		if(session.getAttribute("memberNum")==null) {
			// 로그인 안됐으면 로그인 창으로 
			forward.setPath("member_login.do");
		}else {
			mem_num = (Integer) session.getAttribute("memberNum");
			forward.setPath("user/member_challContent.jsp");
		}
		// 참가 여부 정보 받아오기(챌린지 상세페이지 들어갔을 때 참가한 챌린지인지 체크)
		ChallProofDAO proof_dao = ChallProofDAO.getInstance();
		int checkJoin = proof_dao.checkJoin(chall_num, mem_num);
		request.setAttribute("checkJoin", checkJoin);	// 정보있음=1(버튼:'참가완료') / 정보없음=-1(버튼:'참가하기')
		if((chall_dto.getChall_open()).equals("private") && checkJoin != 1 && session.getAttribute("memberNum") != null && request.getParameter("CodeOk") == null) {
			forward.setPath("user/member_CheckPrivateCode.jsp");
		}else {
			
		}
		
		/*
		 * Cookie ck_title = new Cookie("title", chall_dto.getChall_title()); Cookie
		 * ck_image = new Cookie("image", chall_dto.getChall_mainImage()); Cookie
		 * ck_cycle = new Cookie("cycle", chall_dto.getChall_cycle()); Cookie
		 * ck_duration = new Cookie("duration", chall_dto.getChall_duration());
		 * 
		 * 
		 * 
		 * ck_title.setMaxAge(60*60*24); ck_image.setMaxAge(60*60*24);
		 * ck_cycle.setMaxAge(60*60*24); ck_duration.setMaxAge(60*60*24);
		 * 
		 * response.addCookie(ck_title); response.addCookie(ck_image);
		 * response.addCookie(ck_cycle); response.addCookie(ck_duration);
		 */
		
		return forward;
	}

}
