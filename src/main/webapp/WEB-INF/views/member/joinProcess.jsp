<%@page import="com.exam.repository.MemberDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% 
 // 한글처리
 request.setCharacterEncoding("UTF-8");%>
 <%--// 자비빈 객체 생성 --%>
 <jsp:useBean id="memberVO" class="com.exam.vo.MemberVO"></jsp:useBean>
 <%-- 자바빈 객체에 파라미터값 찾아서 저장하기 --%>
 <jsp:setProperty property="*" name="memberVO"/>
 <%--가입날짜 자바빈에 저장하기 --%>
 <%memberVO.setRegDate(new Timestamp(System.currentTimeMillis()));%>
 <%--DAO객체 준비 --%>
 <% MemberDao memberDao = MemberDao.getInstance(); %>
 <%--회원가입 메소드 호출 --%>
 <% memberDao.insertMember(memberVO);%>
 
 <%--로그인 페이지로 이동 --%>
 <script>
 alert('회원가입 되었슴다 \n로그인 페이지로 이동합니다.');
 location.href = 'login.jsp';
 </script>
 
 
 