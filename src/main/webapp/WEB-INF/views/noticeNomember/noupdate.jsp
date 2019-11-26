<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>



<head>
<meta charset="UTF-8">
<title>읍데이트</title>
<link href="../resources/css/subpage.css" rel="stylesheet" type="text/css"  media="all">
<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
</head>
</head>
<body style="background-color: grey">
<%--헤더링크 --%>
   <jsp:include page="../include/header.jsp"></jsp:include>
<article id="C">
	<h1>글수정따쒸</h1>
	<form id="frm" action="/boardno/modify" method="post" class="basic-form" onsubmit="return check();">
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="num" value="${board.num }" />
		<table id="con">
			<tr>
				<th class="twrite"><label>이름</label></th>
				<td class="left" width="300">
					<input type="text" name="username" value="${board.username}">
				</td>
			</tr>
			<tr>
				<th class="twrite"><label>패스워드</label></th>
				<td class="left">
					<input type="password" name="passwd"  placeholder="본인확인 패스워드 입력">
				</td>
			</tr>
			<tr>
				<th class="twrite"><label>제목</label></th>
				<td class="left">
					<input type="text" name="subject"  value="${board.subject}">
				</td>
			</tr>
			<tr>
				<th class="twrite"><label>내용</label></th>
				<td class="left">
					<textarea name="content" rows="13" cols="100">${board.content}</textarea> 
				</td>
			</tr>
		</table>
		<div id="table_search">
			<input type="submit" value="글수정" class="BB" />
			<input type="reset" value="다시작성" class="BB" />
			<input type="button" value="목록보기" class="BB" onclick="location.href='notice.jsp?pageNum=${pageNum}';"/>
		</div>
	</form>
</article>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	function check() {
		var objPasswd = frm.passwd;
		if(objPasswd != null){
			if(objPasswd.value.length < 1){
				alert('게시글 패스워드는 필수입력사항입니다.');
				objPasswd.focus();
				return false;
			}
		}
		//글수정 의도 확인하기
		var result = confirm('${board.num}번글을 정말로 수정하시겠습니까?');
		if(result == false){
			return false;
		}
	}//check
	
	
	
		
</script>
<%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
</body>
</html>