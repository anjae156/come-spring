package com.exam.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.eclipse.jdt.internal.compiler.env.IModule.IService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.exam.domain.AttachVO;
import com.exam.domain.BoardVO;
import com.exam.mapper.BoardnoMapper;
import com.exam.service.AttachService;
import com.exam.service.BoardService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {
	@Autowired
	private BoardService boardService;
	@Autowired
	private AttachService attachService;
	private boolean isImageType(File file)throws IOException {
		boolean isImageType = false;
		String contentType = Files.probeContentType(file.toPath());
		log.info("contentType:" +contentType);
		
		if (contentType != null) {
			isImageType = contentType.startsWith("image");
		}else {
			isImageType =false;
		}
		return isImageType;
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str;
	}
	
	
	@GetMapping("/list")
	public String list(@RequestParam(defaultValue = "1")int pageNum,
			@RequestParam(defaultValue = "")String search,
			Model model
			,HttpSession session
			,HttpServletResponse response)
			throws Exception {
		log.info(pageNum);
		
		String id= (String) session.getAttribute("id");
		if (id == null) {
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 하셔야합니다~.');location.href=('/member/login');</script>");
            out.flush();
            
		}
		
		
		//======================================
		//한페이지에 해당하는 글목록 구하기 작업
		//=======================================
		
		//한페이ㅣ지 에 보여줄 글개수
		int pageSize =10;
		
		// 시작행번호 구하기
		//int startRow = (pageNum - 1) * pageSize +1;// 오라클 기준
		int startRow = (pageNum-1) * pageSize;// mysql기준
		
		// 글목록 가져오기 메소드 호출
		List<BoardVO> boardList = boardService.getBoards(startRow, pageSize, search);
		
		// ===============================================\
		//페이즈블록관련정보 구하기 작업
		//=================================================\
		
		//board테이블전체글개수 가져오기 메소드 호출
		int count = boardService.getBoardCount(search);
		
		// 총페이지 개수 구하기
		// 전체 글개수 / 한페이지당 글개수 (+1:나머지 있을때)
		int pageCount = count / pageSize +(count % pageSize == 0 ? 0 : 0);
		
		//페이지블록수 설정
		int pageBlock = 5;
		
		
		int startPage = ((pageNum - 1)/pageBlock )*pageBlock+1;
		
		// 끝페이지번호 endPage 구하기
		int endpage = startPage +pageBlock - 1;
		if (endpage > pageCount) {
			endpage = pageCount;
		}
		
		//페이지 블록 관련정보Map 또는 Vo객체로준비
		Map<String, Integer> pageInfoMap = new HashMap<String, Integer>();
		pageInfoMap.put("count", count);
		pageInfoMap.put("pageCount", pageCount);
		pageInfoMap.put("pageBlock", pageBlock);
		pageInfoMap.put("startPage", startPage);
		pageInfoMap.put("endpage", endpage);
		
		// 뷰에 사영할 데이터를 request객체에wjwkd
		model.addAttribute("boardList",boardList);
		model.addAttribute("pageInfoMap",pageInfoMap);
		model.addAttribute("search",search);
		model.addAttribute("pageNum",pageNum);
		
		return "notice/notice";
	}// 회원게시판 리스트
	
	@GetMapping("/write")
	public String write(HttpSession session, HttpServletResponse response)throws Exception {
		String id= (String) session.getAttribute("id");
		if (id == null) {
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 정보를 확인해주세요.');location.href=('/member/login');</script>");
            out.flush();
            
		}
		return "notice/fwrite";
	}
	
	@PostMapping("/write")
	public String write(MultipartFile[] files,
			BoardVO boardVO,
			HttpServletRequest request)throws Exception{
		if (files != null) {
			log.info("files.length:" +files.length);
		}
		boardVO.setIp(request.getRemoteAddr());
		//게시글번호 생성하는 메소드 호출
		int num = boardService.nextBoardNum();
		
		// 생성된번호흫 자바빈 글번호 필드에 설정
		boardVO.setNum(num);
		boardVO.setReadcount(0);
		// 주글일경우
		boardVO.setReRef(num);
		boardVO.setReLev(0);
		boardVO.setReSeq(0);
		//=============================================boardVO설정완료
		
		
		//==============================================Upload시작
		ServletContext application = request.getServletContext();
		String realpath = application.getRealPath("resources/upload");
		log.info("realPath :" + realpath);
		
		// 폴더 동적생성하기
		File uplaodPath = new File(realpath,getFolder());
		log.info("uploadPath:"+uplaodPath);
		if (!uplaodPath.exists()) {//존재하면? 이란뜻
			uplaodPath.mkdirs();//업로드할폴더생성
		}
		
		List<AttachVO> attachList = new ArrayList<AttachVO>();
		
		for (MultipartFile multipartFile : files) {
			log.info("파일명:"+multipartFile.getOriginalFilename());
			log.info("파일크기:"+multipartFile.getSize());
			
			if (multipartFile.isEmpty()) {
				continue;//건너뛰기
			}
			
			String uploadFileName = multipartFile.getOriginalFilename();
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() +"_"+uploadFileName;
			log.info("최종업로드 파일명:"+uploadFileName);
			
			File saveFile = new File(uplaodPath,uploadFileName);
			multipartFile.transferTo(saveFile);//파일업로드 수행완료
			
			//======================================================
			
			//attach 테이블에 insert할 AttachVO를 리스트로 준비하기
			AttachVO attachVO = new AttachVO();
			attachVO.setBno(boardVO.getNum());
			attachVO.setUuid(uuid.toString());
			attachVO.setUploadpath(getFolder());
			attachVO.setFilename(multipartFile.getOriginalFilename());
			
			if(isImageType(saveFile)) {
				//섬네일 이미지 생성하기
				File thumbnailFile = new File(uplaodPath,"s_"+uploadFileName);
				try(FileOutputStream fos = new FileOutputStream(thumbnailFile)){
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),fos,100,100);
				}
				attachVO.setFiletype("I");
			}else {
				attachVO.setFiletype("O");
			}
			
			attachList.add(attachVO);
		}//for
		
		boardService.insertboardAndAttaches(boardVO, attachList);
		
		return "redirect:/board/list";
	}//post
	
	
	@GetMapping("/content")
	public String content(int num, @ModelAttribute("pageNum")String PageNum,
			Model model,
			HttpSession session,
			HttpServletResponse response)throws Exception {
		
		
		String id= (String) session.getAttribute("id");
		if (id == null) {
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 정보를 확인해주세요.');location.href=('/member/login');</script>");
            out.flush();
            
		}
		//조회ㅜㅅ 1증가시키는 메소드 활성
		boardService.updateReadcount(num);
		
		//글번호에 해당하는 레코드 한개 가져오기
		BoardVO boardVO = boardService.getBoard(num);
		List<AttachVO> attchList = attachService.getAttachs(num);
		
		//request 영역객체에 저장
		model.addAttribute("board",boardVO);
		model.addAttribute("attachList",attchList);
		
		return "notice/content";
	}
	
	
	
	
	
	
}
