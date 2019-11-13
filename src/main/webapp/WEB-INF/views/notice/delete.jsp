<%@page import="com.exam.domain.BoardVO"%>
<%@page import="com.exam.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
// 파라미터값 가져오기 num, pageNum
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

//dao객체 준비
BoardDao boardDao= BoardDao.getInstance();
//수정할 글 가져오기
BoardVO boardVO = boardDao.getBoard(num);
%>

<%--세션값 가져오기 --%>
<%

String id = (String) session.getAttribute("id");
%>

<%!
//로그인 안한 사용자가 로그인한 사용자 글을 삭제하는경우
//로그인한 사용자가 로그인 안한 사용자글 을 삭제하는경우
// 로그인한 사용자의경우, 세션값id가 게시글 작성자명과 다른 경우
// "수정권한 없음" 알림후 글목록 페이지로 강제이동 
boolean hasNotAuth(String id, BoardVO boardVO){
	boolean result =
			id ==null && boardVO.getPasswd() == null
		 || id !=null && boardVO.getPasswd() != null
		 || id !=null && !id.equals(boardVO.getUsername());
	return result;
}
%>

<%
if( hasNotAuth(id, boardVO)){
	%> 
	<script>
		alert('삭제권한이 없습니다');
		history.back();
	</script>
	<%
	return;
}
%>
<head>
	<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
	<script>
		function check() {
			var objpasswd = document.frm.passwd;
			if(objpasswd!= null){
				if(objpasswd.value.length==0){
					alert('패스워드는 필수입력사항입니다.');
					objpasswd.focus();
					return false;
				}
			}
		}
	</script>
<meta charset="UTF-8">
<title>삭제</title>
</head>
<body>
<%--헤더링크 --%>
   <jsp:include page="../include/header.jsp"></jsp:include>
   <div id="wrap">
   	<article>
   	<h1>삭--제</h1>
   	
   	<% if(id == null){ %>
   			<form action="deleteProcess.jsp" method="post" name="frm" onsubmit="return check();">
   			<%--수정할 글번호는 눈에 안보이는 히든타입입력요소사용 --%>
   			<input type="hidden" name="pageNum" value="<%=pageNum%>">
   			<input type="hidden" name="num" value="<%=num%>">
   			
   			<table>
   				<tr>
   				<th>글 패스워드</th>
   				<td><input type="password" name="passwd" /></td>
   				</tr>
   			</table>
   			
   			<div>
   				<input type="submit" value="글삭제" />
   				<input type="reset"  value="다시작성" />
   				<input type="button" value="목록보기" onclick="location.href='notice.jsp?pageNum=<%=pageNum %>';" />
   			</div>
   			</form>
   	<%
   		}else{
   			response.sendRedirect("deleteProcess.jsp?num="+num+"&pageNum="+pageNum);
   		}
   	%>
   	
   	</article>
   
   </div>
   <%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>

</body>
</html>