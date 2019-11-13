<%@page import="org.apache.commons.mail.SimpleEmail"%>
<%@page import="com.exam.repository.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");

String adminEmail = request.getParameter("adminSend"); 
String adminEmailSubject = request.getParameter("subject");
String adminEmailContent = request.getParameter("content");  

System.out.println(adminEmail); 
System.out.println(adminEmailSubject);
System.out.println(adminEmailContent);

   // 메일 전송기능 라이브러리 준비

      // SMTP 서버 계정정보 : 로그인할 아이디, 패스워드 
   long beginTime = System.currentTimeMillis();
   // ------------------------------------------
   
   // 1. SimpleEmail 객체 생성
   
   SimpleEmail email = new SimpleEmail();
   // SMTP 서버 연결 설정
   email.setHostName("smtp.naver.com");
   email.setSmtpPort(465);
   email.setAuthentication("workingjack91", "SD9XCBBKV6U1");

      // 보내는 사람은 비밀번호만 알면 된다.
   
   // SMTP SSL, TLS 설정
   email.setSSLOnConnect(true);
   email.setStartTLSEnabled(true);
   
   String result = "fail";
   
   try {
      // 보내는 사람 설정
      email.setFrom("workingjack91@naver.com" , "관리자" , "utf-8");
      
      // 받는사람 설정
      email.addTo(adminEmail, "회원", "utf-8");

      // 제목 설정
      email.setSubject(adminEmailSubject);
      // 본문 설정
      email.setMsg(adminEmailContent);
      // 메일 전송
      result = email.send(); 
      
      
   } catch (Exception e) {
      e.printStackTrace();
   }
   
   long endTime = System.currentTimeMillis();
   
   long execTime = endTime - beginTime; // 이메일 전송에 걸린 시간
   System.out.println("execTime : " + execTime + " 밀리초 걸림");
   System.out.println("result : " + result);
   
   


%>
<script>
   alert('메일전송완료');
   location.href = 'memberEmailList.jsp';
</script>