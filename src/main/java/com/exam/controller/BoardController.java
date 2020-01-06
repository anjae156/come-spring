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


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.exam.domain.AttachVO;
import com.exam.domain.BoardVO;

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
		
		String id= (String) session.getAttribute("id");
		if (id == null) {
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 정보를 확인해 주세요.');location.href=('/member/login');</script>");
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

		// IP주소 값 저장
		boardVO.setIp(request.getRemoteAddr());

		// 게시글 번호 생성하는 메소드 호출
		int num = boardService.nextBoardNum();
		// 생성된 번호를 자바빈 글번호 필드에 설정
		boardVO.setNum(num);
		boardVO.setReadcount(0); // 조회수 0

		// 주글일 경우
		boardVO.setReRef(num); // [글그룹번호]는 글번호와 동일함
		boardVO.setReLev(0); // [들여쓰기 레벨] 0
		boardVO.setReSeq(0); // [글그룹 안에서의 순서] 0
		// ======================================= boardVO 설정 완료.

		// ======================================= Upload 시작
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/resources/upload");
		log.info("realPath : " + realPath);

		// 폴더 동적 생성하기 /resources/upload/2019/11/11
		File uploadPath = new File(realPath, getFolder());
		log.info("uploadPath : " + uploadPath);
		if (!uploadPath.exists()) {
			uploadPath.mkdirs(); // 업로드할 폴더 생성
		}

		List<AttachVO> attachList = new ArrayList<AttachVO>();

		for (MultipartFile multipartFile : files) {
			log.info("파일명: " + multipartFile.getOriginalFilename());
			log.info("파일크기: " + multipartFile.getSize());

			if (multipartFile.isEmpty()) {
				continue;
			}

			String uploadFileName = multipartFile.getOriginalFilename();
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			log.info("최종 업로드 파일명: " + uploadFileName);

			File saveFile = new File(uploadPath, uploadFileName);

			multipartFile.transferTo(saveFile); // 파일 업로드 수행 완료

			// ==============================================

			// attach 테이블에 insert할 AttachVO를 리스트로 준비하기
			AttachVO attachVO = new AttachVO();
			attachVO.setBno(boardVO.getNum());
			attachVO.setUuid(uuid.toString());
			attachVO.setUploadpath(getFolder());
			attachVO.setFilename(multipartFile.getOriginalFilename());

			if (isImageType(saveFile)) { // Image file type
				// 섬네일 이미지 생성하기
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);

				try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 100, 100);
				}

				attachVO.setFiletype("I");
			} else { // Other file type
				attachVO.setFiletype("O");
			}

			attachList.add(attachVO);
		} // for
		log.info("왜 왜왜 왜:"+attachList+boardVO);
		// 테이블 insert : board테이블과 attach테이블 트랜잭션으로 insert
		boardService.insertBoardAndAttaches(boardVO, attachList);
		

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
	
	@GetMapping(value = "/download", produces =MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> download(String fileName, HttpServletRequest request)throws Exception{
		// 다운로드할 경로 구하기
		ServletContext application = request.getServletContext();
		String realpath = application.getRealPath("/resources/upload");
		
		Resource resource = new FileSystemResource(realpath + "/" +fileName);
		
		if (!resource.exists()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);//404 에러
		}
		
		String resourceName = resource.getFilename();
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		
		HttpHeaders headers = new HttpHeaders();
		
		String downloadName = "";
		downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
		headers.add("Content-Disposition", "attachment; filename="+ downloadName);
		
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
		
	}
	
	
	
	
	
}
