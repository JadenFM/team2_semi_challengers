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
		String url = "jdbc:oracle:thin:@projectchallengers_high?TNS_ADMIN=C:/NCS/downroad/apache-tomcat-9.0.65/Wallet_ProjectChallengers";
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
	public ReportDTO getReportContent(int report_num) {
		ReportDTO dto = null;
		openConn();
		try {
			sql = "select * from member_report where report_num = ? ";
			st = con.prepareStatement(sql);
			st.setInt(1,report_num);
			rs = st.executeQuery();
			if(rs.next()) {
				dto = new ReportDTO();
				dto.setReport_num(rs.getInt("report_num"));
				dto.setReport_count(rs.getInt("report_count"));
				dto.setReport_content(rs.getString("report_content"));
				dto.setMem_id_reported(rs.getString("mem_id_reported"));
				dto.setMem_id_report(rs.getString("mem_id_report"));
				dto.setReport_title(rs.getString("report_title"));
				dto.setReport_cause(rs.getString("report_cause"));
				dto.setReport_image(rs.getString("report_image"));
				dto.setMem_name_reported(rs.getString("mem_name_reported"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return dto;
	}
	public int insertReport(ReportDTO dto) {
		int result = 0 , count = 0 , report = 0;
		openConn();
		try {
			sql = "select max(report_num) from member_report";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}
			sql = "select report_count from member_report where mem_id_reported= ? or mem_name_reported = ?";
			st = con.prepareStatement(sql);
			st.setString(1,dto.getMem_id_reported());
			st.setString(2,dto.getMem_name_reported());
			rs = st.executeQuery();
			if(rs.next()) {
				report = rs.getInt(1)+1;
			}
			
			sql = "insert into member_report values(?,?,?,?,?,?,?,?,?)";
			st = con.prepareStatement(sql);
			st.setInt(1,count);
			st.setInt(2,report);
			st.setString(3,dto.getReport_content());
			if(dto.getMem_id_reported() == null){
				st.setString(4,"");
			}else {
				st.setString(4,dto.getMem_id_reported());
			}
			st.setString(5,dto.getMem_id_report());
			st.setString(6,dto.getReport_title());
			st.setString(7,dto.getReport_cause());
			st.setString(8,dto.getReport_image());
			if(dto.getMem_name_reported() == null) {
				st.setString(9,"");
			}else {
				st.setString(9,dto.getMem_name_reported());
			}
			result = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public int insertReport_noneImage(ReportDTO dto) {
		int result = 0 , count = 0 , report = 0;
		openConn();
		try {
			sql = "select max(report_num) from member_report";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}
			sql = "update member_report set report_count = report_count + 1 where mem_id_reported = ?";
			st = con.prepareStatement(sql);
			st.setString(1,dto.getMem_id_reported());
			sql = "update member_report set report_count = report_count + 1 where mem_name_reported = ?";
			st = con.prepareStatement(sql);
			st.setString(1,dto.getMem_name_reported());
			sql = "select report_count from member_report where mem_id_reported= ? or mem_name_reported = ?";
			st = con.prepareStatement(sql);
			st.setString(1,dto.getMem_id_reported());
			st.setString(2,dto.getMem_name_reported());
			rs = st.executeQuery();
			if(rs.next()) {
				report = rs.getInt(1)+1;
			}
			
			sql = "insert into member_report values(?,?,?,?,?,?,?,'',?)";
			st = con.prepareStatement(sql);
			st.setInt(1,count);
			st.setInt(2,report);
			st.setString(3,dto.getReport_content());
			if(dto.getMem_id_reported() == null){
				st.setString(4,"");
			}else {
				st.setString(4,dto.getMem_id_reported());
			}
			st.setString(5,dto.getMem_id_report());
			st.setString(6,dto.getReport_title());
			st.setString(7,dto.getReport_cause());
			if(dto.getMem_name_reported() == null) {
				st.setString(8,"");
			}else {
				st.setString(8,dto.getMem_name_reported());
			}
			result = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
}



