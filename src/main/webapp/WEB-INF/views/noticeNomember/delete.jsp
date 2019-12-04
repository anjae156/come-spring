
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
	
<meta charset="UTF-8">
<title>삭제</title>
</head>
<body>
<%--헤더링크 --%>
   <jsp:include page="../include/header.jsp"></jsp:include>
   <div id="wrap">
   	<article>
   	<h1>삭--제</h1>
   	
   			<form action="/boardno/delete" method="post" name="frm" onsubmit="return check();">
   			<%--수정할 글번호는 눈에 안보이는 히든타입입력요소사용 --%>
   			<input type="hidden" name="pageNum" value="${pageNum}">
   			<input type="hidden" name="num" value="${num}">
   			
   			<table>
   				<tr>
   				<th>글 패스워드</th>
   				<td><input type="password" name="passwd" /></td>
   				</tr>
   			</table>
   			
   			<div>
   				<input type="submit" value="글삭제" />
   				<input type="reset"  value="다시작성" />
   				<input type="button" value="목록보기" onclick="location.href='boardno/list?pageNum=${pageNum}';" />
   			</div>
   			</form>
 
   	
   	</article>
   
   </div>
   <%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
    <script>
		function check() {
			var result = confirm('${num}번글을 정말로 삭제하시겠습니까?');
			if(result == false){
				return false;
			}
			
			
			var strpasswd = document.frm.passwd.value.trim();
			if(strpasswd.length==0){
				alert('글 패스워드는 필수입력사항입니다.');
				strpasswd.focus();
				return false;
			}
			return true;
		}
	</script>

</body>
</html>