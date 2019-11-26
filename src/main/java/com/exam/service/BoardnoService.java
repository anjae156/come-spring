package com.exam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.exam.domain.BoardVO;
import com.exam.mapper.BoardnoMapper;

import lombok.extern.log4j.Log4j;

@Service
@Transactional
@Log4j
public class BoardnoService {

	
	@Autowired
	private BoardnoMapper boardnoMapper;
	
	// insert할 레코드의 번호 생성 메소드
		public int nextBoardNum() {
			int bnum = boardnoMapper.nextBoardNum();
			return bnum;
		} // nextBoardNum method
		
		//게시글 한개 등록하는메소드
		public void insertboard(BoardVO boardVO) {
			boardnoMapper.insertBoard(boardVO);
		}//insert 메소드
		
		
		public int getBoardCount(String search) {
			return boardnoMapper.getBoardCount(search);
		} // getBoardCount method
		
		public List<BoardVO> getBoards(int startRow, int pageSize, String search) {
			List<BoardVO> list = boardnoMapper.getBoards(startRow, pageSize, search);
			return list;
		} // getBoards method
		
		// 특정 레코드의 조회수를 1 증가시키는 메소드
		public void updateReadcount(int num) {
			boardnoMapper.updateReadcount(num);
		} // updateReadcount method
		// 글 한개를 가져오는 메소드
		public BoardVO getBoard(int num) {
			BoardVO boardVO = boardnoMapper.getBoard(num);
			return boardVO;
		} // getBoard method
		
		public boolean isPasswdEqual(int num, String passwd) {
			log.info("num:" +num+",passwd, :"+passwd);
			
			boolean result = false;
			int count = boardnoMapper.countByNumAndPasswd(num, passwd);
			if (count == 1) {
				result = true;// 게시글패스워드 같음
			}else {//count == 0
				result = false;//게시글패스워드 다름
			}
			return result;
		}//isPasswdEqual method
		
		//게시글 수정하는메소드 호출
		public void updateBoard(BoardVO boardVO) {
			boardnoMapper.updateBoard(boardVO);
		}
}
