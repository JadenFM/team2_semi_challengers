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

import com.user.model.UserDTO;

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
	public int getTotalRecord_category(int faq_category_num) {
		int result = 0;
		openConn();
		try {
			sql = "select count(*) from FAQ where faq_category_num = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,faq_category_num);
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
	public int InsertFAQ(FAQDTO dto) {
		int result = 0,count = 0;
		openConn();
		try {
			sql = "select max(faq_num) from faq";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}
			sql = "insert into faq values(?,?,?,sysdate,?)";
			st = con.prepareStatement(sql);
			st.setInt(1,count);
			st.setString(2, dto.getFaq_title());
			st.setString(3,dto.getFaq_content());
			st.setInt(4,dto.getFaq_category_num());
			result = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public FAQDTO getFAQContent(int faq_num) {
		FAQDTO dto = null;
		openConn();
		try {
			sql = "select * from faq where faq_num = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,faq_num);
			rs = st.executeQuery();
			if(rs.next()) {
				dto = new FAQDTO();
				dto.setFaq_num(rs.getInt("faq_num"));
				dto.setFaq_title(rs.getString("faq_title"));
				dto.setFaq_content(rs.getString("faq_content"));
				dto.setFaq_regdate(rs.getString("faq_regdate"));
				dto.setFaq_category_num(rs.getInt("faq_category_num"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return dto;
	}
	public int deleteFAQ(int faq_num) {
		int result = 0;
		openConn();
		try {
			sql = "delete from faq where faq_num = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,faq_num);
			result = st.executeUpdate();
			sql = "update faq set faq_num = faq_num - 1 where faq_num > ?";
			st = con.prepareStatement(sql);
			st.setInt(1,faq_num);
			st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public int updateFAQ(FAQDTO dto) {
		int result = 0;
		openConn();
		try {
			sql = "update faq set faq_title = ? , faq_content = ? , faq_category_num = ? where faq_num = ? ";
			st = con.prepareStatement(sql);
			st.setString(1,dto.getFaq_title());
			st.setString(2,dto.getFaq_content());
			st.setInt(3,dto.getFaq_category_num());
			st.setInt(4,dto.getFaq_num());
			result = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	
	public List<FAQDTO> getCategoryList(int startNo , int lastNo , int num){
		openConn();
		List<FAQDTO> list = new ArrayList<FAQDTO>();
		try {
			sql = "select * from (select rownum as rnum , a.* from (select * from faq where faq_category_num = ?) a where rownum <= ?) where rnum >= ?";
			st = con.prepareStatement(sql);
			st.setInt(1,num);
			st.setInt(2,lastNo);
			st.setInt(3,startNo);
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
	public String findout(String search){
		String result = "";
		openConn();
		try {
			sql = "select * from faq where faq_title like ?";
			st = con.prepareStatement(sql);
			st.setString(1,"%"+search+"%");
			rs = st.executeQuery();
			result += "<searchs>";
			while(rs.next()) {
				result += "<search>";
				result += "<faq_num>" + rs.getInt("faq_num")+ "</faq_num>";
				result += "<faq_title>" + rs.getString("faq_title") + "</faq_title>";
				result += "<faq_content>" + rs.getString("faq_content") + "</faq_content>";
				result += "<faq_regdate>" + rs.getString("faq_regdate") + "</faq_regdate>";
				result += "<faq_category_num>" + rs.getInt("faq_category_num") + "</faq_category_num>";
				result += "</search>";				
			}
			result += "<searchs>";
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result; 
	}
}