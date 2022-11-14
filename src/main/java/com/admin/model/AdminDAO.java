package com.admin.model;

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

import com.report.model.ReportDTO;
import com.user.model.UserDTO;

public class AdminDAO {
	Connection con = null;
	PreparedStatement st = null;
	ResultSet rs = null;
	String sql = null;

	private static AdminDAO instance;
	private AdminDAO() {  }  // 기본 생성자
	public static AdminDAO getInstance() {

		if(instance == null) {
			instance = new AdminDAO();
		}

		return instance;
	}

	public void openConn() {
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@projectchallengers_high?TNS_ADMIN=C:/ncs/download/apache-tomcat-9.0.65/Wallet_ProjectChallengers";
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
	public int getAdminlogin(String admin_id, String admin_pwd) {
		int result = 0;
		openConn();
		try {
			sql = "select * from admin_member where admin_id = ?";
			st = con.prepareStatement(sql);
			st.setString(1,admin_id);
			rs = st.executeQuery();
			if(rs.next()) {
				if(rs.getString("admin_pwd").equals(admin_pwd)) {
					result = 1;
				}else {
					result = -1;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public AdminDTO getAdmin(String admin_id) {
		AdminDTO dto = null;
		openConn();
		try {
			sql = "select * from admin_member where admin_id = ?";
			st = con.prepareStatement(sql);
			st.setString(1,admin_id);
			rs = st.executeQuery();
			if(rs.next()) {
				dto = new AdminDTO();
				dto.setAdmin_num(rs.getInt("admin_num"));
				dto.setAdmin_id(rs.getString("admin_id"));
				dto.setAdmin_pwd(rs.getString("admin_pwd"));
				dto.setAdmin_name(rs.getString("admin_name"));
				dto.setAdmin_age(rs.getInt("admin_age"));
				dto.setAdmin_addr(rs.getString("admin_addr"));
				dto.setAdmin_phone(rs.getString("admin_phone"));
				dto.setAdmin_regdate(rs.getString("admin_regdate"));
				dto.setAdmin_email(rs.getString("admin_email"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return dto;
	}
	public int adminJoin(AdminDTO dto) {
		int result = 0,count =0;
		openConn();
		try {
			sql = "select max(admin_num) from admin_member";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}
			sql = "insert into admin_member values(?,?,?,?,?,?,?,sysdate,?)";
			st = con.prepareStatement(sql);
			st.setInt(1,count);
			st.setString(2,dto.getAdmin_id());
			st.setString(3,dto.getAdmin_pwd());
			st.setString(4,dto.getAdmin_name());
			st.setInt(5,dto.getAdmin_age());
			st.setString(6,dto.getAdmin_addr());
			st.setString(7,dto.getAdmin_phone());
			st.setString(8,dto.getAdmin_email());
			result = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public List<AdminDTO> getAdminList() {
		List<AdminDTO> list = new ArrayList<AdminDTO>();
		openConn();
		sql = "select * from admin_member";
		try {
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			while(rs.next()) {
				AdminDTO dto = new AdminDTO();
				dto.setAdmin_num(rs.getInt("admin_num"));
				dto.setAdmin_id(rs.getString("admin_id"));
				dto.setAdmin_pwd(rs.getString("admin_pwd"));
				dto.setAdmin_name(rs.getString("admin_name"));
				dto.setAdmin_age(rs.getInt("admin_age"));
				dto.setAdmin_addr(rs.getString("admin_addr"));
				dto.setAdmin_phone(rs.getString("admin_phone"));
				dto.setAdmin_regdate(rs.getString("admin_regdate"));
				dto.setAdmin_email(rs.getString("admin_email"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return list;
	}
	public AdminDTO getAdminContent(String admin_name) {
		AdminDTO dto = null;
		openConn();
		try {
			sql = "select * from admin_member where admin_name = ? ";
			st = con.prepareStatement(sql);
			st.setString(1,admin_name);
			rs = st.executeQuery();
			if(rs.next()) {
				dto = new AdminDTO();
				dto.setAdmin_num(rs.getInt("admin_num"));
				dto.setAdmin_id(rs.getString("admin_id"));
				dto.setAdmin_pwd(rs.getString("admin_pwd"));
				dto.setAdmin_name(rs.getString("admin_name"));
				dto.setAdmin_age(rs.getInt("admin_age"));
				dto.setAdmin_addr(rs.getString("admin_addr"));
				dto.setAdmin_phone(rs.getString("admin_phone"));
				dto.setAdmin_regdate(rs.getString("admin_regdate"));
				dto.setAdmin_email(rs.getString("admin_email"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return dto;
	}
	public int makingpwd(String admin_name, String admin_id, String key) {
		int result = 0;
		openConn();
		try {
			sql = "select * from admin_member where admin_id = ?";
			st = con.prepareStatement(sql);
			st.setString(1,admin_id);
			rs = st.executeQuery();
			if(rs.next()) {
				if(rs.getString("admin_name").equals(admin_name)) {
					sql = "update admin_member set admin_pwd = ? where admin_name = ?";
					st = con.prepareStatement(sql);
					st.setString(1,key);
					st.setString(2,admin_name);
					result = st.executeUpdate();
				}else {
					result = -1;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	public List<UserDTO> getUserList(int startNo, int lastNo) {
		List<UserDTO> list = new ArrayList<UserDTO>();
		int count = 0;
		openConn();
		try {
			sql = "select * from (select rownum as rnum , a.* from (select * from user_member order by mem_num desc)a where rownum <= ?) where rnum >= ? ";
			st = con.prepareStatement(sql);
			st.setInt(1,lastNo);
			st.setInt(2,startNo);
			rs = st.executeQuery();
			while(rs.next()) {
				UserDTO dto = new UserDTO();
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
				dto.setMem_report_count(rs.getInt("mem_report_count"));
				list.add(dto);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return list;
	}
	public int gettotalrecord() {
		int result = 0;
		openConn();
		try {
			sql = "select count(*) from user_member";
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
	public int deleteMember(int mem_num) {
		int result = 0;
		openConn();
		try {
			sql = "delete from user_member where mem_num = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,mem_num);
			result = st.executeUpdate();
			sql = "update user_member set mem_num = mem_num - 1 where mem_num > ?";
			st = con.prepareStatement(sql);
			st.setInt(1,mem_num);
			st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public List<ReportDTO> getReportList(int startNo, int lastNo) {
		List<ReportDTO> list = new ArrayList<ReportDTO>();
		openConn();
		try {
			sql = "select * from (select rownum as rnum , a.* from (select * from member_report order by report_num desc) a where rownum <= ?) where rnum >= ?";
			st = con.prepareStatement(sql);
			st.setInt(1,lastNo);
			st.setInt(2,startNo);
			rs = st.executeQuery();
			while(rs.next()) {
				ReportDTO dto = new ReportDTO();
				dto.setReport_num(rs.getInt("report_num"));
				dto.setReport_count(rs.getInt("report_count"));
				dto.setReport_content(rs.getString("report_content"));
				dto.setMem_id_reported(rs.getString("mem_id_reported"));
				dto.setMem_id_report(rs.getString("mem_id_report"));
				dto.setReport_title(rs.getString("report_title"));
				dto.setReport_cause(rs.getString("report_cause"));
				dto.setReport_image(rs.getString("report_image"));
				dto.setMem_name_reported(rs.getString("mem_name_reported"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return list;
	}
	public String findid(String admin_name, String admin_phone) {
		String result = "";
		openConn();
		try {
			sql = "select * from admin_member where admin_name = ? and admin_phone = ?";
			st = con.prepareStatement(sql);
			st.setString(1,admin_name);
			st.setString(2,admin_phone);
			rs = st.executeQuery();
			result += "<results>";
			result += "<aaa>";
			if(rs.next()) {
				result += "<result>" + rs.getInt(1) + "</result>";
			}else {
				result += "<result>none</result>";
			}
			result += "</aaa>";
			result += "</results>";
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public String admin_info(String admin_name , String admin_phone) {
		String info = "";
		openConn();
		try {
			sql = "select * from admin_member where admin_name = ? and admin_phone = ?";
			st = con.prepareStatement(sql);
			st.setString(1,admin_name);
			st.setString(2,admin_phone);
			rs = st.executeQuery();
			info +="<member_info>";
			while(rs.next()) {
				info +="<member_email>";
				info +="<admin_id>" + rs.getString("admin_id") + "</admin_id>";
				info +="<admin_email>" + rs.getString("admin_email") + "</admin_email>";
				info +="<admin_name>" + rs.getString("admin_name") + "</admin_name>";
				info += "</member_email>";
			}
			info +="</member_info>";
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return info;
	}
	public int checkid(String admin_id) {
		int result = 0;
		openConn();
		try {
			sql = "select * from admin_member where admin_id = ?";
			st = con.prepareStatement(sql);
			st.setString(1, admin_id);
			rs = st.executeQuery();
			if(rs.next()) {
				result = 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
		
	}
	public String getMemberEmail(String id) {
		String result = "";
		openConn();
		try {
			sql = "select admin_email from admin_member where admin_id = ?";
			st = con.prepareStatement(sql);
			st.setString(1,id);
			rs = st.executeQuery();
			if(rs.next()) {
				result = rs.getString("admin_email");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public int updateAdminPwd(String admin_pwd, String mem_id) {
		openConn();
		int result = 0;
		try {
			sql = "update admin_member set admin_pwd = ? where admin_id = ?";
			st = con.prepareStatement(sql);
			st.setString(1,admin_pwd);
			st.setString(2,mem_id);
			result = st.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
}
