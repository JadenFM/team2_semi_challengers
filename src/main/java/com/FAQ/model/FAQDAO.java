package com.FAQ.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.chall.model.UserDTO;

public class FAQDAO {
	Connection con = null;
	PreparedStatement st = null;
	ResultSet rs = null;
	String sql = null;

	private static FAQDAO instance;
	private FAQDAO() {  }  // 기본 생성자
	public static FAQDAO getInstance() {

		if(instance == null) {
			instance = new FAQDAO();
		}

		return instance;
	}

	public void openConn() {
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@projectchallengers_high?TNS_ADMIN=C:/NCS/downroad/apache-tomcat-9.0.65/Wallet_ProjectChallengers/";
		String user = "ADMIN";
		String password = "WelcomeTeam2";
	
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
	
		} catch(Exception e){
			e.printStackTrace();
		}
	} // openConn() END

	public void closeConn(ResultSet rs,
			PreparedStatement st, Connection con) {

		try {
			if(rs != null) rs.close();

			if(st != null) st.close();

			if(con != null) con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}

	}  // closeConn() 메서드 end
	public int getTotalRecord() {
		int result = 0;
		openConn();
		try {
			sql = "select count(*) from FAQ";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public List<FAQDTO> getFAQList(int startNo, int lastNo) {
		List<FAQDTO> list = new ArrayList<FAQDTO>();
		openConn();
		try {
			sql = "select * from (select rownum as rnum , a.* from (select * from FAQ order by faq_num desc)a where rownum <= ?)where rnum >= ?";
			st = con.prepareStatement(sql);
			st.setInt(1, lastNo);
			st.setInt(2,startNo);
			rs = st.executeQuery();
			while(rs.next()) {
				FAQDTO dto = new FAQDTO();
				dto.setFaq_num(rs.getInt("faq_num"));
				dto.setFaq_title(rs.getString("faq_title"));
				dto.setFaq_content(rs.getString("faq_content"));
				dto.setFaq_regdate(rs.getString("faq_regdate"));
				dto.setFaq_category_num(rs.getInt("faq_category_num"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return list;
	}
}
