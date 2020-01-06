package com.exam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.exam.domain.BoardVO;

public interface BoardMapper {
	
	
	//insert할레코드 생성메소드
	public int nextBoardNum() ;
	//게시글 한개 등록하는 메소드
	public void insertBoard(BoardVO boardVO);
	
	//페이징으로 글목록 가져오기
	public List<BoardVO> getBoards(@Param("startRow")int startRow,@Param("pageSize")int pageSize, @Param("search")String search );
	//게시물갯수 가져오기
	public int getBoardCount(String search) ;
	
	public void updateReadcount(int num) ;
	
	public BoardVO getBoard(int num); 
	
	public void updateBoard(BoardVO boardVO);
	
	public void deleteBoard(int num);
	
	public int updateReplyGroupSequence(@Param("reRef")int reRef,@Param("reSeq")int reSeq, @Param("reLev")int reLev);
	public void updateReplyCnt (@Param("bno")int bno, @Param("amount")int amount);
}
