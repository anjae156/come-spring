<%@page import="com.exam.repository.MemberDao"%>
<%@page import="com.exam.domain.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//세션값 가져오기
	String id = (String)session.getAttribute("id");
	MemberDao memberDao = MemberDao.getInstance();
	MemberVO member = memberDao.getMember(id); 
	//세션값없으면 login.jsp이동
	if(id == null){
		response.sendRedirect("../member/login.jsp");
		return;
	}
%>

<%
	//passwd 파라미터값 가져오기
	String passwd = request.getParameter("passwd");
	int check = memberDao.userCheck(member.getId(), passwd);
	// check 값 1이면 패스워드 일치. 0이면 패스워드 불일치
	if(check == 1){
		// DB회원정보 삭제
		memberDao.deleteMember(member.getId());
		// 세션값 초기화(모두 비우기)
		session.invalidate();
	  	%>
	  	<script>
	  		alert('회원삭제가 성공했습니다.');
	  		location.href='../member/login.jsp';
	  	</script>
	  	<% 
	}else{
		%>
		<script>
			alert('패스워드가 다릅니다.');
			history.back();
		</script>
		<%
	}

%>
