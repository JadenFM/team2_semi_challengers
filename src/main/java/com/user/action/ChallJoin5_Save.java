package com.user.action;

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

public class ChallJoin5_Save implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		
		ChallJoinDTO dto = new ChallJoinDTO();
		String saveFolder = "C:\\Users\\VVIP\\git\\team2_semi_challengers\\WebContent\\memUpload";
		int fileSize = 10 * 1024 * 1024; // 10MB
		MultipartRequest multi = new MultipartRequest(
				request,						// 일반적인 request 객체
				saveFolder,						// 첨부파일이 저장될 경로
				fileSize,						// 업로드할 첨부파일의 최대 크기
				"utf-8",						// 문자 인코딩 방식
				new DefaultFileRenamePolicy()	// 파일의 이름이 같은 경우 중복이 안되게 설정
				);
		
		ChallJoinDAO dao = ChallJoinDAO.getInstance();
		String categoryCode = multi.getParameter("categoryCode").trim();
		String keyword1 = multi.getParameter("keyword1").trim();
		String keyword2 = multi.getParameter("keyword2").trim();
		String keyword3 = multi.getParameter("keyword3").trim();
		String mainImgFile = "";
		
		if(multi.getFilesystemName("mainImgFile") == null) {// 메인 이미지 파일 업로드 X -> 기본 이미지로 등록
			mainImgFile = dao.getCateDefaultImg(categoryCode);
		}else {												// 메인 이미지 파일 업로드 O -> 업로드 이미지로 등록
			mainImgFile = multi.getFilesystemName("mainImgFile");
		}
		
		dto.setChall_mainImage(mainImgFile);
		
		dto.setChall_category_code_fk(categoryCode);
		dto.setChall_keyword1(keyword1);
		dto.setChall_keyword2(keyword2);
		dto.setChall_keyword3(keyword3);
		
		HttpSession session = request.getSession();
		int chall_num = (Integer)session.getAttribute("chall_num");
		dto.setChall_num(chall_num);
		int res = dao.updateChall_4(dto);
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		if(res>0) {
			forward.setRedirect(true);
			forward.setPath("member_challJoin_5.do");
		}else {
			out.println("<script>");
			out.println("alert('챌린지 개설 4차 저장 실패...')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}
