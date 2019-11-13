<%@page import="com.exam.repository.BoardDaono"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.exam.domain.AttachVO"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.repository.AttachDao"%>
<%@page import="com.exam.repository.BoardDao"%>
<%@page import="com.exam.repository.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
if (!id.equals("admin")) {//어드민
	response.sendRedirect("../main/main.jsp");
}
	request.setCharacterEncoding("utf-8");

	String[] num = request.getParameterValues("delnum");
	if(num== null){
		%>
		<script>
			alert('선택좀요...');
			history.back();
		</script>
		<%
		return;
	}
	
	BoardDaono boardDaono =BoardDaono.getInstance();
	
	
	boardDaono.deleteBoard(num);  
%>
<script>
	alert('삭제완료');
	location.href='../noticeNomember/nodeletes.jsp';
</script>