<%@page import="com.exam.repository.BoardDaono"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>회원 게시글관리</title>
<link href="../css/subpage.css" rel="stylesheet" type="text/css"  media="all">
	<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
    <title>자유게시판 </title>
</head>
<%
String id = (String)session.getAttribute("id"); 
//세션값없으면 로그인페이지이동

if (!id.equals("admin")) {//어드민
	response.sendRedirect("../main/main.jsp");
}

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
    
<h1>자유게시판 [글개수 : <%=count %>]</h1>
<form action="nodeletesProcess.jsp" method="post" onsubmit="return Check();" name="frm">
<table id="notice">
  <tr>
    <th scope="col" class="tno">글번호</th>
    <th scope="col" class="ttitle">제목</th>
    <th scope="col" class="twrite">작성자</th>
    <th scope="col" class="tdate">작성일자</th>
    <th scope="col" class="tread">조회수</th>
    <th scope="col" class="tread">선택</th>
  </tr>
  <%
  if (count > 0) {
	  for (BoardVO boardVO : boardList) {
		  %>
		  <tr >
		  	<td><%=boardVO.getNum() %></td>
		  	<td  onclick="location.href='nocontent.jsp?num=<%=boardVO.getNum()%>&pageNum=<%=pageNum%>';">
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
		  	<td><input type="checkbox" name="delnum" value="<%=boardVO.getNum()%>" id="delnum" /></td>
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
	<button class="BB" type="submit">일괄삭제</button>
</div>
</form>
<form action="notice.jsp" method="get">
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
	
	// 시작페이지번호 startPage 구하기
	// pageNum값이 1~5 사이면 -> 시작페이지는 항상 1이 나와야 함
	
	// ((1 - 1) / 5) * 5 + 1 -> 1
	// ((2 - 1) / 5) * 5 + 1 -> 1
	// ((3 - 1) / 5) * 5 + 1 -> 1
	// ((4 - 1) / 5) * 5 + 1 -> 1
	// ((5 - 1) / 5) * 5 + 1 -> 1
	
	// ((6 - 1) / 5) * 5 + 1 -> 6
	// ((7 - 1) / 5) * 5 + 1 -> 6
	// ((8 - 1) / 5) * 5 + 1 -> 6
	// ((9 - 1) / 5) * 5 + 1 -> 6
	// ((10- 1) / 5) * 5 + 1 -> 6
	int startPage = ((pageNum - 1) / pageBlock) * pageBlock + 1;
	
	// 끝페이지번호 endPage 구하기
	int endPage = startPage + pageBlock - 1;
	if (endPage > pageCount) {
		endPage = pageCount;
	}
	
	// [이전] 출력
	if (startPage > pageBlock) {
		%>
		<a href="notice.jsp?pageNum=<%=startPage-pageBlock %>&search=<%=search %>">[이전]</a>
		<%
	}
	
	// 페이지블록 페이지5개 출력
	for (int i=startPage; i<=endPage; i++) {
		%>
		<a href="notice.jsp?pageNum=<%=i %>&search=<%=search %>">
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
		<a href="notice.jsp?pageNum=<%=startPage+pageBlock %>&search=<%=search %>">[다음]</a>
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
<script src="../scripts/jquery-3.4.1.js"></script>
<script>
	function Check() {
		//글삭제 의도 확인하기
		var delNum = $('#delNum');
	
		if(delNum == "null"){
			alert('1개이상 선택하세요');
			return false;
		}
		var result = confirm('정말로 삭제하시겠습니까?');
		if(result == false){
			return false;
		}
		
		
	}
</script>
</html>