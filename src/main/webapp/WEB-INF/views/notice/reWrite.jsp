<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/subpage.css" rel="stylesheet" type="text/css"  media="all">
	<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
</head>
<body>
	<div>
 		<%--헤더링크 --%>
		<jsp:include page="../include/header.jsp"></jsp:include>
	
		<%--세션값가져오기 --%>
		<% 
		String id = (String)session.getAttribute("id"); 
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
		//파라미터값 가져오기
		String reRef =request.getParameter("reRef");
		String reLev = request.getParameter("reLev");
		String reSeq = request.getParameter("reSeq");
		
		%>
		
		<article id="C">
			<h1>답글쓰기</h1>
			<form action="reWriteprocess.jsp" method="post" name="frm" class="basic-form">
				<input type="hidden" name="reRef" value="<%=reRef %>" />
				<input type="hidden" name="reLev" value="<%=reLev %>" />
				<input type="hidden" name="reSeq" value="<%=reSeq %>" />
				<table id="con">
					<tr>
					 	<th><label>아이디</label></th>
					 	<td>
					 		<input type="text" name="username" value="<%=id %>" readonly="readonly" />
					 	</td>
					</tr>
				<tr>
					<th><label>제목</label></th>
					<td>
						<input type="text" name="subject" value="답글:" />
					</td>
				</tr>
				<tr>
					<th><label>내용</label></th>
					<td>
						<textarea name="content" rows="20" cols="40"></textarea>
					</td>
				</tr>
				</table>
				
				<div id="table_search">
					<input type="submit" value="답글쓰기" class="BB"/>
					<input type="reset" value="다시작성" class="BB"/>
					<input type="button" value="목록보기" class="BB" onclick="location.href='notice.jsp';"/>
				</div>
			</form>
		</article>
		<%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
	</div>

</body>
</html>