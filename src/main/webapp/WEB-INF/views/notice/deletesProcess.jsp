<%@page import="java.io.File"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.exam.domain.AttachVO"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.repository.AttachDao"%>
<%@page import="com.exam.repository.BoardDao"%>
<%@page import="com.exam.repository.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String[] num = request.getParameterValues("delnum");
	if(num== null){
		%>
		<script>
			alert('선택해주세요.');
			history.back();
		</script>
		<%
		return;
	}
	
	BoardDao boardDao =BoardDao.getInstance();
	
	AttachDao attachDao = AttachDao.getInstance();
	
	List<AttachVO> attachList = attachDao.getAttach(num);   
	
	
		for(AttachVO attachVO : attachList){
			String realpath = application.getRealPath("/upload");
			
			// 파일객체준비
			File file = new File(realpath,attachVO.getFilename());
			
			if(file.exists()){
				file.delete();
			}
		}
	
	attachDao.deleteAttach(num); 
	
	boardDao.deleteBoard(num); 
%>

<script>
	alert('삭제완료');
	location.href='../notice/deletes.jsp';
</script>