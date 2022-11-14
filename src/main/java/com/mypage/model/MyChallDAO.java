package com.mypage.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chall.controller.OjdbcUrl;
import com.chall.model.ChallCategoryDTO;
import com.chall.model.ChallengeDTO;
import com.user.model.UserDTO;

public class MyChallDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	private static MyChallDAO instance;
		
	private MyChallDAO() {} 
	
	public static MyChallDAO getinstance() {
		if(instance == null) {
			instance = new MyChallDAO();
		}
		return instance;
	}
	
	OjdbcUrl oju = new OjdbcUrl();

	// Connection을 가져오는 메서드
	public void openConn() {
	
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = oju.getUrl();
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
	
	
	
	
	// 해당 회원의 전체 챌린지 참여 수(challenge_count), 완수한 챌린지 수(challenge_complete_count), 경험치(mem_xp) 컬럼값을 반환하는 메소드.
	public UserDTO getUserChallengeInfo(int member_num) {
			
		UserDTO dto = null;
		
		try {
			
			openConn();
			
			sql = "select * from user_member where mem_num = ? ";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new UserDTO();
				
				dto.setChallenge_count(rs.getInt("challenge_count"));
				dto.setChallenge_complete_count(rs.getInt("challenge_complete_count"));
				dto.setMem_xp(rs.getInt("mem_xp"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
		
	}	// getUserChallengeInfo() 메소드 end
	
	// 해당 회원이 참여하고 있는,(챌린지 상태가 '진행중'인) 챌린지 리스트를 반환하는 메소드.
	public List<ChallengeDTO> getOngoingChallList(int member_num) {
		
		ChallengeDTO challDto = null;
		
		List<ChallengeDTO> list = new ArrayList<ChallengeDTO>();
		
		try {
			openConn();
			
			sql = "select * from challenge_list where (chall_num in (select proof_chall_num from proof_shot where proof_mem_num = ?) and (chall_num in (select chall_num from challenge_list where chall_status='진행중'))) order by chall_num desc";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){	
				challDto = new ChallengeDTO();
				
				challDto.setChall_num(rs.getInt("chall_num"));
				challDto.setChall_category_code_fk(rs.getString("CHALL_CATEGORY_CODE_FK"));
				challDto.setChall_mainimage(rs.getString("CHALL_MAINIMAGE"));
				challDto.setChall_title(rs.getString("CHALL_TITLE"));
				challDto.setChall_duration(rs.getString("CHALL_DURATION"));
				challDto.setChall_status(rs.getString("CHALL_STATUS"));
				
				list.add(challDto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
	
	}	// getOngoingChallList() 메소드 end
	
	// 해당 회원이 참가했던, 챌린지 상태가 '완료'인 챌린지 목록을 반환하는 메소드.
	public List<ChallengeDTO> getCompelteChallList(int member_num){
		
		ChallengeDTO challDto =null;
		
		List<ChallengeDTO> list = null;
			
		try {
			openConn();
			
			sql = "select * from challenge_list where (chall_num in (select proof_chall_num from proof_shot where proof_mem_num = ?) and (chall_num in (select chall_num from challenge_list where chall_status='완료'))) order by chall_num desc";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				list = new ArrayList<ChallengeDTO>();
				
				challDto = new ChallengeDTO();
				
				challDto.setChall_num(rs.getInt("chall_num"));
				challDto.setChall_category_code_fk(rs.getString("CHALL_CATEGORY_CODE_FK"));
				challDto.setChall_mainimage(rs.getString("CHALL_MAINIMAGE"));
				challDto.setChall_title(rs.getString("CHALL_TITLE"));
				challDto.setChall_duration(rs.getString("CHALL_DURATION"));
				challDto.setChall_status(rs.getString("CHALL_STATUS"));
				
				list.add(challDto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return list;
		
	} // getCompelteChallList() 메소드 end
	
	
	// 해당 회원이 참가했던, 챌린지 상태가 '완료'인 챌린지 목록을 반환하는 메소드.
	public List<ChallengeDTO> getMyCreateChallList(int member_num){
		
		ChallengeDTO challDto =null;
		
		List<ChallengeDTO> list = null;
			
		try {
			openConn();
			
			sql = "select * from challenge_list where CHALL_CREATER_NUM = ? ";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				list = new ArrayList<ChallengeDTO>();
				
				challDto = new ChallengeDTO();
				
				challDto.setChall_num(rs.getInt("chall_num"));
				challDto.setChall_category_code_fk(rs.getString("CHALL_CATEGORY_CODE_FK"));
				challDto.setChall_mainimage(rs.getString("CHALL_MAINIMAGE"));
				challDto.setChall_title(rs.getString("CHALL_TITLE"));
				challDto.setChall_duration(rs.getString("CHALL_DURATION"));
				challDto.setChall_status(rs.getString("CHALL_STATUS"));
				
				list.add(challDto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
		
	} // getMyCreateChallList() 메소드 end	
	
	// 현재 경험치를 받아 현재 레벨을 알려주는 메소드
	public String getPresentLevel(int myXp) {
		
		String myLevel = "";
		
		if(0<=myXp || myXp <100) {
			myLevel = "Level1";
		}else if(100<=myXp || myXp <300) {
			myLevel = "Level2";
		}else if(300<=myXp || myXp <1000) {
			myLevel = "Level3";
		}else if(1000<=myXp || myXp <3000) {
			myLevel = "Level4";
		}else if(3000<=myXp || myXp <10000) {
			myLevel = "Level5";
		}else if(10000<=myXp || myXp <30000) {
			myLevel = "Level6";
		}else if(30000<=myXp || myXp <100000) {
			myLevel = "Level7";
		}else if(100000<=myXp || myXp <300000) {
			myLevel = "Level8";
		}else if(300000<=myXp || myXp <1000000) {
			myLevel = "Level9";
		}else {
			myLevel = "Level10";
		}
			
		return myLevel;

	}	// getPresentLevel() 메소드 end

	// 현재 레벨과 현재 경험치를 받아서 다음 레벨까지 얼마나 남았는지 알려주는 메소드.
	public int getXpToNextLevel(String myLevel, int myXp) {
		
		int xpToNextLevel = 0;
		
		if(myLevel.equals("Level1")) {
			xpToNextLevel = 100 - myXp;
		}else if(myLevel.equals("Level2")) {
			xpToNextLevel = 300 - myXp;
		}else if(myLevel.equals("Level3")) {
			xpToNextLevel = 1000 - myXp;
		}else if(myLevel.equals("Level4")) {
			xpToNextLevel = 3000 - myXp;
		}else if(myLevel.equals("Level5")) {
			xpToNextLevel = 10000 - myXp;
		}else if(myLevel.equals("Level6")) {
			xpToNextLevel = 30000 - myXp;
		}else if(myLevel.equals("Level7")) {
			xpToNextLevel = 100000 - myXp;
		}else if(myLevel.equals("Level8")) {
			xpToNextLevel = 300000 - myXp;
		}else if(myLevel.equals("Level9")) {
			xpToNextLevel = 1000000 - myXp;
		}else {
			xpToNextLevel = 0;
		}
		
		return xpToNextLevel;
	}	// getXpToNextLevel() 메소드 end
	
	// 해당 회원의 예치금 로그를 불러오는 메소드
	public List<MoneyLogDTO> getMoneyLog(int member_num){
	
		MoneyLogDTO dto = null;
		
		List<MoneyLogDTO> list = new ArrayList<MoneyLogDTO>();
		
		try {
			openConn();
			
			sql = "select to_char(log_date,'YYYY/MM/DD') as log_date, mem_num, chall_num, money_log_content, money_log_kind, money_log_my_deposit from money_log where mem_num = ? order by log_date desc";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				dto = new MoneyLogDTO();
				dto.setLog_date(rs.getString("log_date"));
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setChall_num(rs.getInt("chall_num"));
				dto.setMoney_log_content(rs.getInt("money_log_content"));
				dto.setMoney_log_kind(rs.getString("money_log_kind"));
				dto.setMoney_log_my_deposit(rs.getInt("money_log_my_deposit"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
	}	// getMoneyLog() 메소드 end
	
	   public int getTotalChallCount(int member_num) {
		      int count = 0;
		         try {
		            openConn();
		            sql = "select distinct count(proof_chall_num) from proof_shot where proof_mem_num = ?";
		            pstmt = con.prepareStatement(sql);
		            pstmt.setInt(1, member_num);
		            rs = pstmt.executeQuery();
		            
		            if(rs.next()) {
		               count=rs.getInt(1);
		            }
		            
		      } catch (SQLException e) {
		         // TODO Auto-generated catch block
		         e.printStackTrace();
		      }finally {
		         closeConn(rs, pstmt, con);
		      }
		         return count;
		   }	
	
	
}
