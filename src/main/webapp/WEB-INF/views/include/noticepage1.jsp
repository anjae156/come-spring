<%@page import="com.exam.repository.BoardDaono"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%--CSS링크 --%>
<jsp:include page="../include/common_head.jsp"></jsp:include>
<link href="../css/subpage.css" rel="stylesheet" type="text/css"  media="all">
    <%
// 파라미터값 search  pageNum 가져오기
String search = request.getParameter("search"); // 검색어
if (search == null) {
	search = "";
}

String strPageNum = request.getParameter("pageNum");
if (strPageNum == null) {
	strPageNum = "1";
}
// 페이지 번호
int pageNum = Integer.parseInt(strPageNum);

// DAO 객체 준비
BoardDaono boardDaono = BoardDaono.getInstance();

// 한페이지(화면)에 보여줄 글 개수
int pageSize = 10;

// 시작행번호 구하기
int startRow = (pageNum - 1) * pageSize + 1;

// board테이블 전체글개수 가져오기 메소드 호출
int count = boardDaono.getBoardCount(search);
 
// 글목록 가져오기 메소드 호출
List<BoardVO> boardList = boardDaono.getBoards(startRow, pageSize, search);

// 날짜 포맷 준비 SimpleDateFormat
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
//세션값 가져오기 "id"
String id = (String) session.getAttribute("id");
%>

<article id="A">
    
<table id="notice">
  <tr>
    <th scope="col" class="tno">글번호</th>
    <th scope="col" class="ttitle">제목</th>
    <th scope="col" class="twrite">글쓴이</th>
    <th scope="col" class="tdate">작성일</th>
    <th scope="col" class="tread">조회수</th>
  </tr>
  <%
  if (count > 0) {
	  for (BoardVO boardVO : boardList) {
		  %>
		  <tr onclick="location.href='../noticeNomember/nocontent.jsp?num=<%=boardVO.getNum() %>&pageNum=<%=pageNum %>';">
		  	<td><%=boardVO.getNum() %></td>
		  	<td class="left">
		  		<%
		  		if (boardVO.getReLev() > 0) { // 답글
		  			int level = boardVO.getReLev() * 10;
		  			%>
		  			<img src="../imgs/re/level.gif" width="<%=level %>" height="13">
		  			<img src="../imgs/re/icon_re.gif" width="13" height="13">
		  			<%
		  		}
		  		%>
		  		<%=boardVO.getSubject() %>
		  	</td>
		  	<td><%=boardVO.getUsername() %></td>
		  	<td><%=sdf.format(boardVO.getRegDate()) %></td>
		  	<td><%=boardVO.getReadcount() %></td>
		  </tr>
		  <%
	  }
  } else { // count == 0
	  %>
	  <tr>
	  	<td colspan="5">게시판 글이 없습니다.</td>
	  </tr>
	  <%
  }
  %>   
  
</table>
<button  class="BB" type="button" onclick="location.href='../notice/notice.jsp'">공략게시판</button>
<button  class="BB" type="button" onclick="location.href='../noticeNomember/noticeNomember.jsp'">자유 게시판</button>
<button class="BB" type="button" onclick="location.href='../notice/imgNotice.jsp'"> 게시판</button>

</article>