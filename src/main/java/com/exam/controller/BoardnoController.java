package com.exam.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.exam.domain.BoardVO;
import com.exam.service.BoardnoService;

import lombok.extern.log4j.Log4j;
import sun.security.krb5.internal.PAForUserEnc;

@Controller
@RequestMapping("/boardno/*")
@Log4j
public class BoardnoController {
	@Autowired
	private BoardnoService boardnoService;

	@GetMapping("/write")
	public String write() {
		log.info("글쓰기");
		return "noticeNomember/nowrite";
	}
	
	@PostMapping("/write")
	public String write(BoardVO boardVO,HttpServletRequest request) throws Exception { 
		boardVO.setIp(request.getRemoteAddr());
		request.setCharacterEncoding("utf-8");
		// 게시글번호 생성기
		int num = boardnoService.nextBoardNum();
		// 생성된번호를 자바빈 글번호 필드에 설정
		log.info("넘"+num);
		boardVO.setNum(num);
		boardVO.setReadcount(0);
		//주글일경우
		boardVO.setReRef(num);
		boardVO.setReLev(0);
		boardVO.setReSeq(0);
		
		//게시글한개등록하는메소드호출
		boardnoService.insertboard(boardVO);
		
		return "redirect:/boardno/list";
	}
	
	@GetMapping("/list")
	public String list(@RequestParam(defaultValue = "1")int pageNum,
			
			@RequestParam(defaultValue = "",required = false) String search,
			
			Model model) {
		
		log.info("pageNum: "+pageNum);
		
		int pageSize = 10;
		
		// 시작행번호 구하기
		int startRow = (pageNum-1) *pageSize;
		
		// 글목록가져오기 메소드 호출
		List<BoardVO> boardList = boardnoService.getBoards(startRow, pageSize, search);
		//페이지 블록
		int count = boardnoService.getBoardCount(search);
		
		// 총페이지 개수 구하기
		int pageCount = count / pageSize + (count % pageSize == 0? 0: 1);
		// 페이지블록
		int pageBlock = 5;
		// 시작페이지 구하기
		int startPage = ((pageNum - 1) / pageBlock) * pageBlock +1;
		
		// 끝헤이지 번호 구하기
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		log.info(endPage);
		
		// 페이지블록관련정보를 map또는 VO객체로 준비
		Map<String, Integer> pageInfoMap = new HashMap<String, Integer>();
		pageInfoMap.put("count", count);
		pageInfoMap.put("pageCount",pageCount);
		pageInfoMap.put("pageBlock",pageBlock);
		pageInfoMap.put("startPage", startPage);
		pageInfoMap.put("endPage", endPage);
		// 뷰에 사용할데이터을 request 객체에 저장
		model.addAttribute("boardList",boardList);
		model.addAttribute("pageInfoMap",pageInfoMap);
		model.addAttribute("search",search);
		model.addAttribute("pageNum",pageNum);
		
		return "noticeNomember/noticeNomember";
	}
	
	@GetMapping("/content")
	public String content(int num,@ModelAttribute("pageNum")int pageNum,Model model) {
		boardnoService.updateReadcount(num);
		
		BoardVO boardVO = boardnoService.getBoard(num);
		
		model.addAttribute("board", boardVO);
		return "noticeNomember/nocontent";
	}
	
	@GetMapping("/modify")
	public String update(int num,@ModelAttribute("pageNum") String pageNum, Model model) {
		BoardVO boardVO = boardnoService.getBoard(num);
		log.info("글수정");
		 //request객체에저장
		model.addAttribute("board",boardVO);
		return "noticeNomember/noupdate";
		 
	}
	@PostMapping("/modify")
	public ResponseEntity<String> modify(BoardVO boardVO, String pageNum){
		
		boolean isPasswdEqual = boardnoService.isPasswdEqual(boardVO.getNum(), boardVO.getPasswd());
		if (!isPasswdEqual) {
			HttpHeaders headers=new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("alert('글패스워드가 다릅니다');");
			sb.append("history.back();");
			sb.append("</script>");
			ResponseEntity<String> responseEntity = new ResponseEntity<String>(sb.toString(),headers,HttpStatus.OK);
			return responseEntity;
		}
		
		//게시글수정하기 메소드호출
		boardnoService.updateBoard(boardVO);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		StringBuilder sb = new StringBuilder();
		sb.append("<script>");
		sb.append("alert('글수정 성공!');");
		sb.append("location.href = '/boardno/content?num="+boardVO.getNum()+"&pageNum="+pageNum+"';");
		sb.append("</script>");
		
		ResponseEntity<String> responseEntity = new ResponseEntity<String>(sb.toString(),headers,HttpStatus.OK);
		
		return responseEntity;
		
	}
	
	
	
	
}
