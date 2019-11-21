package com.exam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.exam.domain.BoardVO;

public interface BoardnoMapper {
	
	// insert할 레코드의 번호 생성 메소드
	public int nextBoardNum();
	//게시글 한개 등록하는 메소드	
	public void insertBoard(BoardVO boardVO);
	//페이징으로 글목록 가져오기
	// 매개변수가 2개 이상일때는 @param("설정값이름") 이름설정하기 
	public List<BoardVO> getBoards(@Param("startRow")int startRow, @Param("pageSize")int pageSize, @Param("search")String search);
	// 게시물 갯수
	public int getBoardCount(String search);
	//
	public void updateReadcount(int num);
	//
	public BoardVO getBoard(int num);
	//
	public boolean isPasswdEqual(@Param("num")int num, @Param("passwd")String passwd);
	//게시글 수정
	public void updateBoard(BoardVO boardVO);
	//게시글삭제
	public void deleteBoard(int num);
	//다중삭제
	public void deleteBoard(String[] num);
	//답글 그룹시퀀스
	public int updateReplyGroupSequence(@Param("reRef") int reRef, @Param("reSeq") int reSeq);
	//다중글삭
	public void deleteBoards(String[] boardnum);
	
}
