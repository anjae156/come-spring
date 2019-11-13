package com.exam.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.exam.domain.MemberVO;
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
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = DBManager.getConnection();
			sql = "SELECT COUNT(*) AS cnt FROM member2 WHERE id = ?";// sql문 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			rs.next();//커서 옮기기
			count = rs.getInt(1);
			if (count == 1) {
				isIdDuplicated = true;// 중복이다
			}else { // count == 0
				isIdDuplicated = false;// 중복아니다
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, pstmt, rs);//자원닫기 다쓴건 닫자
		}
		return isIdDuplicated;
	}// isIdDuplicated  method  아이디 중복확인 메소드
	
	
	//회원추가 메소드
	public int insertMember(MemberVO vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		
		try {
			con = DBManager.getConnection();
			String sql = "INSERT INTO member2 (id,passwd,name,email,address,tel,mtel,reg_date,age,gender) ";
			sql += " VALUE (?,?,?,?,?,?,?,?,?,?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getId()); //vo값 받아와서 sql저장
			pstmt.setString(2, vo.getPasswd());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getEmail());
			pstmt.setString(5, vo.getAddress());
			pstmt.setString(6, vo.getTel());
			pstmt.setString(7, vo.getMtel());
			pstmt.setTimestamp(8, vo.getRegDate());
			pstmt.setInt(9, vo.getAge());
			pstmt.setString(10, vo.getGender());
			//다 올렷으면sql문실행
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, pstmt);// 자원닫기
		}
		return rowCount ;
	}//insertMember method 멤버추가
	
	//회원정보 불러오기
	public MemberVO getMember(String id) {
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = DBManager.getConnection();
			sql = "SELECT * FROM member2 WHERE id = ?";
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계 sql 문 실행 
			rs = pstmt.executeQuery();
			//5단계 : rs데이터 사용
			if (rs.next()) {
				memberVO = new MemberVO();//멤버 vo 호출
				
				memberVO.setId(rs.getString("id")); //
				memberVO.setPasswd(rs.getString("passwd"));
				memberVO.setName(rs.getString("name"));
				//rs.getInt("age");
				String strAge = rs.getString("age");
				if (strAge != null) { //"33"
					memberVO.setAge(Integer.parseInt(strAge));//33
					// 문자열 숫자를 인티저로  바꿈.
				}
				memberVO.setMtel(rs.getString("mtel"));
				memberVO.setTel(rs.getString("tel"));
				memberVO.setGender(rs.getString("gender"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setRegDate(rs.getTimestamp("reg_date"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, pstmt, rs);
		}
		return memberVO;
	}// getMember method  회원정보보기 메소드
	
	
	// 유저체크 메소드 로그인
	public int userCheck(String id, String passwd) {
		int check = -1;// -1 아이디 없음 ,0 비번틀림 ,1 성공
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con= DBManager.getConnection();
			// 3단계 sql문
			sql = "SELECT passwd FROM member2 WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// sql문 실행
			rs = pstmt.executeQuery();
			// rs데이터 사용
			
			if (rs.next()) {
				// 아이디있음
				if (passwd.equals(rs.getString("passwd"))) {// 패스워드값받아와서 
					check = 1;// 아이디 있음
				} else {
					check = 0;// 비번틀림 
				}
			} else {// 아이디 없음;
				check = -1;
			}
					
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, pstmt, rs);
		}
		return check;
	}// user Check method  로그인 메소드
	
	public List<MemberVO> getMembers() {
		List<MemberVO> list = new ArrayList<MemberVO>();
		
		Connection con = null;
		java.sql.Statement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = DBManager.getConnection();
			sql = "SELECT * FROM member2 ORDER BY reg_date DESC";
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				MemberVO memberVO = new MemberVO();
				memberVO.setId(rs.getString("id")); //
				memberVO.setPasswd(rs.getString("passwd"));
				memberVO.setName(rs.getString("name"));
				//rs.getInt("age");
				String strAge = rs.getString("age");
				if (strAge != null) { //"33"
					memberVO.setAge(Integer.parseInt(strAge));//33
					// 문자열 숫자를 인티저로  바꿈.
				}
				memberVO.setMtel(rs.getString("mtel"));
				memberVO.setTel(rs.getString("tel"));
				memberVO.setGender(rs.getString("gender"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setRegDate(rs.getTimestamp("reg_date"));
				
				list.add(memberVO);
			}//while
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, stmt,rs);
		}
		return list;
	}// getMembers method 리스트 회원정보 
	
	
	
	// 회원정보 수정하기 메소드
	// 매개변수 memberVO에 passwd필드는 수정의대상이 아니라
	// 본인 확인 용도로 사용
	public int updateMember(MemberVO memberVO) {
		int rowCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql ="";
		
		try {
			con= DBManager.getConnection();
			
			sql = "UPDATE member2 SET name=? ,age=? ,gender=? ,mtel=? ,tel=? ,email=? WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberVO.getName());
			pstmt.setObject(2, memberVO.getAge());
			
			pstmt.setString(3, memberVO.getGender());
			pstmt.setString(4, memberVO.getMtel());
			pstmt.setString(5, memberVO.getTel());
			pstmt.setString(6, memberVO.getEmail());
			pstmt.setString(7, memberVO.getId());
			
			rowCount = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, pstmt, rs);	
		}
		return rowCount;
	}// updateMember method 회원정보 수정
	
	public int deleteMember(String id) {
		int rowCount = 0;
		//jdbc
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = DBManager.getConnection();
			sql = "DELETE FROM member2 WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, pstmt);
		}
		return rowCount;
	}//deleteMember
	
	// 관리자 권한으로 다중 아이디 삭제 배열을 활용해야한다.
    public void deleteMembers(String[] memberid) {
       // JDBC 참조변수 준비
       Connection con = null;
       PreparedStatement pstmt = null;
       String sql = "";
       
       //   for(int i=0; i<memberid.length; i++) {
       //      System.out.println(memberid[i]);
       //      System.out.println(memberid.length);
       //   }  
       // 이런식으로 확인하는 습관을 가져야한다.
       
       try {
          con = DBManager.getConnection();
          sql = "DELETE FROM member2 WHERE id = ? ";
          pstmt = con.prepareStatement(sql);
          
          for(int i=0; i<memberid.length; i++) {
             
             pstmt.setString(1, memberid[i]);
             pstmt.executeUpdate();
             // 실행을 for문안에 넣어야 계속 돌릴 수 있다.
          }
          
          
       } catch (Exception e) {
          e.printStackTrace();
       } finally {
          DBManager.close(con,pstmt);
       }
       
    } // deleteMembers method
	
	
	
	
}


















