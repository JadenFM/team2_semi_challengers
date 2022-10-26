package com.chall.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	private static UserDAO instance;
		
	private UserDAO() {} 
	
	public static UserDAO getinstance() {
		if(instance == null) {
			instance = new UserDAO();
		}
		return instance;
	}
	

// Connection을 가져오는 메서드
	public void openConn() {
	
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@projectchallengers_high?TNS_ADMIN=C:/NCS/download/apache-tomcat-9.0.65/Wallet_ProjectChallengers/";
		String user = "ADMIN";
		String password = "WelcomeTeam2";
	
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
	
		} catch(Exception e){
			e.printStackTrace();
		}
	} // openConn() END
	
	
// 사용한 자원을 반환하는 메서드
	public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {
	
		try {
	
			if (rs != null) { rs.close(); }
			if (pstmt != null) { pstmt.close(); }
			if (con != null) { con.close(); }
	
		}catch(SQLException e){
			e.printStackTrace();
		}
	} // closeConn() END
	
	// 회원인 지 체크하는 메소드.
	public int userCheck(String id, String pwd) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select * from user_member where mem_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				if(pwd.equals(rs.getString("mem_pwd"))) {
					// 회원인 경우
					result = 1;
				}else {
					// 회원 아이디는 맞으나 비밀번호가 틀린 경우
					result = -1;
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}	// userCheck() 메소드 end
	
	// id에 해당하는 회원의 정보를 조회하는 메소드
	public UserDTO getMember(String id) {
		
		UserDTO dto = null;

		try {
			openConn();
			
			sql = "select * from user_member where mem_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();	
			
			if(rs.next()) {
				dto = new UserDTO();
				
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setMem_id(rs.getString("mem_id"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_pwd(rs.getString("mem_pwd"));
				dto.setMem_age(rs.getInt("mem_age"));
				dto.setMem_phone(rs.getString("mem_phone"));
				dto.setMem_addr(rs.getString("mem_addr"));
				dto.setMem_xp(rs.getInt("mem_xp"));
				dto.setMem_level(rs.getString("mem_level"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setMem_money(rs.getInt("mem_money"));
				dto.setMem_reward(rs.getInt("mem_reward"));
				dto.setChallenge_count(rs.getInt("challenge_count"));
				dto.setChallenge_complete_count(rs.getInt("challenge_complete_count"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
		
	}	// getMember() 메소드 end
	
	// user_member 테이블에서 회원번호에 해당하는 회원의 정보를 가져오는 메소드
	public UserDTO getMemberInfo(int member_num) {
		
		UserDTO dto = null;
		
		try {
			openConn();
			
			sql = "select * from user_member where mem_num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, member_num);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new UserDTO();
				
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setMem_id(rs.getString("mem_id"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_pwd(rs.getString("mem_pwd"));
				dto.setMem_age(rs.getInt("mem_age"));
				dto.setMem_phone(rs.getString("mem_phone"));
				dto.setMem_addr(rs.getString("mem_addr"));
				dto.setMem_xp(rs.getInt("mem_xp"));
				dto.setMem_level(rs.getString("mem_level"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setMem_money(rs.getInt("mem_money"));
				dto.setMem_reward(rs.getInt("mem_reward"));
				dto.setChallenge_count(rs.getInt("challenge_count"));
				dto.setChallenge_complete_count(rs.getInt("challenge_complete_count"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}	// getMemberInfo() 메소드 end
	
	// 카카오 이메일로 DB에 존재하는 회원인지 확인하는 메소드.
	public String savedUserCheck(String email) {
		
		String savedUser = null;
		
		UserDTO dto = null;
		
		try {
			openConn();
			
			sql = "select * from user_member where mem_email=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {	// 카카오에서 받아온 이메일을 가진 회원이 이미 있으면 yes
				savedUser = "yes";
			}else {
				savedUser = "no";
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return savedUser;
		
	} // savedUserCheck() 메소드 end
	

	
}