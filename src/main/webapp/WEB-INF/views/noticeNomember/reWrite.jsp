<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글쓰기</title>
<%--CSS링크 --%>
<jsp:include page="../include/common_head.jsp"></jsp:include>
<style type="text/css">
article {
	margin-top: 10vh
}
</style>

</head>
<body style="background-color: grey">
	<div>
		<%--헤더링크 --%>
		<jsp:include page="../include/header.jsp"></jsp:include>


		<article id="C">
			<h1>답글쓰기</h1>
			<form action="/boardno/reple" method="post" name="frm"
				class="basic-form">
				<input type="hidden" name="reRef" value="${boardVO.reRef}" /> 
				<input type="hidden" name="reLev" value="${boardVO.reLev}" /> 
				<input type="hidden" name="reSeq" value="${boardVO.reSeq}" />
				<table id="con">

					<tr>
						<th><label>이름</label></th>
						<td><input type="text" name="username" /></td>
					</tr>
					<tr>
						<th><label>비밀번호</label></th>
						<td><input type="password" name="passwd" /></td>
					</tr>
					<tr>
						<th><label>제목</label></th>
						<td><input type="text" name="subject" value="답글:" /></td>
					</tr>
					<tr>
						<th><label>내용</label></th>
						<td><textarea name="content" rows="20" cols="40"></textarea>
						</td>
					</tr>
				</table>

				<div id="table_search">
					<input type="submit" value="답글쓰기" /> 
					<input type="reset" value="다시작성" /> 
					<input type="button" value="목록보기" onclick="location.href='/boardno/list';" />
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