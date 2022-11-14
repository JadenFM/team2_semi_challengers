package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.chall.model.ChallJoinDAO;
import com.chall.model.ChallJoinDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminChallJoinAction2 implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");

		ChallJoinDTO dto = new ChallJoinDTO();
		String saveFolder = "C:\\Users\\VVIP\\git\\team2_semi_challengers\\WebContent\\memUpload";
		int fileSize = 10 * 1024 * 1024; // 10MB

		MultipartRequest multi = new MultipartRequest(request, // 일반적인 request 객체
				saveFolder, // 첨부파일이 저장될 경로
				fileSize, // 업로드할 첨부파일의 최대 크기
				"utf-8", // 문자 인코딩 방식
				new DefaultFileRenamePolicy() // 파일의 이름이 같은 경우 중복이 안되게 설정
		);

		String title = multi.getParameter("title").trim();
		String cycle = multi.getParameter("cycle").trim();
		String duration = multi.getParameter("duration").trim();
		String startDate = multi.getParameter("startDate").trim();
		String guide = multi.getParameter("guide").trim();
		String startTime = multi.getParameter("startTime").trim();
		String endTime = multi.getParameter("endTime").trim();
		String cont = multi.getParameter("cont").trim();

		String success_img = multi.getFilesystemName("successImgFile");
		String fail_img = multi.getFilesystemName("failImgFile");
		String cont_imgs = multi.getFilesystemName("cont_imgs[]");

		/*
		 * 로그인하면 넘어오는 세션 값 session.setAttribute("memberId", dto.getMem_id());
		 * session.setAttribute("memberName", dto.getMem_name());
		 * session.setAttribute("memberNum", dto.getMem_num());
		 */

		dto.setChall_successImage(success_img);
		dto.setChall_failImage(fail_img);
		dto.setChall_contImg(cont_imgs);

		dto.setChall_title(title);
		dto.setChall_cycle(cycle);
		dto.setChall_duration(duration);
		dto.setChall_startDate(startDate);
		dto.setChall_guide(guide);
		dto.setChall_regiTimeStart(startTime);
		dto.setChall_regiTimeEnd(endTime);
		dto.setChall_cont(cont);

		ChallJoinDAO dao = ChallJoinDAO.getInstance();

		HttpSession session = request.getSession();
		String ad_id = (String)session.getAttribute("admin_id");
		int challNum = dao.continueChallNum(ad_id);
		dto.setChall_num(challNum);
		
		int res = dao.updateChall_2(dto);

		ActionForward forward = new ActionForward();

		PrintWriter out = response.getWriter();

		if (res > 0) {
			forward.setRedirect(false);
			forward.setPath("user/member_challJoin_4.jsp");
		} else {
			out.println("<script>");
			out.println("alert('챌린지 개설 2차 저장 실패...')");
			out.println("history.back()");
			out.println("</script>");
		}

		return forward;
	}

}
