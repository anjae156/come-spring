package com.exam.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.exam.domain.MemberVO;
import com.exam.mapper.MemberMapper;
import com.mysql.cj.xdevapi.Statement;

public class MemberDao {
	private static final MemberDao instance = new MemberDao();
	
	public static MemberDao getInstance() {
		return instance;
	}
	
	private  MemberDao() {
	}
	
	
	// 아이디 중복여부 확인dao
	public boolean isIdDuplicated(String id) {
		// 중복이면 true, 중복아니면 false
		boolean isIdDuplicated = false;
		
		SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession();
		
		MemberMapper mapper = sqlSession .getMapper(MemberMapper.class);
		int count = mapper.countMemberById(id);
		if (count > 0) {
			isIdDuplicated = true;
		}
		//JDBC 자원 닫기
		sqlSession.close();
		
		return isIdDuplicated;
	}// isIdDuplicated  method  아이디 중복확인 메소드
	
	
	//회원추가 메소드
	public int insertMember(MemberVO vo) {
		
		SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession();
		MemberMapper mapper = sqlSession .getMapper(MemberMapper.class);
		//회원가입
		int count = mapper.insertMember(vo);
		System.out.println("count :"+count);
		
		if (count >0) {
			sqlSession.commit();
		}else {
			sqlSession.rollback();
		}
		//JDBC 자원닫기
		sqlSession.close();
		
		
		return count ;
	}//insertMember method 멤버추가
	
	//회원정보 불러오기
	public MemberVO getMember(String id) {
		
		SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession();
		MemberMapper mapper = sqlSession .getMapper(MemberMapper.class);
		
		MemberVO memberVO = mapper.getMemberById(id);
		//자원닫기
		sqlSession.close();
		return memberVO;
	}// getMember method  회원정보보기 메소드
	
	
	// 유저체크 메소드 로그인
	public int userCheck(String id, String passwd) {
		int check = -1;// -1 아이디 없음 ,0 비번틀림 ,1 성공
		
		SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession();
		MemberMapper mapper = sqlSession .getMapper(MemberMapper.class);
		
		MemberVO memberVO = mapper.getMemberById(id);
		
		if (memberVO != null) {
			if (passwd.equals(memberVO.getPasswd())) {
				check = 1;
			}else {
				check = 0;
			}
		}else {
			check = -1;
		}
		//자원닫기
		sqlSession.close();
		
		return check;
	}// user Check method  로그인 메소드
	
	public List<MemberVO> getMembers() {
		

		SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession();
		MemberMapper mapper = sqlSession .getMapper(MemberMapper.class);
		
		List<MemberVO> list = mapper.getMembers();
		//자원닫기
		sqlSession.close();
		return list;
	}// getMembers method 리스트 회원정보 
	
	
	
	// 회원정보 수정하기 메소드
	// 매개변수 memberVO에 passwd필드는 수정의대상이 아니라
	// 본인 확인 용도로 사용
	public void updateMember(MemberVO memberVO) {
		

		SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession();
		MemberMapper mapper = sqlSession .getMapper(MemberMapper.class);
		mapper.updateMember(memberVO);
		//자원닫기
		sqlSession.close();
	}// updateMember method 회원정보 수정
	
	public void deleteMember(String id) {
		

		SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession();
		MemberMapper mapper = sqlSession .getMapper(MemberMapper.class);
		
		mapper.deleteMember(id);
		//자원닫기
		sqlSession.close();
		}//deleteMember
	
}