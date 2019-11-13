<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 // 로그인 상태유지용쿠키 삭제하기
 Cookie[] cookies = request.getCookies();
 if(cookies != null){
	 for(Cookie cookie : cookies){
		 if(cookie.getName().equals("id")) {
			 cookie.setMaxAge(0);// 쿠키 유효기간 0초 설정 브라우저가 해당쿠키 삭제
			 cookie.setPath("/");
		 }
	 }
 }
 
 // 세션값 초기화
 session.invalidate();
 // "로그아웃됨"  index.jsp 로 이동
 
 %>
 <script>
 alert('로그아웃 되었습니다.');
 location.href ='../index.jsp';
 </script>