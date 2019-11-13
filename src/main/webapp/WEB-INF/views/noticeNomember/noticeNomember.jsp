<%@page import="com.exam.domain.MemberVO"%>
<%@page import="com.exam.repository.BoardDaono"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>자유게시판</title>
<link href="../css/subpage.css" rel="stylesheet" type="text/css"  media="all">
	<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
    <title>자유게시판 </title>
</head>
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
%>
<body>
<div id="wrap2" class="full-width full-page pagenoti" style="background-color: grey;">
		<%--헤더링크 --%>
   <jsp:include page="../include/header.jsp"></jsp:include>
<article id="B" style="background-color: #aaaaaa44">
    
<h1>비회원게시판 [글개수 : <%=count %>]</h1>
    
<table id="notice">
  <tr>
    <th scope="col" class="tno">글번호</th>
    <th scope="col" class="ttitle">제목</th>
    <th scope="col" class="twrite">작성자</th>
    <th scope="col" class="tdate">작성일자</th>
    <th scope="col" class="tread">조회수</th>
  </tr>
  <%
  if (count > 0) {
	  for (BoardVO boardVO : boardList) {
		  %>
		  <tr onclick="location.href='nocontent.jsp?num=<%=boardVO.getNum()%>&pageNum=<%=pageNum%>';">
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

<div id="table_search">
	<input type="button" value="글쓰기" class="BB" onclick="location.href='nowrite.jsp';">
</div>

<form action="noticeNomember.jsp" method="get">
<div id="table_search">
	<input type="text" name="search" value="<%=search %>" class="input_box">
	<input type="submit" value="제목검색" class="BB">
</div>
</form>

<div class="clear"></div>
 
<div id="page_control">
<%
if (count > 0) {
	// 총 페이지 개수 구하기
	//  전체 글개수 / 한페이지당 글개수 (+ 1 : 나머지 있을때)
	int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
	
	// 페이지블록 수 설정
	int pageBlock = 5;
	
	
	int startPage = ((pageNum - 1) / pageBlock) * pageBlock + 1;
	
	// 끝페이지번호 endPage 구하기
	int endPage = startPage + pageBlock - 1;
	if (endPage > pageCount) {
		endPage = pageCount;
	}
	
	// [이전] 출력
	if (startPage > pageBlock) {
		%>
		<a href="noticeNomember.jsp?pageNum=<%=startPage-pageBlock %>&search=<%=search %>">[이전]</a>
		<%
	}
	
	// 페이지블록 페이지5개 출력
	for (int i=startPage; i<=endPage; i++) {
		%>
		<a href="noticeNomember.jsp?pageNum=<%=i %>&search=<%=search %>">
		<%
		if (i == pageNum) {
			%><span style="font-weight: bold;">[<%=i %>]</span><%
		} else {
			%><%=i %><%
		}
		%>
		</a>
		<%
	} // for
	
	// [다음] 출력
	if (endPage < pageCount) {
		%>
		<a href="noticeNomember.jsp?pageNum=<%=startPage+pageBlock %>&search=<%=search %>">[다음]</a>
		<%
	}
	
} // if
%>
</div>
	
    
</article>
    
    
    
	<div class="clear"></div>
	<%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
</div>

</body>
</html>   