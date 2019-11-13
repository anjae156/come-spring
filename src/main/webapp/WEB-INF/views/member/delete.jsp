<%@page import="com.exam.repository.MemberDao"%>
<%@page import="com.exam.domain.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
fieldset.member {
	text-align: center;
}

</style>
<meta charset="UTF-8">
<title>회원삭제</title>
<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
</head>
<body>
<%--헤더링크 --%>
   <jsp:include page="../include/header.jsp"></jsp:include>
<%
// 세션값가져오기	
String id = (String)session.getAttribute("id");
	MemberDao memberDao = MemberDao.getInstance();
	MemberVO member = memberDao.getMember(id); 

	if (id == null) {
		%>
		<script>
			alert('로그인부터 합시다.');
		</script>
		<%
		response.sendRedirect("../member/login.jsp");
		return;
	}
%>
	<h1>회원정보 삭제</h1>
	<form class="basic-form" action="deleteProcess.jsp" method="post">
		<fieldset class="member">
		<label>아이디</label><input type="text" value="<%=member.getId() %>" disabled/><br>
		<br>
		<label>패스워드</label><input type="password" name="passwd" /><br>
		<button class="BB" type="submit">회원삭제하기</button>
		</fieldset>
	</form>	
	 <%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>