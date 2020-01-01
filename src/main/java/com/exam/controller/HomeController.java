package com.exam.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.exam.domain.BoardVO;
import com.exam.service.BoardnoService;

import lombok.extern.log4j.Log4j;


@Controller
@Log4j
public class HomeController {
	@Autowired
	private BoardnoService boardnoService;
	
	
	@GetMapping("/")
	public String index(@RequestParam(defaultValue = "1")int pageNum,
			
			@RequestParam(defaultValue = "",required = false) String search,
			
			Model model) {
		
		int pageSize = 13;
		
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
		
		return "main/main";
	}
	
	
}
