package com.exam.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.exam.domain.BoardVO;
import com.exam.mapper.BoardMapper;

public class BoardDao {
	
	private static BoardDao instance = new BoardDao();

	public static BoardDao getInstance() {
		return instance;
	}

	private BoardDao() {
	}
	
	// insert할 레코드의 번호 생성 메소드
	public int nextBoardNum() {
		
		try(SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()){
			//인터페이스를 구현한 Mapper ㅠㅡ록시 객체를 만들어서 리턴함
			BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
			int bnum  = mapper.nextBoardNum();
			return bnum;
		}
		// try블록이 끝나면 SQL세션 변수의close() 자동호출함
	} // nextBoardNum method
	
	
	// �Խñ� �Ѱ� ����ϴ� �޼ҵ�
	public void insertBoard(BoardVO boardVO) {
		
		try(SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()){
			//인터페이스를 구현한 Mapper ㅠㅡ록시 객체를 만들어서 리턴함
			BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
			mapper.insertBoard(boardVO);
			sqlSession.commit();
		}
	}// insertBoard method
	
	
	
	public List<BoardVO> getBoards(int startRow, int pageSize, String search) {
		
		
		try(SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()){
			//인터페이스를 구현한 Mapper ㅠㅡ록시 객체를 만들어서 리턴함
			BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
			return mapper.getBoards(startRow, pageSize, search);
		}
	} // getBoards method
	
	

	
	
	public int getBoardCount(String search) {
		
		
		
		try(SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()){
			//인터페이스를 구현한 Mapper ㅠㅡ록시 객체를 만들어서 리턴함
			BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
			return mapper.getBoardCount(search);
		}
	} // getBoardCount method
	
	
	
	public void updateReadcount(int num) {
		
		
		try(SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()){
			//인터페이스를 구현한 Mapper ㅠㅡ록시 객체를 만들어서 리턴함
			BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
			mapper.updateReadcount(num);
			sqlSession.commit();
		}
	} // updateReadcount method
	
	
	// �� �Ѱ��� �������� �޼ҵ�
	public BoardVO getBoard(int num) {
		
		try(SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()){
			//인터페이스를 구현한 Mapper ㅠㅡ록시 객체를 만들어서 리턴함
			BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
			return sqlSession.getMapper(BoardMapper.class).getBoard(num);
		}
	} // getBoard method
	
	
	
	
	// 게시글 수정하기 메소드
		public void updateBoard(BoardVO boardVO) {
			
			try(SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()){
				//인터페이스를 구현한 Mapper ㅠㅡ록시 객체를 만들어서 리턴함
				BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
				sqlSession.getMapper(BoardMapper.class).updateBoard(boardVO);
				sqlSession.commit();
			}
		} // updateBoard method
	
	
	// 게시글삭제
	public void deleteBoard(int num) {
		
		
		try(SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()){
			//인터페이스를 구현한 Mapper ㅠㅡ록시 객체를 만들어서 리턴함
			BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
			sqlSession.getMapper(BoardMapper.class).deleteBoard(num);
			sqlSession.commit();
		}
	} // deleteBoard method
	

	public boolean reInsertBoard(BoardVO boardVO) {
		boolean isInserted = false;// 답글쓰기 성공여부
		
		
		try(SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession()){
			//인터페이스를 구현한 Mapper ㅠㅡ록시 객체를 만들어서 리턴함
			BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
			// 같은 글그룹에서의 답글순서(re_seq) 재배치 update수행
			// 조건 re_seq 큰값은 re_seq+1
			mapper.updateReplyGroupSequence(boardVO.getReRef(), boardVO.getReSeq(),boardVO.getReLev());
			
			// 답글 insert re_ref 그대로 re_lev+1 re_seq+1
			//re_lev 는 답글을다는 대상글 의 들여쓰기값 +1 
			boardVO.setReLev(boardVO.getReRef()+1);
			//re_seq 는 답글을다는 대상글의 글그룹내 순번값+1
			boardVO.setReRef(boardVO.getReSeq()+1);
			System.out.println("답글: "+boardVO);
			// 답글 insert수행
			mapper.insertBoard(boardVO);
			
			// 트랜잭션작업 모두 성공적으로 수앻되면 commit
			sqlSession.commit();
		}
		// insert, update, delete문 수행후에는
		// sqlSession.commit(); 메소드를 호출해야 DB에 반영됨.
		
		// sqlSession.commit()이 호출되지 않은 상태에서
		// sqlSession.close() 이 호출되면 rollback 처리되어
		// DB에 적용되지 않음.
		
		return isInserted;
	} // reInsertBoard method
	
	
}
