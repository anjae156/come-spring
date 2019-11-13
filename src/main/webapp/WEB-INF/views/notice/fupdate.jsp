<%@page import="com.exam.domain.AttachVO"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.repository.AttachDao"%>
<%@page import="javax.swing.text.StyledEditorKit.BoldAction"%>
<%@page import="com.exam.domain.BoardVO"%>
<%@page import="com.exam.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%

String id = (String)session.getAttribute("id"); 
if (id == null) {
	%>
	<script>
		alert('로그인부터 합시다.');
	</script>
	<%
	response.sendRedirect("../member/login.jsp");
	return;
}
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

//DAO객체준비
BoardDao boardDao = BoardDao.getInstance();
// 수정할 글 가져오기
BoardVO boardVO = boardDao.getBoard(num);
%>




<head>
<meta charset="UTF-8">
<title>읍데이트</title>
<link href="../css/subpage.css" rel="stylesheet" type="text/css"  media="all">
<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
</head>
</head>
<body>
<%--헤더링크 --%>
   <jsp:include page="../include/header.jsp"></jsp:include>
<article id="C">
	<h1>글수정따쒸</h1>
	<form id="frm" action="fupdateProcess.jsp" method="post" class="basic-form" onsubmit="return check();" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="<%=pageNum %>" />
		<input type="hidden" name="num" value="<%=num %>" />
		<table id="con">

			<tr>
				<th><label>아이디</label></th>
				<td width="300">
					<input type="text" name="id" value="<%=id %>" readonly/>
				</td>
			</tr>

		<tr>
			<th><label>제목</label></th>
			<td >
				<input type="text" name="subject" value="<%=boardVO.getSubject() %>">
			</td>
		</tr>
		<%AttachDao attachDao = AttachDao.getInstance();
		
		//글번호에 해당하는 첨부파일정보 가져오기
		List<AttachVO> attachList = attachDao.getAttaches(num);
		%>
		<tr>
			<th><label>파일</label></th>
			<td >
				<%
				if(attachList != null && attachList.size()>0){
					%><ul><%
						for(AttachVO attachVO : attachList){
							%>
							<li>
								<div class="attach-item">
									<%=attachVO.getFilename() %>
									<span class="del" style="color: red; font-weight: bold;">X</span>
								</div>
								<input type="hidden" name="oldFile" value="<%=attachVO.getUuid() %>_<%=attachVO.getFilename() %>" />
							</li>
							<%
						}//for
					%></ul><%
				}//if
				%>
				<button type="button" id="btn">새로 업로드</button>
				<div id="newFilesContainer"></div>
			</td>
		</tr>
		
		<tr>
			<th><label>내용</label></th>
			<td>
				<textarea name="content" rows="15" cols="40"><%=boardVO.getContent() %></textarea>
			</td>
		</tr>
		</table>
		<div id="table_search">
			<input type="submit" value="글수정" class="BB" />
			<input type="reset" value="다시작성" class="BB" />
			<input type="button" value="목록보기" class="BB" onclick="location.href='notice.jsp?pageNum=<%=pageNum %>';"/>
		</div>
	</form>
</article>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	function check() {
		var objPasswd = frm.passwd;
		if(objPasswd != null){
			if(objPasswd.value.length < 1){
				alert('게시글 패스워드는 필수입력사항입니다.');
				objPasswd.focus();
				return false;
			}
		}
		//글수정 의도 확인하기
		var result = confirm('<%=num %>번글을 정말로 수정하시겠습니까?');
		if(result == false){
			return false;
		}
	}//check
	
	//id가 btn인 버튼에 클릭이벤트 연결
	const btn = document.getElementById('btn');
	let num =1;
	btn.onclick = function(){
		let str = '<input type="file" name="newFile' + num + '"><br>';
		let container = document.getElementById('newFilesContainer');
		container.innerHTML += str;// 뒤에 추가
		num++;
	};
	//class명이 del인 span태그에 클릭이벤트 연결하기
	//querySelectorAll로 리턴되는 객체는 NodeList 타입임.
	var delList = document.querySelectorAll('span.del');
	for (let i=0; i<delList.length; i++) {
		var spanElem = delList.item(i);
		// span요소에 이벤트 연결하기
		spanElem.onclick = function (event) {
			// 이벤트객체의 target은 이벤트가 발생된 객체를 의미함.
			// closest()는 가장 가까운 상위요소 한개 가져오기
			var liElem = event.target.closest('li');
			// childeNodes는 현재 요소의 자식요소들을 NodeList 타입으로 가져옴.
			var ndList = liElem.childNodes;
			
			var divElem = ndList.item(1);
			var inputElem = ndList.item(3);
			
			inputElem.setAttribute('name', 'delFiles'); // name 속성값 바꾸기
			divElem.remove(); // 삭제
		};
		
	} // for
		
</script>
<%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
</body>
</html>