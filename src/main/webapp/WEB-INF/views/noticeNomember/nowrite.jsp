<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<link href="/resources/css/subpage.css" rel="stylesheet" type="text/css"  media="all">
    <jsp:include page="../include/common_head.jsp"></jsp:include>
    <title>글쓰기 페이지 </title>
</head>

<body class="full-width back-image5 full-page page">
<div id="wrap">
	<%--헤더링크 --%>
	<jsp:include page="../include/header.jsp"></jsp:include>


<article>
    
<h1>자유게시판</h1>

<form class="basic-form" action="/boardno/write" method="post" name="frm" onsubmit="return check();" accept-charset="utf-8">
<table id="notice">
	<tr>
		<th class="twrite">이름</th>
		<td class="left" width="300">
			<input type="text" name="username" id="username">
		</td>
	</tr>
	<tr>
		<th class="twrite">패스워드</th>
		<td class="left">
			<input type="password" name="passwd">
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
	<input type="submit" value="글쓰기" class="btn">
	<input type="reset" value="다시작성" class="btn">
	<input type="button" value="목록보기" class="btn" onclick="location.href='/boardno/list';">
</div>
</form>

</article>
    
    
    
	<div class="clear"></div>
    
    <!-- 푸터 영역 -->
	<jsp:include page="../include/footer.jsp" />
</div>
<script>
function check() {
	if(frm.username.value.length < 2){
		alert('이름은 2글자 이상으로부탁드립니다.')
		frm.username.select();
		return false;
	}
	if(frm.passwd.value.length < 3){
		alert('비밀번호는 3글자 이상으로 부탁드립니다.')
		frm.passwd.select();
		return false;
	}
	if(frm.subject.value.length < 2){
		alert('제목은 2글자이상입니다.')
		frm.subject.select();
		return false;
	}
	if(frm.content.value.length < 2){
		alert('내용이 부족합니다')
		frm.content.select();
		return false;
	}
	if(frm.content.value.length > 100){
		alert('회원가입하고 길게써보자!')
		frm.content.select();
		return false;
	}
	return true;
}
function backCheck() {
	
}

</script>

</body>
</html>   

    