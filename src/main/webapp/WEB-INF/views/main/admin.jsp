<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="../css/subpage.css" rel="stylesheet" type="text/css"  media="all">
<%
String id = (String)session.getAttribute("id");
if (!id.equals("admin")) {//어드민
	response.sendRedirect("../main/main.jsp");
}
%>

<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body style="background-color: forestgreen">
<article style="margin-top: 10vh;">
<h1>관리자 페이지</h1>
	
	<%--헤더링크 --%>
	<jsp:include page="../include/header.jsp"></jsp:include>

    <button  class="BB" type="button" onclick="location.href='../notice/deletes.jsp'">회원게시글관리</button>
    
    <button  class="BB" type="button" onclick="location.href='../noticeNomember/nodeletes.jsp'">비회원게시글관리</button> 
    
    <button class="BB" type="button" onclick="location.href='../member/memberlist.jsp';">전체회원목록</button>
 	
</article>

</body>
</html>