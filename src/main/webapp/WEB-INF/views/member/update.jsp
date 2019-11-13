<%@page import="com.exam.repository.MemberDao"%>
<%@page import="com.exam.domain.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
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
if( id == null){
	response.sendRedirect("login.jsp");
	return;
}
%>
<h1>회원정보수정</h1>

<form name="frm" class="basic-form" action="updateProcess.jsp" method="post">
	<fieldset id="member">
		<legend>내정보</legend>
		<label>아이디</label><input type="text" name="id" value="<%=member.getId() %>" readonly><br />
		<label>패스워드</label><input type="password" name="passwd"><br />
		<label>이름</label><input type="text" name="name" value="<%=member.getName() %>" ><br />
		<label>나이</label><input type="number" name="age" value="<%=member.getAge() %>" ><br />
		<label>성별</label><input type="text" name="gender" value="<%=member.getGender() %>" ><br />
		<label>휴대폰</label><input type="tel" name="mtel" value="<%=member.getMtel() %>" ><br />
		<label>집전화</label><input type="tel" name="tel" value="<%=member.getTel() %>" ><br />
		<label>이메일</label><input type="email" name="email" value="<%=member.getEmail() %>" >
		<label style="display:none;">가입날짜</label><input style="display:none;" type="text" name="regdate" value="<%=member.getRegDate() %>" readonly="readonly">
	</fieldset>
	<button class="BB" type="button" onclick="aa()">수정하기</button>	
	<button class="BB"type="button" onclick="location.href='../index.jsp'">메인화면</button>
</form>
<script>
function aa() {
	if(frm.passwd.value.length==0){
		alert('패스워드를 입력하세요');
		return false;
	}
	frm.submit();
}
</script>
    <%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>