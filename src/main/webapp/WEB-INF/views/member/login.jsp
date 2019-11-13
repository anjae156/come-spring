<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
<title>로그인 페이지</title>
</head>
<body>
<%--헤더링크 --%>
<jsp:include page="../include/header.jsp"></jsp:include>
<div>

<h1>login</h1>
<form action="loginProcess.jsp" name="" class="basic-form button">
<fieldset>
<legend hidden="">로그인 인포</legend>
<label>아이디</label>
<input type="text" name="id" /> <br>
<label>비밀번호</label>
<input type="password" name="passwd"/><br>
<label>기억하기</label>
<input type="checkbox" name="checkbox" value="true" />
</fieldset>

<div>
<input type="submit" value="로그인" class="BB" />
<input type="button" value="회원가입" class="BB" onclick="location.href='join.jsp'" />
<input type="reset" value="초기화" class="BB" />
</div>

</form>
</div>
	<%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
</body>
</html>