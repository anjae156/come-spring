package com.exam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.exam.domain.AttachVO;
import com.exam.domain.BoardVO;
import com.exam.mapper.AttachMapper;
import com.exam.mapper.BoardMapper;

import lombok.extern.log4j.Log4j;


@Service
@Transactional
@Log4j
public class BoardService {

	
	@Autowired
	private BoardMapper boardMapper;
	private AttachMapper attachMapper;
	
	//insert할 레코드의 번호생성 메소드
	public int nextBoardNum() {
		int bnum= boardMapper.nextBoardNum();
		return bnum;
	}
	
	
	public void insertBoard(BoardVO boardVO) {
		boardMapper.insertBoard(boardVO);
	}
	
	//게시글 한개 등록하는 메소드
	public int getBoardCount(String search) {
		return boardMapper.getBoardCount(search);
	}
	
	public List<BoardVO> getBoards(int startRow, int pageSize, String search) {
		List<BoardVO> list = boardMapper.getBoards(startRow,pageSize,search);
		return list;
	}
	
	public void insertboardAndAttaches(BoardVO boardVO,List<AttachVO> attachList) {
		// 파일게시판 주글 등록
		boardMapper.insertBoard(boardVO);
		
		if (attachList.size() > 0) {
			for (AttachVO attachVO : attachList) {
				attachMapper.insertAttach(attachVO);//첨부파일등록
			}
		}
	}
	
	public void updateReadcount(int num) {
		boardMapper.updateReadcount(num);
	}
	
	public BoardVO getBoard(int num) {
		BoardVO boardVO = boardMapper.getBoard(num);
		return boardVO;
	}
	
	
	
}
