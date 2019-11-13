<%@page import="com.exam.repository.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	//세션값 배열로 가져오기
	String[] memberid = request.getParameterValues("memberid");
	if(memberid == null){
		%>
		<script>
			alert('선택해주세요.');
			history.back();
		</script>
		<%
		return;
	}
	
	MemberDao memberDao =MemberDao.getInstance();
	memberDao.deleteMembers(memberid);
%>
<script>
	alert('삭제완료');
	location.href='../member/memberlist.jsp';
</script>