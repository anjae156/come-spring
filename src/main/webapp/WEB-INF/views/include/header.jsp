<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String id = null; 
// 쿠키 찾기
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("id")) {
			id = cookie.getValue();
			// 세션에 쿠키값을 저장
			session.setAttribute("id", id);
		}
	}
}

// 세션값 가져오기 "id"
id = (String) session.getAttribute("id");
%>
    
	<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>




<nav class="fixed-top">
        <div class="wrap nav-wrap ">
            <a href="../main/main.jsp" class="logo">
                <img src="../imgs/logo-white.png" alt="">
            </a>
            <button class="mobile">
                !
            </button>
            <ul>
                <li>
                    <a href="../main/main.jsp#second  ">게임소개</a>
                </li>
                <li>
                    <a href="../main/main.jsp#third">자유게시판</a>
                </li>
                <li>
                    <a href="../main/main.jsp#fourth">공사중</a>
                </li>
                <li>
                    <a href="../main/main.jsp#">공사중2</a>
                </li>
                
    	<%
     	if (id == null) { // 세션값없음
     		%>
     		<li>
                 <a href="../member/login.jsp">로그인/회원가입 </a>
            </li>
     		<%
     	} else { // id != null   세션값있음
     		%>
     		<li>
     				<a href="../member/info.jsp"><%=id%>님</a>
                    <a href="../member/logout.jsp"> 로그아웃 </a>
            </li>
     		<%
     	}
                %>
            </ul>
        </div>
    </nav>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
