package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.user.util.Gmail;

@WebServlet("/admin_findPwdEmailAuth.do")
public class admin_findPwdEmailAuth extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    public admin_findPwdEmailAuth() {
        super();
        // TODO Auto-generated constructor stub
    }

   protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // 비밀번호 찾기 페이지2(member_fidPwd_2.jsp) 폼페이지에서 ajax로 넘어온 이메일로 
      // 인증번호를 보내는 비즈니스 로직.
      String mem_email = request.getParameter("mem_email").trim();
      
      // 인증번호 생성
      // 1. 난수 발생위한 Random 객체 선언
      Random random = new Random();
      
      // 111111 ~ 999999 범위의 숫자를 얻기 위해서 nextInt(888888) + 111111를 사용
      int authNum = random.nextInt(888888) + 111111;
      
      String host = "http://localhost:8282/Semi_Challengers/";
      String from = "coya0319@gmail.com";   // 보내는 구글 이메일 계정
      String to = mem_email;   // 받는 이메일 계정
      String subject = "챌린저스 비밀번호 찾기 인증 번호입니다.";   // 메일 제목
      String content = "홈페이지를 방문해주셔서 감사합니다." +
                      "<br><br>" + 
                      "인증 번호는 [" + authNum + "] 입니다." + 
                      "<br>" + 
                      "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; // 메일 내용
      Properties p = new Properties();
      p.put("mail.smtp.user", from);   
      p.put("mail.smtp.host", "smtp.gmail.com"); // 구글에서 제공하는 smtp 서버
      p.put("mail.smtp.port", "465");   // 구글이 제공하는 포트
      p.put("mail.smtp.starttls.enable", "true");
      p.put("mail.smtp.auth", "true");
      p.put("mail.smtp.debug", "true");
      p.put("mail.smtp.socketFactory.port", "465");
      p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
      p.put("mail.smtp.socketFactory.fallback", "false");
      p.put("mail.smtp.ssl.protocols", "TLSv1.2"); // 추가된 코드
      p.put("mail.smtp.ssl.enable", "true");  // 추가된 코드
      
      try {
         Authenticator auth = new Gmail();
         Session ses = Session.getInstance(p, auth);
         ses.setDebug(true);
         // MimeMessage : 실제로 메일 보내는 객체
         MimeMessage msg = new MimeMessage(ses);
         msg.setSubject(subject);                     // 메일 제목
         Address fromAddr = new InternetAddress(from);      // 보내는 사람 정보
         msg.setFrom(fromAddr);
         Address toAddr = new InternetAddress(to);         // 받는 사람 정보
         msg.addRecipient(Message.RecipientType.TO, toAddr);   
         msg.setContent(content, "text/html;charset=UTF8");   // 메일 내용
         Transport.send(msg);                         // 실제로 메세지를 전송.
      } catch (Exception e) {
         e.printStackTrace();
         PrintWriter out = response.getWriter();
         out.println("<script>");
         out.println("alert('오류가 발생했습니다.')");
         out.println("history.back();");
         out.println("</script>");
         out.close();
      }   
      
        Map<String, Integer> map = new HashMap<>();
        
        map.put("authNum", authNum);
        
        JSONObject jsonObj = new JSONObject(map);

        response.getWriter().print(jsonObj.toString());      
   }

}