package com.category.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.category.medel.CategoryDAO;
import com.category.medel.CategoryDTO;
import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class CategoryInsertAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)throws IOException, Exception {
		String filedirectory = "C:\\Users\\user1\\git\\team2_semi_challengers\\WebContent\\uploadFile";
		int filesize = 10*1024*1024;
		MultipartRequest mr = new MultipartRequest(request, filedirectory, filesize, "UTF-8",new DefaultFileRenamePolicy());
		String category_code = mr.getParameter("category_code").trim();
		String category_name = mr.getParameter("category_name").trim();
		//String category_image = mr.getFilesystemName("category_image").trim();
		
		CategoryDTO dto = new CategoryDTO();
		dto.setCategory_code(category_code);
		dto.setCategory_name(category_name);
		//dto.setCategory_image(category_image);
		
		CategoryDAO dao = CategoryDAO.getInstance();
		File category_image = mr.getFile("category_image");
		
		if(category_image != null) {  // 첨부파일이 존재하는 경우
			
			// 우선은 첨부파일의 이름을 알아야 함.
			// getName() 메서드를 이용하면 이름을 알 수 있음.
			String fileName = category_image.getName();
			
			// 날짜 객체 생성
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			// ....../upload/2022-10-11
			String homedir =
					filedirectory+"/"+year+"-"+month+"-"+day;
			
			// 날짜 폴더를 만들어 보자.
			File path1 = new File(homedir);
			
			if(!path1.exists()) {  // 폴더가 존재하지 않는 경우
				path1.mkdir();  // 실제 폴더를 만들어 주는 메서드.
			}
			
			// 파일을 만들어 보자 ==> 예) 홍길동_파일명 
			// ......../upload/2022-10-11/홍길동_파일명
			String reFileName = category_name+"_"+fileName;
			
			category_image.renameTo(new File(homedir+"/"+reFileName));
			
			// 실제로 DB에 저장되는 파일 이름
			// "/2022-10-11/홍길동_파일명" 으로 저장할 예정.
			String fileDBName = "/"+year+"-"+month+"-"+day+"/"+reFileName;
			
			dto.setCategory_image(fileDBName);
			
		}
		int res = dao.insertCategory(dto);
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		if(res > 0) {
			forward.setRedirect(true);
			forward.setPath("category_control.do");
		}else {
			out.println("<script>");
			out.println("alert('추가 실패!')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}
}
