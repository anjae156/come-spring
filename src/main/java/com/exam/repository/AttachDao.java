package com.exam.repository;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.exam.domain.AttachVO;

public class AttachDao {

	private static AttachDao instance = new AttachDao();
	
	public static AttachDao getInstance() {
		return instance;
	}

	private AttachDao() {}
	
	//첨부파일정보 입력ㅁ[섣,
	public void insertAttach(AttachVO attachVO){
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con= DBManager.getConnection();
			String sql = "INSERT INTO attach2 (uuid, filename, filetype, bno)";
			sql += "VALUES (?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, attachVO.getUuid());
			pstmt.setString(2, attachVO.getFilename());
			pstmt.setString(3, attachVO.getFiletype());
			pstmt.setInt(4, attachVO.getBno());
			// �떎�뻾
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, pstmt);
		}
		
	}
	
public List<AttachVO> getAttaches(int num){
		
		List<AttachVO> list = new ArrayList<AttachVO>();
		
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		try {
			con = DBManager.getConnection();
			
			String sql = "SELECT * FROM attach2 WHERE bno = ?";
			pstmt = con.prepareStatement(sql);
			
			
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();

			
			
			while(rs.next()) {
				AttachVO attachVO = new AttachVO();
				attachVO.setBno(rs.getInt("bno"));
				attachVO.setUuid(rs.getString("uuid"));
				attachVO.setFilename(rs.getString("filename"));
				attachVO.setFiletype(rs.getString("filetype"));
				
				list.add(attachVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	public List<AttachVO> getAttach(String[] num){
		
		List<AttachVO> list = new ArrayList<AttachVO>();
		
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		try {
			con = DBManager.getConnection();
			
			String sql = "SELECT * FROM attach2 WHERE bno = ?";
			pstmt = con.prepareStatement(sql);
			
			for (int i = 0; i < num.length; i++) {
				pstmt.setString(1, num[i]);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					AttachVO attachVO = new AttachVO();
					attachVO.setBno(rs.getInt("bno"));
					attachVO.setUuid(rs.getString("uuid"));
					attachVO.setFilename(rs.getString("filename"));
					attachVO.setFiletype(rs.getString("filetype"));
					
					list.add(attachVO);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, pstmt, rs);
		}
		
		return list;
	}
	
	
	
	public void deleteAttach(int bno){
		Connection con= null;
		PreparedStatement pstmt =null;
		
		try {
			con = DBManager.getConnection();
			String sql ="DELETE FROM attach2 WHERE bno = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
			// 실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, pstmt);
		}
	}// deleteAttach method
	// uuid에 해당하는 첨부파일정보 한개 삭제하는 메소드
	
	public void deleteAttach(String[] num){
		Connection con= null;
		PreparedStatement pstmt =null;
		
		try {
			con = DBManager.getConnection();
			String sql ="DELETE FROM attach2 WHERE bno = ?";
			
			pstmt = con.prepareStatement(sql);
			for (int i = 0; i < num.length; i++) {
				pstmt.setString(1, num[i]);
				// 실행
				pstmt.executeUpdate();
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(con, pstmt);
		}
	}// deleteAttach method
	// uuid에 해당하는 첨부파일정보 한개 삭제하는 메소드
		public void deleteAttach(String uuid) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = DBManager.getConnection();
				String sql = "DELETE FROM attach2 WHERE uuid = ? ";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, uuid);
				// 실행
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBManager.close(con, pstmt);
			}
		} // deleteAttach method
		
		
		
		
		
	
	
	
	
	
	
}
