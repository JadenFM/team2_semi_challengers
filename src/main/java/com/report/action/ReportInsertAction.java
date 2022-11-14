package com.report.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.report.model.ReportDAO;
import com.report.model.ReportDTO;
import com.user.model.UserDAO;

public class ReportInsertAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		System.out.println("asldkjhalksd");
		String fileDirectory = "C:\\Users\\sulee\\git\\team2_semi_challengers\\WebContent\\report_image";
		int fileSize = 1024*1024*10;
		MultipartRequest mr = new MultipartRequest(request, fileDirectory, fileSize, "UTF-8" , new DefaultFileRenamePolicy());
		
		String report_title = mr.getParameter("report_title").trim();
		String mem_id_report = mr.getParameter("report_mem_id").trim();
		String mem_id = mr.getParameter("report_member").trim();
		String report_cause = mr.getParameter("report_cause").trim();
		String report_content = mr.getParameter("report_content").trim();
		
		ReportDTO dto = new ReportDTO();
		
		dto.setReport_title(report_title);
		dto.setMem_id_report(mem_id_report);
		dto.setReport_cause(report_cause);
		dto.setReport_content(report_content);
		
		
		UserDAO dao1 = UserDAO.getinstance();
		int output = dao1.getmemberid(mem_id);
		if(output == 1) {
			String mem_id_reported = mr.getParameter("report_member").trim();
			dto.setMem_id_reported(mem_id_reported);
		}else if(output == 2) {
			String mem_name_reported = mr.getParameter("report_member").trim();
			dto.setMem_name_reported(mem_name_reported);
		}
		
		
		ReportDAO dao = ReportDAO.getInstance();
		
		File report_image = mr.getFile("report_image");
		
		if(report_image != null) {  // 첨부파일이 존재하는 경우
			
			// 우선은 첨부파일의 이름을 알아야 함.
			// getName() 메서드를 이용하면 이름을 알 수 있음.
			String fileName = report_image.getName();
			
			// 날짜 객체 생성
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			// ....../upload/2022-10-11
			String homedir =
					fileDirectory+"/"+year+"-"+month+"-"+day;
			
			// 날짜 폴더를 만들어 보자.
			File path1 = new File(homedir);
			
			if(!path1.exists()) {  // 폴더가 존재하지 않는 경우
				path1.mkdir();  // 실제 폴더를 만들어 주는 메서드.
			}
			
			// 파일을 만들어 보자 ==> 예) 홍길동_파일명 
			// ......../upload/2022-10-11/홍길동_파일명
			String reFileName = fileName;
			
			report_image.renameTo(new File(homedir+"/"+reFileName));
			
			// 실제로 DB에 저장되는 파일 이름
			// "/2022-10-11/홍길동_파일명" 으로 저장할 예정.
			String fileDBName = "/"+year+"-"+month+"-"+day+"/"+reFileName;
			
			dto.setReport_image(fileDBName);
		}
		int res = 0;
		if(dto.getReport_image() != null) {
			
			res = dao.insertReport(dto);
		}else {
			res = dao.insertReport_noneImage(dto);
		}
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("CS_privateQ.do");
		}else {
			out.println("<script>");
			out.println("alert('추가 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}
}
