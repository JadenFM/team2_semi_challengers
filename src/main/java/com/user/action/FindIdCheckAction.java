package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chall.controller.Action;
import com.chall.controller.ActionForward;

public class FindIdCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, Exception {
		// 폼페이지에서 넘어온 이름, 이메일에 해당하는 회원 정보가 DB 있는 지 확인 후 아이디를 알려주는 뷰 페이지로 이동하는 비즈니스 로직.
		
		return null;
	}

}
