package com.exam.controller;

import java.awt.print.Pageable;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		
		int pageSize = 10;
		
		// 시작행번호 구하기
		int startRow = (pageNum-1) * pageSize;
		log.info("start"+startRow);
		
		// 글목록가져오기 메소드 호출
		List<BoardVO> boardList = boardnoService.getBoards(startRow, pageSize, search);
		//페이지 블록
		int count = boardnoService.getBoardCount(search);
		
		// 총페이지 개수 구하기
		int pageCount = count / pageSize + (count % pageSize == 0? 0: 1);
		// 페이지블록
		int pageBlock = 5;
		// 시작페이지 구하기
		int startPage = ((pageNum-1) / pageBlock) * pageBlock +1;
		
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
	
	@GetMapping("/delete")
	public String delete(@ModelAttribute("num")int num, @ModelAttribute("pageNum")String pageNum) {
		return "/noticeNomember/delete";
	}
	@PostMapping("/delete")
	public ResponseEntity<String> delete(int num, String passwd ,String pageNum) {
		//글패스워드가 다를때는 글패스워드다름 뒤로가기
		if (!boardnoService.isPasswdEqual(num, passwd)) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("alert('글 패스워드가 다릅니다.');");
			sb.append("history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String> (sb.toString(), headers, HttpStatus.OK);
		}
		// 게시글삭제메소드호출
		boardnoService.deleteBoard(num);//글 삭제처리
		
		// 삭제처리후 글목록 / board.list로 이동
		HttpHeaders headers = new HttpHeaders();
		headers.add("Location","/boardno/list?pageNum="+pageNum);
		return new ResponseEntity<String>(headers,HttpStatus.FOUND); //  httpStatus.Found 리다이렉트
	}
	
	@GetMapping("/reple")
	public String reple(BoardVO boardVO, @ModelAttribute("pageNum")String pageNum){
		return "noticeNomember/reWrite";
	}
	@PostMapping("/reple")
	public String reple(BoardVO boardVO, HttpServletRequest request,String pageNum, RedirectAttributes rttr) {
		boardVO.setIp(request.getRemoteAddr());
		
		//게시글 번호 생성하는 매소드 호출
		int num = boardnoService.nextBoardNum();
		boardVO.setNum(num);
		boardVO.setReadcount(0);
		
		//답글쓰기 메소드 호출
		boardnoService.reInsertBoard(boardVO);
		
		rttr.addAttribute("pageNum",pageNum);
		return "redirect:/boardno/list";
	}
	
	@GetMapping("/deletes")
	public String deletes(@RequestParam(defaultValue = "1")int pageNum,
			
			@RequestParam(defaultValue = "",required = false) String search,
			
			Model model
			,HttpSession session
			,HttpServletResponse response)
	throws Exception{
		
		String id = (String) session.getAttribute("id");
		if (id == null || !id.equals("admin")) {
			response.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    out.println("<script>alert('로그인 정보를 확인해주세요.');location.href=('/#third');</script>");
		    out.flush();
		}
		
		int pageSize = 10;
		
		// 시작행번호 구하기
		int startRow = (pageNum-1) * pageSize;
		
		// 글목록가져오기 메소드 호출
		List<BoardVO> boardList = boardnoService.getBoards(startRow, pageSize, search);
		//페이지 블록
		int count = boardnoService.getBoardCount(search);
		
		// 총페이지 개수 구하기
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0: 1);
		// 페이지블록
		int pageBlock = 5;
		// 시작페이지 구하기
		int startPage = ((pageNum-1) / pageBlock) * pageBlock + 1 ;
		
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
		
		return "noticeNomember/nodeletes";
	}
	
	@PostMapping("/deletes")
	public ResponseEntity<String> deletes(int[] numArr) {
		if(numArr == null) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("alert('하나이상 선택좀 해주세영.');");
			sb.append("history.back();");
			sb.append("</script>");
			return new ResponseEntity<String>(sb.toString(),headers,HttpStatus.FOUND);
		}else if(numArr.length >= 1) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			StringBuilder sb = new StringBuilder();
			for (int num:numArr) {
				// 게시글삭제메소드호출
				boardnoService.deleteBoard(num);//글 삭제처리			
			}
			sb.append("<script>");
			sb.append("alert('삭제완료.');");
			sb.append("location.href='/boardno/deletes';");
			sb.append("</script>");
			return new ResponseEntity<String> (sb.toString(), headers, HttpStatus.OK);
		}
//		if(numArr.length > 1) {
//			HttpHeaders headers = new HttpHeaders();
//			headers.add("Content-Type", "text/html; charset=UTF-8");
//			StringBuilder sb = new StringBuilder();
//			sb.append("<script>");
//			sb.append("var result = confirm('정말로 삭제하시겠습니까.');");
//			sb.append("if(result){");
//			for (int num:numArr) {
//				// 게시글삭제메소드호출
//				boardnoService.deleteBoard(num);//글 삭제처리
//			}
//			sb.append("} else {");
//			sb.append("} history.back(); ");
//			headers.add("Location","/boardno/deletes");
//			return new ResponseEntity<String> (sb.toString(), headers, HttpStatus.OK);
//		}
		
		
		// 삭제처리후 글목록 / board.list로 이동
		HttpHeaders headers = new HttpHeaders();
		headers.add("Location","/boardno/deletes");
		return new ResponseEntity<String>(headers,HttpStatus.FOUND); //  httpStatus.Found 리다이렉트
	}
	
}
