package com.report.model;

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

public class ReportDAO {
	Connection con = null;
	PreparedStatement st = null;
	ResultSet rs = null;
	String sql = null;

	private static ReportDAO instance;
	private ReportDAO() {  }  // 기본 생성자
	public static ReportDAO getInstance() {

		if(instance == null) {
			instance = new ReportDAO();
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
	public List<ReportDTO> getReportContent(String mem_id) {
		List<ReportDTO> list = new ArrayList<ReportDTO>();
		openConn();
		try {
			sql = "select * from member_report where mem_id_reported = ?";
			st = con.prepareStatement(sql);
			st.setString(1,mem_id);
			rs = st.executeQuery();
			while(rs.next()) {
				ReportDTO dto = new ReportDTO();
				dto.setReport_num(rs.getInt("report_num"));
				dto.setReport_count(rs.getInt("report_count"));
				dto.setReport_content(rs.getString("report_content"));
				dto.setChall_title(rs.getString("chall_title"));
				dto.setMem_id_report(rs.getString("mem_id_report"));
				dto.setMem_id_reported(rs.getString("mem_id_reported"));
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
