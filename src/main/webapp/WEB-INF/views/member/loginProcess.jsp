<%@page import="com.exam.repository.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--파라미터값 한글처리 --%>
<% request.setCharacterEncoding("UTF-8");
//파라미터값  가져오기 
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
//체크박스 또는 라이도 타입은 선택안하면null을리턴
String rememberme = request.getParameter("rememberme");
//DAO객체 준비
MemberDao memberDao = MemberDao.getInstance();
//사용자 확인 메소드 호출
int check = memberDao.userCheck(id, passwd);

//check == 1  로그인 인증(세션값생성 "id"). index.jsp로 이동
//check == 0  "패스워드틀림" 뒤로이동
//check == -1 "아이디없음" 뒤로이동
if(check == 1){
	//로그인 인증
	session.setAttribute("id", id );
	
	//로그인 상태유지 여부확인 후
	// 쿠키객체생성해서 응답시 보내기
	if(rememberme !=null && rememberme.equals("true")){
		Cookie cookie = new Cookie("id",id);
		cookie.setMaxAge(60*60);//초단위설정
		cookie.setPath("/"); // 쿠키최상위경로
		response.addCookie(cookie);// 응답객체 추가
	}
	// index.jsp로 이동
	response.sendRedirect("../index.jsp");
	
}else if(check == 0){
	%>
	<script>
	alert('패스워드가 다릅니다.');
	history.back();
	</script>
	<%
}else{ //check == -1 
	%>
	<script>
	alert('존재하지 않는 아이디입니다');
	history.back();
	</script>
	<%
}


%>
