package com.exam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.exam.domain.MemberVO;

public interface MemberMapper {

	@Select("SELECT COUNT(*) AS cnt "
			+ "FROM member2 "
			+ "WHERE id = #{id}")
	public int countMemberById(String id);
	
	
	public int insertMember(MemberVO vo);
	
	@Select("SELECT * FROM member2 WHERE id = #{id}")
	public MemberVO getMemberById(String id);
	
	// 전체회원정보 가져오기
	@Select("SELECT * FROM member2 ORDER BY id ASC")
	public List<MemberVO> getMembers();
	
	@Update("UPDATE member2 SET name=#{name}, age=#{age}, gender=#{gender}, email=#{email} WHERE id=#{id}")
	public void updateMember(MemberVO memberVO);
	
	@Delete("DELETE FROM member2 WHERE id = #{id}")
	public void deleteMember(String id);
	
}
