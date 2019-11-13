<%@page import="com.exam.domain.MemberVO"%>
<%@page import="com.exam.repository.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    	String id = (String)session.getAttribute("id");
    MemberDao memberDao = MemberDao.getInstance();
    MemberVO member = memberDao.getMember(id); 
    // 세션값없으면 로그인페이지이동
    if( id == null){
    	response.sendRedirect("login.jsp");
    	return;
    }
    %>

<%
	//파라미터값 한글처리
request.setCharacterEncoding("utf-8");
%>
<%--액션태그로 유즈빈 자바빈 객체생성 --%>
<jsp:useBean id="memberVO" class="com.exam.domain.MemberVO"/>

<%-- 액션태그 셋 프로퍼티폼을 자바빈 필드에저장 --%>

<jsp:setProperty property="*" name="memberVO"/>


<%
//사용자 패스워드 본인확인. 1리턴시 성공

int check = memberDao.userCheck(memberVO.getId(), memberVO.getPasswd());
// 패스워드 일치1 불일치 0
if(check == 1){
	memberDao.updateMember(memberVO);
	//횐님정보수정
	//DB에서 수정된회원정보레코드를 가져오기
	MemberVO updateMemberVO = memberDao.getMember(memberVO.getId());
	//세션값 회원정보 수정
	//session.setAttribute("id", memberVO.getId()); 
	
	
	%>
	<script>
		alert('회원정보수정완료!');
		location.href = '../member/info.jsp';
	</script>
<%
}else{
	%>
	<script>
		alert('패스워드가 다릅니다!');
		location.href = '../member/info.jsp';
	</script>
	<%
}
%>
