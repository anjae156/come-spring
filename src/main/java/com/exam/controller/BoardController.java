package com.exam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.exam.domain.BoardVO;
import com.exam.service.AttachService;
import com.exam.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {
	@Autowired
	private BoardService boardService;
	@Autowired
	private AttachService attachService;
	
	@GetMapping("/write")
	public String write() {
		log.info("글쓰기");
		return "notice/fwrite";
	}
	
	@PostMapping("/write")
	public String write(BoardVO boardVO) {
		
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/list")
	public String list(@RequestParam(defaultValue = "1")int pageNum,
			@RequestParam(defaultValue = "")String search,
			Model model) {
		log.info(pageNum);
		
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
		int endpage = startPage +pageBlock;
		if (end>) {
			
		}
		
		
	}
	
	
	
}
