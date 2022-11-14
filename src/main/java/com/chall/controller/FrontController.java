package com.chall.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FrontController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String uri = request.getRequestURI();
		System.out.println("URI >>> " + uri);

		String path = request.getContextPath();
		System.out.println("Path >>> " + path);

		String command = uri.substring(path.length() + 1);
		System.out.println("Command >>> " + command);

		Action action = null;
		ActionForward forward = null;

		Properties pro = new Properties();

		FileInputStream fis = new FileInputStream(

				"C:/Users/user/git/team2_semi_challengers/src/main/java/com/chall/controller/mapping.properties");


		pro.load(fis);

		String value = pro.getProperty(command);
		System.out.println("Value >>> " + value);

		if (value.substring(0, 7).equals("execute")) {
			StringTokenizer st = new StringTokenizer(value, "|");

			String url_1 = st.nextToken();
			String url_2 = st.nextToken();
			
			System.out.println(url_2);

			try {
				Class<?> url = Class.forName(url_2);
				
				Constructor<?> constructor = url.getConstructor();

				action = (Action) constructor.newInstance();

				forward = action.execute(request, response);

				System.out.println("FrontController forward >>> " + forward);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else { // value 값이 "execute"가 아닌 경우
			// view page로 이동
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath(value);
		}

		if (forward != null) {
			if (forward.isRedirect()) { // true인 경우 = Action Class를 호출한 경우
				response.sendRedirect(forward.getPath()); // 재요청함
			} else { // false인 경우 view page로 이동

				RequestDispatcher rd = request.getRequestDispatcher(forward.getPath());
				rd.forward(request, response);

			}
		}

	} // service() 메서드 끝
}
