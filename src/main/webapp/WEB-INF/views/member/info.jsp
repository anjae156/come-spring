<%@page import="com.exam.repository.MemberDao"%>
<%@page import="com.exam.domain.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 횐님!</title>
<style>

fieldset#member{
    text-align: center;
    margin-bottom: 6vh;
}

</style>
</head>
<body>
<%--헤더링크 --%>
   <jsp:include page="../include/header.jsp"></jsp:include>
<%
String id = (String)session.getAttribute("id");
MemberDao memberDao = MemberDao.getInstance();
MemberVO member = memberDao.getMember(id); 
// 세션값없으면 로그인페이지이동
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
<%
request.setCharacterEncoding("UTF-8");
%>
<h1>우리횐님정보!</h1>
<form class="basic-form">
	<fieldset id="member">
		<legend>내정보</legend>
		<label>아이디</label><input type="text" name="id" value="<%=member.getId() %>" readonly="readonly"><br />
		<label>패스워드</label><input type="password" name="passwd" value="<%=member.getPasswd() %>" readonly="readonly"><br />
		<label>이름</label><input type="text" name="name" value="<%=member.getName() %>" readonly="readonly"><br />
		<label>나이</label><input type="text" name="age" value="<%=member.getAge() %>" readonly="readonly"><br />
		<label>성별</label><input type="text" name="gender" value="<%=member.getGender() %>" readonly="readonly"><br />
		<label>휴대폰</label><input type="tel" name="mtel" value="<%=member.getMtel() %>" readonly="readonly"><br />
		<label>집전화</label><input type="tel" name="tel" value="<%=member.getTel() %>" readonly="readonly"><br />
		<label>이메일</label><input type="email" name="email" value="<%=member.getEmail() %>" readonly="readonly"><br />
		<label>가입날짜</label><input type="text" name="regdate" value="<%=member.getRegDate() %>" readonly="readonly"><br />
	</fieldset>
	<button class="BB" type="button" onclick="location.href='../member/update.jsp';">정보수정</button>
	<button class="BB" type="button" onclick="location.href='../member/delete.jsp';">회원삭제</button>
	<button class="BB" type="button" onclick="location.href='../main/admin.jsp';">관리자 페이지</button>
</form>


	<%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
</body>
</html>