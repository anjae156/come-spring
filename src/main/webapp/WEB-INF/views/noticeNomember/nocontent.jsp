<%@page import="com.exam.repository.BoardDaono"%>
<%@page import="com.sun.org.apache.regexp.internal.recompile"%>
<%@page import="com.exam.domain.RepleVO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.exam.domain.AttachVO"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.repository.AttachDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.repository.BoardDao"%>
<%@page import="com.exam.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
    <title>자유게시판 </title>
</head>
<%
	// 페이지 번호  파라미터값가져오기
String pageNum = request.getParameter("pageNum");
//글번호 num파라미터값 가져오기
int num = Integer.parseInt(request.getParameter("num"));

//dao객체준비 
BoardDaono boardDaono = BoardDaono.getInstance();
// 조회수 1증가 시키는 메소드 호출
boardDaono.updateReadcount(num);
// 글번호에 해당하는 레코드 한개 가져오기
BoardVO boardVO = boardDaono.getBoard(num);
// 글작성 날짜 형식 "yyyy년dd일hh시mm분ss초"
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-hh-MM-ss");


%>
	<body style="background-color: silver;">
		<div id="wrap">
		<%--헤더링크 --%>
		<jsp:include page="../include/header.jsp"></jsp:include>
			<article id="page1">
				<h1>게시물</h1>
				<table id="con">
					<pre style="background-color: white; font-family:inherit; font-size: x-large; min-height: 50vh; min-width: 50vh" ><%=boardVO.getContent() %></pre>
					<tr>
						<th><label> 글번호</label></th>
						<td width="200"><%=boardVO.getNum() %></td>
						<th ><label>조회수</label></th>
						<td width="200"><%=boardVO.getReadcount() %></td>
					</tr>
					<tr>
						<th><label>작성자명</label></th>
						<td><%=boardVO.getUsername() %></td>
						<th><label>작성일자</label></th>
						<td><%=sdf.format(boardVO.getRegDate()) %></td>  
					</tr>
					<tr>
						<th><label>글제목</label></th>
						<td colspan="3"><%=boardVO.getSubject() %></td>
					</tr>
					
					
						
					
					
				</table>

				
				<div>
					<input type="button" value="글수정" class="BB"  onclick="location.href='noupdate.jsp?num=<%=boardVO.getNum() %>&pageNum=<%=pageNum %>';"/>
					<input type="button" value="글삭제" class="BB" onclick="checkDelete();"/>
					<input type="button" value="답글쓰기" class="BB" onclick="location.href='reWrite.jsp?reRef=<%=boardVO.getReRef() %>&reLev=<%=boardVO.getReLev() %>&reSeq=<%= boardVO.getReSeq()%>';"/>
					<input type="button" value="목록보기" class="BB" onclick="location.href='noticeNomember.jsp?pagenum=<%=pageNum %>';"/>
				</div>
			
			</article>

			
	<%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
		
		</div>
		<script>
		function checkDelete() {
			var result =confirm('<%= boardVO.getNum()%> 번글을 정말 삭제할건가?');
			
			if(result == true){
				location.href ='delete.jsp?num=<%=boardVO.getNum()%>&pageNum=<%=pageNum%>';
			}
		}
		</script>

</body>
</html>