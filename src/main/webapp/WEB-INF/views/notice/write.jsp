<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<link href="../css/subpage.css" rel="stylesheet" type="text/css"  media="all">
    <jsp:include page="../include/common_head.jsp"></jsp:include>
    <title>글쓰기 페이지 </title>
</head>

<body class="full-width full-page page " style="background-color: grey;" >
<%
String id = (String) session.getAttribute("id");
//세션값없으면 로그인페이지이동
if( id == null){
	%>
	<script>
		alert('로그인하세요');
	</script>
	<%
	response.sendRedirect("../member/login.jsp");
	return;
}
%>
<div id="wrap">
	<%--헤더링크 --%>
	<jsp:include page="../include/header.jsp"></jsp:include>



<article>
    
<h1>자유게시판</h1>

<form class="basic-form" action="writeProcess.jsp" method="post" name="frm">
<table id="notice">

	<tr>
		<th class="twrite">아이디</th>
		<td class="left" width="300">
			<input type="text" name="username" value="<%=id %>" readonly>
		</td>
	</tr>

	<tr>
		<th class="twrite">제목</th>
		<td class="left">
			<input type="text" name="subject">
		</td>
	</tr>
	<tr>
		<th class="twrite">내용</th>
		<td class="left">
			<textarea name="content" rows="13" cols="100"></textarea>
		</td>
	</tr>
</table>

<div class="basic-form">
	<input type="submit" value="글쓰기" class="btn"><input type="reset" value="다시작성" class="btn"><input type="button" value="목록보기" class="btn" onclick="location.href='notice.jsp';">
</div>
</form>

</article>
    
    
    
	<div class="clear"></div>
    
    <!-- 푸터 영역 -->
	<jsp:include page="../include/footer.jsp" />
</div>

</body>
</html>   

    