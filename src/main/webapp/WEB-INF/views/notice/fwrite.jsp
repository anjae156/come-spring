<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<link href="/resources/css/subpage.css" rel="stylesheet" type="text/css"  media="all">
<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
    <title>공략게시판 글쓰기 </title>
</head>

<body class="  full-page back-image5 full-page page">

<div id="wrap">
	<%--헤더링크 --%>
	<jsp:include page="../include/header.jsp"></jsp:include>



<article>
    
<h1>공략게시판 글쓰기</h1>

<form class="basic-form " action="/board/write" method="post" name="frm" enctype="multipart/form-data" onsubmit="return Check();">
<table id="notice">

	<tr>
		<th class="twrite">아이디</th>
		<td class="left" width="300">
			<input type="text" name="username" value="${id}" readonly>
		</td>
	</tr>

	<tr>
		<th class="twrite">제목</th>
		<td class="left">
			<input type="text" name="subject">
		</td>
	</tr>
	<tr>
		<th class="twrite">파일</th>
		<td class="left">
			<div id="file_container">
				<input type="file" name="filename1">
			</div>
			<button type="button" onclick="addFileElement();">파일추가</button>
		</td>
	</tr>
	<tr>
		<th class="twrite">내용</th>
		<td class="left">
			<textarea name="content" rows="13" cols="100"></textarea>
		</td>
	</tr>
</table>

<div id="table_search">
	<input type="submit" value="글쓰기" class="btn">
	<input type="reset" value="다시작성" class="btn">
	<input type="button" value="목록보기" class="btn" onclick="location.href='/board/list';">
</div>
</form>

</article>
    
    
    
	<div class="clear"></div>
    
    <!-- 푸터 영역 -->
	<jsp:include page="../include/footer.jsp" />
</div>

    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>


<script>
var num = 2; //초기값
function addFileElement() {
	if(num > 5){
		alert('최대 5개까지만 올릴수 있어요');
		return;
	}
	
	// div요소에 file타입input요소를 추가하기
	var input = '<br><input type="file" name="filename'+ num +'">';
	num++;// 다음 번추가를 위해 값을 1증가
	
	//id속성값이 파일 컨테이너인 디브요소의 참조 구하기
	var fileContainer = document.getElementById('file_container');
	fileContainer.innerHTML += input;
}
</script>
</body>
</html>   

    