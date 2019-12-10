<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
    <title>자유게시판 </title>
</head>
	<body style="background-color: silver;">
		<div id="wrap">
		<%--헤더링크 --%>
		<jsp:include page="../include/header.jsp"></jsp:include>
			<article id="page1">
				<h1>게시물</h1>
				<table id="con">
					<tr>
						<th><label> 글번호</label></th>
						<td width="200">${board.num}</td>
						<th ><label>조회수</label></th>
						<td width="200">${board.readcount}</td>
					</tr>
					<tr>
						<th><label>작성자명</label></th>
						<td>${board.userName}</td>
						<th><label>작성일자</label></th>
						<td><fmt:formatDate value="${board.regDate}" pattern="yyyy년MM월dd일"/></td>
					</tr>
					<tr>
						<th><label>글제목</label></th>
						<td colspan="3">${board.subject}</td>
					</tr>
						<tr>
							<th class="twrite"><label>파일</label></th>
							<td class="left" colspan="3" style="border: 1">
							<c:forEach var="attach" items="${attachList}">
								<c:choose>
									<c:when test="${attach.filetype eq 'I' }"><%--이미지타입 파일이면 --%>
									<a href="../upload/<%=attachVO.getFilename() %>">
											<img src="../upload/<%=attachVO.getFilename() %>"  height="">
										</a><br>
									</c:when>
								</c:choose>
							</c:forEach>
								<%
								for (AttachVO attachVO : attachList) {
									if (attachVO.getFiletype().equals("I")) { // 이미지 타입
										%>
										<a href="../upload/<%=attachVO.getFilename() %>">
											<img src="../upload/<%=attachVO.getFilename() %>"  height="">
										</a><br>
										<%
									} else {
										%>
										<a href="../upload/<%=attachVO.getFilename() %>" download>
											<%=attachVO.getFilename() %>
										</a><br>
										<%
									}
								} // for
								%>
							</td>
						</tr>
						<tr colspan="3">
						<pre style="text-align:center; background-color: white; font-family:inherit; font-size: x-large; min-height: 20vh" ><%=boardVO.getContent() %></pre>
						</tr>
					
				</table>

				
				<div>
					<input type="button" value="글수정" class="BB"  onclick="location.href='fupdate.jsp?num=<%=boardVO.getNum() %>&pageNum=<%=pageNum %>';"/>
					<input type="button" value="글삭제" class="BB" onclick="checkDelete();"/>
					<input type="button" value="답글쓰기" class="BB" onclick="location.href='reWrite.jsp?reRef=<%=boardVO.getReRef() %>&reLev=<%=boardVO.getReLev() %>&reSeq=<%= boardVO.getReSeq()%>';"/>
					<input type="button" value="목록보기" class="BB" onclick="location.href='notice.jsp?pagenum=<%=pageNum %>';"/>
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