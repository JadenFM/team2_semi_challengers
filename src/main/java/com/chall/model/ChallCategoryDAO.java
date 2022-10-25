package com.chall.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ChallCategoryDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	private static ChallCategoryDAO instance;
		
	private ChallCategoryDAO() {} 
	
	public static ChallCategoryDAO getinstance() {
		if(instance == null) {
			instance = new ChallCategoryDAO();
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
	
	
	// 카테고리 목록을 불러오는 메서드
	public List<ChallCategoryDTO> getCategoryList() {
		
		List<ChallCategoryDTO> list = new ArrayList<ChallCategoryDTO>();
		
		try {
			openConn();
			sql = "select category_name, category_image from challenge_category order by category_num";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				ChallCategoryDTO dto = new ChallCategoryDTO();
				
				dto.setCategory_name(rs.getString("category_name"));
				dto.setCategory_image(rs.getString("category_image"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}	// getCategoryList() END
	
}