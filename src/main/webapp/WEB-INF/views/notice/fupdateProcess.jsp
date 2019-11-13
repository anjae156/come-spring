<%@page import="java.nio.file.Files"%>
<%@page import="java.io.File"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.exam.repository.AttachDao"%>
<%@page import="com.exam.domain.AttachVO"%>
<%@page import="com.exam.domain.BoardVO"%>
<%@page import="com.exam.repository.BoardDao"%>
<%@page import="com.exam.repository.MemberDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//COS라이브러리를 이용한 파일업로드
//멀티파트 리퀘스트 생성자 호출시에 파일없로드가 완료

String realPath = application.getRealPath("/upload");

//최대 업로드 파일크기
int maxSize = 1024*1024*100;//100 MB

MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8",
			new DefaultFileRenamePolicy());

	//세션값 가져오기(로그인 여부확인)

	String id = (String) session.getAttribute("id");
	System.out.println(id);
	//수정할 글번호num,패스워드, 페이지번호 가져오기
	String pageNum = multi.getParameter("pageNum");
	int num = Integer.parseInt(multi.getParameter("num"));
	String passwd = multi.getParameter("passwd");

	//dao
	BoardDao boardDao = BoardDao.getInstance();

	//로그인 안한 사용자(글패스워드값이 있는 사용자)는
	//[패스워드 일치 여부]를 확인 후 일치하면 글수정하고,
	//일치하지 않으면 "글패스워드 다름" 뒤로가기
	if (id == null) {
		boolean ispasswdEqual = boardDao.isPasswdEqual(num, passwd);
		if (!ispasswdEqual) {
%>
		<script>
			alert('글 패스워드가 다르구나.');
			history.back();
		</script>
		<%
		return;
	}
}
//============= 게시판 글 수정 처리 시작 =================

//자바빈 BoardVO 객체 생성
BoardVO boardVO = new BoardVO();

//파라미터 찾아서 자바빈에 저장
boardVO.setNum(num);
boardVO.setSubject(multi.getParameter("subject"));
boardVO.setContent(multi.getParameter("content"));

System.out.println(multi.getParameter("subject"));
System.out.println(multi.getParameter("content"));
//게시글 수정하는 메소드 호출 updateBoard(boardVO)
boardDao.updateBoard(boardVO);
//============= 게시판 글 수정 처리 종료 =================


//============= 첨부파일 DB등록 처리 시작 =================

// AttachDao 준비
AttachDao attachDao =AttachDao.getInstance();

//Enumeration 열거형. file의 파라미터 이름들을 가짐
//자바의 Iterator와 사용방법이 동일함
Enumeration<String> enu = multi.getFileNames();
 while (enu.hasMoreElements()){
	 String str = enu.nextElement();
		// 파라미터 이름으로 실제로 업로드된 파일이름 구하기
		// 해당 파라미터 이름을 업로드에 사용 안했으면 null이 리턴됨 
		String realFileName = multi.getFilesystemName(str);
		// 파일업로드 여부확인. 업로드 했으면
		if (realFileName != null){
			AttachVO attachVO = new AttachVO();
			
			UUID uuid = UUID.randomUUID();
			attachVO.setUuid(uuid.toString());
			attachVO.setFilename(realFileName);// 실제 생성된 파일이름
			attachVO.setBno(num);// 게시글 번호
			
			
			// 이미지 파일여부 확인
			File file = new File(realPath,realFileName);
			String contentType = Files.probeContentType(file.toPath());
			boolean isImage = contentType.startsWith("image");
			if(isImage){
				attachVO.setFiletype("I");//이미지 파일
			}else{
				attachVO.setFiletype("O");// 아더 파일
			}
			
			//첨부파일정보 한개등록하는메소드 호출
			attachDao.insertAttach(attachVO);
		}//if
		
 }//while
//============= 첨부파일 DB등록 처리 종료 =================	




//============= 삭제할 파일 삭제작업 시작 =================

// 삭제할 파일정보 파라미터 가져오기
String[] delFiles = multi.getParameterValues("delFiles");
if(delFiles != null){
	for(String str : delFiles){
		String[] strArr = str.split("_");
		String uuid = strArr[0];
		String delfileName = strArr[1];
		
		// 파일 삭제하기
		File delFile = new File(realPath, delfileName);
		if(delFile.exists()){// 해당경로에 파일이 존재하면
			delFile.delete();
		System.out.println(delfileName +"파일삭제됨.");
		}
		
		// attach 테이블에 해당 uuid 레코드 한개 삭제
		attachDao.deleteAttach(uuid);
	}//for str
}//if delFiles

//============= 삭제할 파일 삭제작업 종료 =================
	 
// 이동 fnotice.jsp
response.sendRedirect("notice.jsp?pageNum=" + pageNum);
%>