package com.exam.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.exam.domain.BoardVO;
import com.exam.mapper.AttachMapper;
import com.exam.mapper.BoardnoMapper;

@Repository
public class BoardDaono {
	
	private static BoardDaono instance = new BoardDaono();

	public static BoardDaono getInstance() {
		return instance;
	}

	private BoardDaono() {
	}
	
	// insert할 레코드의 번호 생성 메소드
	public int nextBoardNum() {
		//Connection
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()) {
			BoardnoMapper mapper = sqlSession.getMapper(BoardnoMapper.class);
			int bnum = mapper.nextBoardNum();
			return bnum;
		}
		//try 블록이 끝나면 Sqlsession 변수의 close() 메소드 자동호출함. 개이
	} // nextBoardNum method
	
	
	// 게시글 한개 등록하는 메소드
	public void insertBoard(BoardVO boardVO) {
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()) {
			BoardnoMapper mapper = sqlSession.getMapper(BoardnoMapper.class);
			mapper.insertBoard(boardVO);
			sqlSession.commit();
		}
	} // insertBoard method
	
	public List<BoardVO> getBoards(int startRow, int pageSize, String search) {
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()) {
			BoardnoMapper mapper = sqlSession.getMapper(BoardnoMapper.class);
			return mapper.getBoards(startRow, pageSize, search);
		}
	} // getBoards method
	
	
	public int getBoardCount(String search) {
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()) {
			BoardnoMapper mapper = sqlSession.getMapper(BoardnoMapper.class);
			return mapper.getBoardCount(search);
		}
	} // getBoardCount method
	
	
	// 게시글 조회수 증가
	public void updateReadcount(int num) {
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()) {
			BoardnoMapper mapper = sqlSession.getMapper(BoardnoMapper.class);
			mapper.updateReadcount(num);
			sqlSession.commit();
		}
	} // updateReadcount method
	
	
	// 글 한개만 가져오기
	public BoardVO getBoard(int num) {
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()) {
			return sqlSession.getMapper(BoardnoMapper.class).getBoard(num);
		}
	} // getBoard method
	
	
	// 게시글패스워드 비교하기
	public boolean isPasswdEqual(int num, String passwd) {
		System.out.println("num : " + num + ", passwd : " + passwd);
		
		boolean result = false;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()) {
			int count = sqlSession.getMapper(BoardnoMapper.class).countByNumAndPasswd(num, passwd);
			if (count == 1) {
				result = true;// 게시글 패스워드 같음
			}else {
				result =false;
			}
		}
		return result;
	} // isPasswdEqual method
	
	
	// 게시글 수정하기 메소드
	public void updateBoard(BoardVO boardVO) {
	
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()) {
			sqlSession.getMapper(BoardnoMapper.class).updateBoard(boardVO);
			sqlSession.commit();
		}
	} // updateBoard method
	
	
	// 글번호에 해당하는 글한개 삭제하기 메소드
	public void deleteBoard(int num) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()) {
			sqlSession.getMapper(BoardnoMapper.class).deleteBoard(num);
		}
	} // deleteBoard method
	
	public void reInsertBoard(BoardVO boardVO) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()) {
			BoardnoMapper mapper = sqlSession.getMapper(BoardnoMapper.class);
	
			// 같은 글그룹에서의 답글순서(re_seq) 재배치 update수행
			// 조건 re_ref같은그룹 re_seq 큰값은 re_seq+1
			mapper.updateReplyGroupSequence(boardVO.getReRef(), boardVO.getReSeq());
			
			// 답글 insert re_ref그대로 re_lev+1 re_seq+1
			// re_lev 는 [답글을 다는 대상글]의 들여쓰기값 + 1
			boardVO.setReLev(boardVO.getReLev() + 1);
			// re_seq 는 [답글을 다는 대상글]의 글그룹 내 순번값 + 1
			boardVO.setReSeq(boardVO.getReSeq() + 1);
			System.out.println("답글: " + boardVO);
			// 답글 insert 수행
			mapper.insertBoard(boardVO);
			
			// 트랜잭션 작업 모두 성공적으로 수행되면 commit
			sqlSession.commit();
		}
	} // reInsertBoard method
	
	
}
