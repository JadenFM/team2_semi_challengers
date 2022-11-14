package com.chall.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chall.controller.OjdbcUrl;

public class ChallengeDAO {
	Connection con = null;
	PreparedStatement st = null;
	ResultSet rs = null;
	String sql = "";
	
	private static ChallengeDAO instance;
		
	private ChallengeDAO() {} 
	
	public static ChallengeDAO getinstance() {
		if(instance == null) {
			instance = new ChallengeDAO();
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
	public void closeConn(ResultSet rs, PreparedStatement st, Connection con) {
	
		try {
	
			if (rs != null) { rs.close(); }
			if (st != null) { st.close(); }
			if (con != null) { con.close(); }
	
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	public int getTotalRecord() {
		int result = 0;
		openConn();
		try {
			sql = "select count(*) from challenge_list";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	
	public int getTotalRecord_category(String category_code) {
		int result = 0;
		openConn();
		try {
			sql = "select count(*) from challenge_list where chall_category_code_fk = ?";
			st = con.prepareStatement(sql);
			st.setString(1,category_code);
			rs = st.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}

	public List<ChallengeDTO> getChallengeList(int startNo, int lastNo) {
		List<ChallengeDTO> list = new ArrayList<ChallengeDTO>();
		openConn();
		try {
			sql = "select * from (select rownum as rnum , a.* from (select * from challenge_list order by chall_num)a where rownum <= ?) where rnum >= ?";
			st = con.prepareStatement(sql);
			st.setInt(1,lastNo);
			st.setInt(2,startNo);
			rs = st.executeQuery();
			while(rs.next()) {
				ChallengeDTO dto = new ChallengeDTO();
				dto.setChall_open(rs.getString("chall_open"));
				dto.setChall_num(rs.getInt("chall_num"));
				dto.setChall_title(rs.getString("chall_title"));
				dto.setChall_mainimage(rs.getString("chall_mainimage"));
				dto.setChall_cycle(rs.getString("chall_cycle"));
				dto.setChall_duration(rs.getString("chall_duration"));
				dto.setChall_startdate(rs.getString("chall_startdate"));
				dto.setChall_guide(rs.getString("chall_guide"));
				dto.setChall_successimage(rs.getString("chall_successimage"));
				dto.setChall_failmage(rs.getString("chall_failimage"));
				dto.setChall_regitimestart(rs.getString("chall_regitimestart"));
				dto.setChall_regitimeend(rs.getString("chall_regitimeend"));
				dto.setChall_cont(rs.getString("chall_cont"));
				dto.setChall_depositdefault(rs.getString("chall_depositdefault"));
				dto.setChall_depositmax(rs.getString("chall_depositmax"));
				dto.setChall_privatecode(rs.getString("chall_privatecode"));
				dto.setChall_maxpeople(rs.getString("chall_maxpeople"));
				dto.setChall_category_code_fk(rs.getString("chall_category_code_fk"));
				dto.setChall_subcategory(rs.getString("chall_subcategory"));
				dto.setAdmin_id_fk(rs.getString("admin_id_fk"));
				dto.setChall_status(rs.getString("chall_status"));
				dto.setChall_creater_num(rs.getInt("chall_creater_num"));
				dto.setChall_ongoingpeople(rs.getInt("chall_ongoingpeople"));
				dto.setChall_contimage(rs.getString("chall_contimage"));
				dto.setChall_keyword1(rs.getString("chall_keyword1"));
				dto.setChall_keyword1(rs.getString("chall_keyword2"));
				dto.setChall_keyword1(rs.getString("chall_keyword3"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return list;
	}

	public ChallengeDTO getChallengeContent(int chall_num) {
		ChallengeDTO dto = null;
		openConn();
		try {
			sql = "select * from challenge_list where chall_num = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,chall_num);
			rs = st.executeQuery();
			if(rs.next()) {
				dto = new ChallengeDTO();
				dto.setChall_open(rs.getString("chall_open"));
				dto.setChall_num(rs.getInt("chall_num"));
				dto.setChall_title(rs.getString("chall_title"));
				dto.setChall_mainimage(rs.getString("chall_mainimage"));
				dto.setChall_cycle(rs.getString("chall_cycle"));
				dto.setChall_duration(rs.getString("chall_duration"));
				dto.setChall_startdate(rs.getString("chall_startdate"));
				dto.setChall_guide(rs.getString("chall_guide"));
				dto.setChall_successimage(rs.getString("chall_successimage"));
				dto.setChall_failmage(rs.getString("chall_failimage"));
				dto.setChall_regitimestart(rs.getString("chall_regitimestart"));
				dto.setChall_regitimeend(rs.getString("chall_regitimeend"));
				dto.setChall_cont(rs.getString("chall_cont"));
				dto.setChall_depositdefault(rs.getString("chall_depositdefault"));
				dto.setChall_depositmax(rs.getString("chall_depositmax"));
				dto.setChall_privatecode(rs.getString("chall_privatecode"));
				dto.setChall_maxpeople(rs.getString("chall_maxpeople"));
				dto.setChall_category_code_fk(rs.getString("chall_category_code_fk"));
				dto.setChall_subcategory(rs.getString("chall_subcategory"));
				dto.setAdmin_id_fk(rs.getString("admin_id_fk"));
				dto.setChall_status(rs.getString("chall_status"));
				dto.setChall_creater_num(rs.getInt("chall_creater_num"));
				dto.setChall_ongoingpeople(rs.getInt("chall_ongoingpeople"));
				dto.setChall_contimage(rs.getString("chall_contimage"));
				dto.setChall_keyword1(rs.getString("chall_keyword1"));
				dto.setChall_keyword1(rs.getString("chall_keyword2"));
				dto.setChall_keyword1(rs.getString("chall_keyword3"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return dto;
	}

	public int Updatechallenge(ChallengeDTO dto) {
		int result = 0;
		openConn();
		try {
			sql = "update challenge_list set chall_title=? , chall_category_code_fk=? , chall_cycle=? , chall_guide=? , chall_regitimestart=? , chall_regitimeend=? , chall_cont=? , chall_depositdefault=? , chall_depositmax=? , chall_maxpeople=? where chall_num=?";
			st = con.prepareStatement(sql);
			st.setString(1,dto.getChall_title());
			st.setString(2,dto.getChall_category_code_fk());
			st.setString(3,dto.getChall_cycle());
			st.setString(4,dto.getChall_guide());
			st.setString(5,dto.getChall_regitimestart());
			st.setString(6,dto.getChall_regitimeend());
			st.setString(7,dto.getChall_cont());
			st.setString(8,dto.getChall_depositdefault());
			st.setString(9,dto.getChall_depositmax());
			st.setString(10,dto.getChall_maxpeople());
			st.setInt(11,dto.getChall_num());
			result = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}

	public void Deletechallenge(int chall_num) {
		openConn();
		sql = "delete from challenge_list where chall_num = ?";
		try {
			st = con.prepareStatement(sql);
			st.setInt(1,chall_num);
			st.executeUpdate();
			sql = "update challenge_list set chall_num = chall_num - 1 where chall_num > ?";
			st = con.prepareStatement(sql);
			st.setInt(1,chall_num);
			st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
	}

	public List<ChallengeDTO> getCategoryList(String category_code, int startNo, int lastNo) {
		openConn();
		List<ChallengeDTO> list = new ArrayList<ChallengeDTO>();
		try {
			sql = "select * from (select rownum as rnum , a.* from (select * from challenge_list where chall_category_code_fk = ? order by chall_num desc) a where rownum <= ?) where rnum >= ?";
			st = con.prepareStatement(sql);
		st.setString(1,category_code);
			st.setInt(2,lastNo);
			st.setInt(3,startNo);
			rs = st.executeQuery();
			while(rs.next()) {
				ChallengeDTO dto = new ChallengeDTO();
				dto.setChall_open(rs.getString("chall_open"));
				dto.setChall_num(rs.getInt("chall_num"));
				dto.setChall_title(rs.getString("chall_title"));
				dto.setChall_mainimage(rs.getString("chall_mainimage"));
				dto.setChall_cycle(rs.getString("chall_cycle"));
				dto.setChall_duration(rs.getString("chall_duration"));
				dto.setChall_startdate(rs.getString("chall_startdate"));
				dto.setChall_guide(rs.getString("chall_guide"));
				dto.setChall_successimage(rs.getString("chall_successimage"));
				dto.setChall_failmage(rs.getString("chall_failimage"));
				dto.setChall_regitimestart(rs.getString("chall_regitimestart"));
				dto.setChall_regitimeend(rs.getString("chall_regitimeend"));
				dto.setChall_cont(rs.getString("chall_cont"));
				dto.setChall_depositdefault(rs.getString("chall_depositdefault"));
				dto.setChall_depositmax(rs.getString("chall_depositmax"));
				dto.setChall_privatecode(rs.getString("chall_privatecode"));
				dto.setChall_maxpeople(rs.getString("chall_maxpeople"));
				dto.setChall_category_code_fk(rs.getString("chall_category_code_fk"));
				dto.setChall_subcategory(rs.getString("chall_subcategory"));
				dto.setAdmin_id_fk(rs.getString("admin_id_fk"));
				dto.setChall_status(rs.getString("chall_status"));
				dto.setChall_creater_num(rs.getInt("chall_creater_num"));
				dto.setChall_ongoingpeople(rs.getInt("chall_ongoingpeople"));
				dto.setChall_contimage(rs.getString("chall_contimage"));
				dto.setChall_keyword1(rs.getString("chall_keyword1"));
				dto.setChall_keyword1(rs.getString("chall_keyword2"));
				dto.setChall_keyword1(rs.getString("chall_keyword3"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return list;
	}
	public int getTotalRecord_search(String search) {
		int result = 0;
		openConn();
		try {
			sql = "select count(*) from challenge_list where chall_title like ?";
			st = con.prepareStatement(sql);
			st.setString(1,"%"+search+"%");
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
	public String pagination(int rowsize ,int block , int pages, int startNo , int lastNo , int startBlock , int lastBlock , int totalRecord , int allPage) {
		String please = "";
		please += "<paginations>";
		please += "<pagination>";
		please += "<rowsize>" + rowsize + "</rowsize>";
		please += "<block>" + block + "</block>";
		please += "<pages>" + pages + "</pages>";
		please += "<startNo>" + startNo + "</startNo>";
		please += "<lastNo>" + lastNo + "</lastNo>";
		please += "<startBlock>" + startBlock + "</startBlock>";
		please += "<lastBlock>" + lastBlock + "</lastBlock>";
		please += "<totalRecord>" + totalRecord + "</totalRecord>";
		please += "<allPage>" + allPage + "</allPage>";
		please += "</pagination>";
		please += "</paginations>";
		return please;
	}
	public String findout(String search , int startNo , int lastNo) {
		String result = "";
		openConn();
		sql = "select * from (select rownum as rnum , a.* from (select * from challenge_list where chall_title like ? order by chall_num desc) a where rownum <= ?) where rnum >= ?";
		try {
			st = con.prepareStatement(sql);
			st.setString(1,"%"+search+"%");
			st.setInt(2,lastNo);
			st.setInt(3,startNo);
			rs = st.executeQuery();
			result += "<searchs>";
			while(rs.next()) {
				result += "<search>";
				result += "<chall_num>" + rs.getInt("chall_num") +"</chall_num>";
				result += "<chall_title>" + rs.getString("chall_title") +"</chall_title>";
				result += "<chall_mainimage>" + rs.getString("chall_mainimage") +"</chall_mainimage>";
				result += "<chall_category_code_fk>" + rs.getString("chall_category_code_fk") + "</chall_category_code_fk>";
				result += "</search>";
				System.out.println(rs.getInt("chall_num"));
				System.out.println(rs.getString("chall_title"));
			}
			result += "</searchs>";
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
}