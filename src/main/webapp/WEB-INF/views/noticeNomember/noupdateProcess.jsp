<%@page import="com.exam.repository.BoardDaono"%>
<%@page import="com.exam.domain.BoardVO"%>
<%@page import="com.exam.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- post 파라미터값 한글처리 --%>
<%
	request.setCharacterEncoding("utf-8");
%>

<%-- BoardVO 자바빈 객체 생성 --%>
<jsp:useBean id="boardVO" class="com.exam.domain.BoardVO" />

<%-- 자바빈 객체에 파라미터값 찾아서 저장 --%>
<jsp:setProperty property="*" name="boardVO"/>

<%-- pageNum 파라미터 가져오기 --%>
<% String pageNum = request.getParameter("pageNum"); %>

<%
// DAO 객체 준비
BoardDaono boardDaono = BoardDaono.getInstance();



String id = (String)session.getAttribute("id");

// 로그인 안한 사용자(글패스워드값이 있는 사용자)는
// [패스워드 일치 여부]를 확인 후 일치하면 글수정하고,
// 일치하지 않으면 "글패스워드 다름" 뒤로가기
if (id == null) {
	boolean isPasswdEqual = boardDaono.isPasswdEqual(boardVO.getNum(), boardVO.getPasswd());
	if (!isPasswdEqual) { // !boardVO.getPasswd().equals(dbBoardVO.getPasswd())
		%>
		<script>
			alert('글 패스워드가 다릅니다.');
			history.back();
		</script>
		<%
		return;
	}
}

// 게시글 수정하기 메소드 호출
boardDaono.updateBoard(boardVO);

// 글목록 notice.jsp 로 이동
//response.sendRedirect("notice.jsp?pageNum=" + pageNum);
%>
<script>
	alert('글 수정 성공!');
	//location.href = 'noticeNomember.jsp.jsp?pageNum=<%=pageNum %>';
	location.href = 'nocontent.jsp?num=<%=boardVO.getNum() %>&pageNum=<%=pageNum %>';
</script>



