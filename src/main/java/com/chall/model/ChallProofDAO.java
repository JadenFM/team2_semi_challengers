package com.chall.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ChallProofDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	private static ChallProofDAO instance;
		
	private ChallProofDAO() {} 
	
	public static ChallProofDAO getInstance() {
		if(instance == null) {
			instance = new ChallProofDAO();
		}
		return instance;
	}
	

// Connection을 가져오는 메서드
	public void openConn() {
	
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@projectchallengers_high?TNS_ADMIN=C:/ncs/download/apache-tomcat-9.0.65/Wallet_ProjectChallengers/";
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
	
	
	// 인증 테이블에 열 생성
	public void proofInsert(int challNum, int memberNum, int deposit) {
		int count = 0;

		try {
			openConn();
			sql = "select max(proof_num) from proof_shot";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1) + 1;
			}
			sql = "insert into proof_shot values(?,?,?,'','','',?,'')";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setInt(2, challNum);
			pstmt.setInt(3, memberNum);
			pstmt.setInt(4, deposit);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	}	// proofInsert() end
	
		
	// 참가한 챌린지인지 체크(인증테이블에 기존 생성된 열이 있는지 체크)
	public int checkJoin(int chall_num, int mem_num) {
		int result = 0;
		try {
			openConn();
			sql = "select * from proof_shot where proof_chall_num = ? and proof_mem_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, chall_num);
			pstmt.setInt(2, mem_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {	// DB에 정보가 하나라도 검색되는 경우 : '참가완료'
				result = 1;
			}else {			// DB에 정보가 하나도 검색 안되는 경우 : '참가하기'
				result = -1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// checkJoin() end
	
	
	// 가장 최근 인증한 날짜를 불러옴
	public String latestProofDate(int chall_num, int memberNum) {
		String date = "";
		try {
			openConn();
			sql = "select proof_regdate from proof_shot where proof_num"
					+ "=(select max(proof_num) from proof_shot where proof_chall_num = ? and proof_mem_num = ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, chall_num);
			pstmt.setInt(2, memberNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				date = rs.getString("proof_regdate");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return date;
	}	// latestProofDate() end
	
	
	// 참여할 때 해당 회원의 해당 챌린지에 설정한 예치금 액수를 가져옴
	public int getProofDeposit(int chall_num, int memberNum) {
		int deposit = 0;
		try {
			openConn();
			sql = "select proof_deposit from proof_shot where proof_num"
					+ "=(select min(proof_num) from proof_shot where proof_chall_num = ? and proof_mem_num = ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, chall_num);
			pstmt.setInt(2, memberNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				deposit = Integer.parseInt(rs.getString("proof_deposit"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return deposit;
	}	// getProofDeposit() end
	
	
	// 해당 회원의 해당 챌린지에 등록되어 있는 인증 정보를 불러옴(인증날짜, 이미지)
	public List<ChallProofDTO> getProofInfoList(int chall_num, int mem_num) {
		List<ChallProofDTO> list = new ArrayList<ChallProofDTO>();
		try {
			openConn();
			sql = "select * from proof_shot where proof_chall_num = ? and proof_mem_num = ? order by proof_num";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, chall_num);
			pstmt.setInt(2, mem_num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChallProofDTO dto = new ChallProofDTO();
				dto.setProof_regdate(rs.getString("proof_regdate"));
				dto.setProof_image(rs.getString("proof_image"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}	// getProofInfoList() END
	
	
	// 인증샷 업로드 최초(최초 생성된 열에 등록날짜와 인증샷 파일명 저장)
	public void updateProof(String proofImage, int chall_num, int memberNum) {
		try {
			openConn();
			sql = "update proof_shot set proof_regdate = sysdate, proof_image = ? where proof_num"
					+ "=(select proof_num from proof_shot where proof_chall_num = ? and proof_mem_num = ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, proofImage);
			pstmt.setInt(2, chall_num);
			pstmt.setInt(3, memberNum);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
	}	// updateProof() end
	
	
	// 인증샷 업로드 2회 이상(기존 열에 추가로 새로운 열 생성)
	public void addNewProof(String proofImage, int chall_num, int memberNum) {
		int count = 0;

		try {
			openConn();
			sql = "select max(proof_num) from proof_shot";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1) + 1;
			}
			sql = "insert into proof_shot values(?,?,?,sysdate,'',?,'','')";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setInt(2, chall_num);
			pstmt.setInt(3, memberNum);
			pstmt.setString(4, proofImage);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	}	// insertNewProof() end
}