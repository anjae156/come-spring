<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>회원 게시글관리</title>
<link href="../resources/css/subpage.css" rel="stylesheet" type="text/css"  media="all">
	<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
    <title>자유게시판 </title>
</head>
<body>
<div id="wrap2" class="full-width full-page pagenoti" style="background-color: grey;">
		<%--헤더링크 --%>
   <jsp:include page="../include/header.jsp"></jsp:include>
<article id="B" style="background-color: #aaaaaa44">
    
<h1> 글삭제 합시당 [글개수 : ${pageInfoMap.count}]</h1>
<form action="/boardno/deletes" method="post" onsubmit="return Check();">
<table id="notice">
  <tr>
    <th scope="col" class="tno">글번호</th>
    <th scope="col" class="ttitle">제목</th>
    <th scope="col" class="twrite">작성자</th>
    <th scope="col" class="tdate">작성일자</th>
    <th scope="col" class="tread">조회수</th>
    <th scope="col" class="tsel">선택</th>
  </tr>
  <c:choose>
  	<c:when test="${pageInfoMap.count gt 0}">
  		<c:forEach var="board" items="${boardList}">
  			<tr>
		  	<td>${board.num}</td>
		  	<td class="left"  onclick="location.href='/boardno/content?num=${board.num}&pageNum=${pageNum}';">
		  	<c:if test="${board.reLev gt 0 }">
		  		<c:set var="level" value="${board.reLev * 10}"/>
				<img src="/resources/imgs/re/level.gif" width="${level}" height="13">
		  		<img src="/resources/imgs/re/icon_re.gif" width="13" height="13">
		  	</c:if>
		  	${board.subject}
		  	</td>
		  	<td>${board.username}</td>
		  	<td><fmt:formatDate value="${board.regDate}" pattern="yyyy.MM.dd" /></td>
		  	<td>${board.readcount}</td>
		  	<td><input type="checkbox" name="numArr" value="${board.num}" id="numArr" /></td>
		  </tr>
  		</c:forEach>
  	</c:when>
  	<c:otherwise>
  		<tr>
	  		<td colspan="5">게시판 글이 없습니다.</td>
	  	</tr>
  	</c:otherwise>
  </c:choose>
   
</table>

<div id="table_search">
<button class="BB" type="submit" >일괄삭제</button>
	<input type="button" value="글쓰기" class="BB" onclick="location.href='/boardno/write';">
</div>
</form>

<form action="/boardno/deletes">
<div id="table_search">
	<input type="text" name="search" value="${search}" class="input_box">
	<input type="submit" value="제목검색" class="BB">
	
</div>
</form>

<div class="clear"></div>
 
<div id="page_control">

<c:if test="${pageInfoMap.count gt 0 }">
	<%--[이전]출력 --%>
	<c:if test="${pegeInfoMap.count gt 0}">
	<a href="/boardno/deletes?pageNum=${pageInfoMap.startPage - pageInfoMap.pageBlock}&search=${search}">[이전]</a>
	</c:if>

	<c:forEach var="i" begin="${pageInfoMap.startPage}" end="${pageInfoMap.endPage}" step="1">
		<a href="/boardno/deletes?pageNum=${i}&search=${search}">
		<c:choose>
			<c:when test="${i eq pageNum}">
				<span style="font-weight: bold;">[${i}]</span>
			</c:when>
			<c:otherwise>
				${i}
			</c:otherwise>
		</c:choose>
		</a>
	</c:forEach>
	
	<%--[다음]출력 --%>
	<c:if test="${pagaInfoMap.endPage lt pageInfoMap.pageCount}">
		<a href="/boardno/deletes?pageNum=${pageInfoMap.startPage+pageInfoMap.pageBlock}&search=${search}">[다음]</a>
	</c:if>
</c:if>
</div>
	
    
</article>
    
    
    
	<div class="clear"></div>
	<%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
</div>

</body>
<script src="/resources/scripts/jquery-3.4.1.js"></script>
<script>
	function Check() {
		//글삭제 의도 확인하기
		var result = confirm('정말로 삭제하시겠습니까?');
		if(result == false){
			return false;
		}
		
		
	}
</script>
</html>