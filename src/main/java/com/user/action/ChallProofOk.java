package com.user.action;

import java.io.IOException;
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
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.user.model.UserDAO;

public class ChallProofOk implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");
		
		String saveFolder = "C:\\ncs\\workspace(WEB)\\Semi_Challengers2_1113_backup\\WebContent\\ProofUpload";
		int fileSize = 10 * 1024 * 1024; // 10MB
		MultipartRequest multi = new MultipartRequest(
				request,						// 일반적인 request 객체
				saveFolder,						// 첨부파일이 저장될 경로
				fileSize,						// 업로드할 첨부파일의 최대 크기
				"utf-8",						// 문자 인코딩 방식
				new DefaultFileRenamePolicy()	// 파일의 이름이 같은 경우 중복이 안되게 설정
				);
		
		String proofImg = multi.getFilesystemName("proofImgFile").trim();
		
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
		String lastestDate = proof_dao.latestProofDate(chall_num, memberNum);		// 가장 최근 인증일을 가져옴
		if(lastestDate == null) {	// 인증샷 업로드 최초(최초 생성된 열에 업데이트)
			proof_dao.updateProof(proofImg, chall_num, memberNum);
		}else {						// 인증샷 업로드 2회 이상(기존 열에 추가로 새로운 열 생성)
			proof_dao.addNewProof(proofImg, chall_num, memberNum);
		}
		
		List<ChallProofDTO> list = proof_dao.getProofInfoList(chall_num, memberNum);// 인증샷 정보 가져옴(인증 횟수를 알기 위해 필요)
		int deposit = proof_dao.getProofDeposit(chall_num, memberNum);				// 예치금 액수 가져옴
		request.setAttribute("ChallDeposit", deposit);
		request.setAttribute("ProofList", list);
		request.setAttribute("LastestDate", lastestDate);
		
		UserDAO user_dao = UserDAO.getinstance();
		user_dao.updateXp(memberNum);			// 회원 경험치 +25
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("user/member_challProof_ok.jsp");
		return forward;
	}

}
