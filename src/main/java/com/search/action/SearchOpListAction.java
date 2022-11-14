package com.search.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.print.attribute.standard.MediaSize.NA;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;
import com.search.model.SearchDAO;


public class SearchOpListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		
		String optionCy = request.getParameter("optionCy").trim();
		String optionCa = request.getParameter("optionCa").trim();
		String optionDu = request.getParameter("optionDu").trim();
		String keyword = request.getParameter("keyword").trim();
		int page = Integer.parseInt(request.getParameter("page").trim());
		
		// 카테고리를 마지막 인자에 추가
		if(!optionCy.equals("")) { 
			optionCy += ",chall_cycle";
		}
		if(!optionDu.equals("")) {
			optionDu += ",chall_duration";
		}
		if(!optionCa.equals("")) {
			optionCa += ",chall_category_code_fk";
		}
		
		
		String[] spOptionCy = null;
		String[] spOptionDu = null;
		String[] spOptionCa = null;
		String str = "";
		
		SearchDAO dao = SearchDAO.getinstance();
		
		if(!optionCy.equals("") && !optionDu.equals("") && !optionCa.equals("")) { // 모두 선택한 경우
			
			if(optionCy.contains(",")) { // 체크박스 2개 이상 선택
				spOptionCy = optionCy.split(",");
			}else { // 체크박스 하나만 선택
				spOptionCy = new String[1];
				spOptionCy[0] = optionCy;
			}
			if(optionDu.contains(",")) {
				spOptionDu = optionDu.split(",");
			}else {
				spOptionDu = new String[1];
				spOptionDu[0] = optionDu;
			}
			if(optionCa.contains(",")) {
				spOptionCa = optionCa.split(",");
			}else {
				spOptionCa = new String[1];
				spOptionCa[0] = optionCa;
			}
			str = dao.getOptionList(spOptionCy, spOptionDu, spOptionCa, keyword, page);
			
			
		}else if(!optionCy.equals("") && !optionDu.equals("") && optionCa.equals("")) { // 기간, 빈도 두 개만 선택한 경우
			
			if(optionCy.contains(",")) { // 체크박스 2개 이상 선택
				spOptionCy = optionCy.split(",");
			}else { // 체크박스 하나만 선택
				spOptionCy = new String[1];
				spOptionCy[0] = optionCy;
			}
			if(optionDu.contains(",")) {
				spOptionDu = optionDu.split(",");
			}else {
				spOptionDu = new String[1];
				spOptionDu[0] = optionDu;
			}
			str = dao.getOptionList(spOptionCy, spOptionDu, keyword, page);
			
		}else if(!optionCy.equals("") && optionDu.equals("") && !optionCa.equals("")){ // 기간, 카테고리 두 개만 선택한 경우
			if(optionCy.contains(",")) { // 체크박스 2개 이상 선택
				spOptionCy = optionCy.split(",");
			}else { // 체크박스 하나만 선택
				spOptionCy = new String[1];
				spOptionCy[0] = optionCy;
			}
			if(optionCa.contains(",")) {
				spOptionCa = optionCa.split(",");
			}else {
				spOptionCa = new String[1];
				spOptionCa[0] = optionCa;
			}
			str = dao.getOptionList(spOptionCy, spOptionCa, keyword, page);
			
		}else if(optionCy.equals("") && !optionDu.equals("") && !optionCa.equals("")){ // 빈도, 카테고리 두 개만 선택한 경우
			if(optionCa.contains(",")) { // 체크박스 2개 이상 선택
				spOptionCa = optionCa.split(",");
			}else { // 체크박스 하나만 선택
				spOptionCa = new String[1];
				spOptionCa[0] = optionCa;
			}
			if(optionDu.contains(",")) {
				spOptionDu = optionDu.split(",");
			}else {
				spOptionDu = new String[1];
				spOptionDu[0] = optionDu;
			}
			str = dao.getOptionList(spOptionCa, spOptionDu, keyword, page);
			
		}else if(!optionCy.equals("")) { // 기간만 선택한 경우
			
			if(optionCy.contains(",")) {
				spOptionCy = optionCy.split(",");
			}else {
				spOptionCy = new String[1];
				spOptionCy[0] = optionCy;
			}
			str = dao.getOptionList(spOptionCy, keyword, page);
				
		}else if(!optionDu.equals("")) { // 빈도만 선택한 경우
			
			if(optionDu.contains(",")) {
				spOptionDu = optionDu.split(",");
			}else {
				spOptionDu = new String[1];
				spOptionDu[0] = optionDu;
			}
			str = dao.getOptionList(spOptionDu, keyword, page);
		}else if(!optionCa.equals("")) { // 카테고리만 선택한 경우
			
			if(optionCa.contains(",")) {
				spOptionCa = optionCa.split(",");
			}else {
				spOptionCa = new String[1];
				spOptionCa[0] = optionCa;
			}
			str = dao.getOptionList(spOptionCa, keyword, page);
		}
			
		
		if(str.equals("<chall_lists></chall_lists>")) {
			str = "1";
		}
		
		PrintWriter out = response.getWriter();
		
		out.println(str);
		
		
		return null;
	}

	

}