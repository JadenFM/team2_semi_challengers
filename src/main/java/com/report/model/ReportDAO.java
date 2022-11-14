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

import com.chall.controller.OjdbcUrl;


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
	
	OjdbcUrl oju = new OjdbcUrl();

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
	public int getTotalRecord_search(String search) {
		openConn();
		int result = 0;
		try {
			sql = "select count(*) from member_report where mem_id_reported = ? or mem_name_reported = ? ";
			st = con.prepareStatement(sql);
			st.setString(1,search);
			st.setString(2,search);
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
		openConn();
		String result = "";
		sql = "select * from (select rownum as rnum , a.* from (select * from member_report where mem_id_reported = ? or mem_name_reported = ? or mem_id_report = ? order by report_num desc) a where rownum <= ?) where rnum >= ?";
		try {
			st = con.prepareStatement(sql);
			st.setString(1,search);
			st.setString(2,search);
			st.setString(3,search);
			st.setInt(4, lastNo);
			st.setInt(5,startNo);
			rs = st.executeQuery();
			result += "<reports>";
			while(rs.next()) {
				result +="<report>";
				result +="<report_num>"+rs.getInt("report_num")+"</report_num>";
				result +="<report_title>"+rs.getString("report_title")+"</report_title>";
				result +="<mem_id_report>"+rs.getString("mem_id_report")+"</mem_id_report>";
				if(rs.getString("mem_id_reported") != null) {
					result +="<mem_id_reported>"+rs.getString("mem_id_reported")+"</mem_id_reported>";
				}else if(rs.getString("mem_name_reported")!= null) {
					result +="<mem_name_reported>"+rs.getString("mem_name_reported")+"</mem_name_reported>";
				}
				result +="<report_cause>"+rs.getString("report_cause")+"</report_cause>";
				result +="<report_image>"+rs.getString("report_image")+"</report_image>";
				result +="</report>";
			}
			result += "</reports>";			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public void deleteReport(String mem_id, String mem_name) {
		openConn();
		try {
			sql = "delete from member_report where mem_id_reported = ? or mem_name_reported = ?";
			st = con.prepareStatement(sql);
			st.setString(1, mem_id);
			st.setString(2, mem_name);
			st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
	}
}



