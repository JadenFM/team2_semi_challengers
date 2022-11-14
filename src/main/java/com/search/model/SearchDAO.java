package com.search.model;

import java.awt.RadialGradientPaint;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.category.medel.CategoryDTO;
import com.chall.controller.OjdbcUrl;
import com.sun.jdi.connect.spi.TransportService.ListenKey;
import com.sun.mail.handlers.image_gif;
import com.user.model.UserDTO;

public class SearchDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	private static SearchDAO instance;

	private SearchDAO() {
	}

	public static SearchDAO getinstance() {
		if (instance == null) {
			instance = new SearchDAO();
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

		} catch (Exception e) {
			e.printStackTrace();
		}
	} // openConn() END

// 사용한 자원을 반환하는 메서드
	public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {

		try {

			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // closeConn() END

	// DB에 연결하여 challenge_category 테이블의 값을 가져올 수 있는지 테스트하는 메서드

	public String getChallList(int page) {
		
		String result = "";
		String name = "";
		String mem_img = "";
		
		int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);

		List<UserDTO> list = new ArrayList<UserDTO>();

		try {
			openConn();
			
			sql = "select * from user_member";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				UserDTO dto = new UserDTO();
				
				dto.setMem_num(rs.getInt("MEM_NUM"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_img(rs.getString("mem_img"));
				list.add(dto);
			}

			/* sql = "select * from challenge_list order by chall_num desc"; */
			sql = "select * from (select row_number() over (order by chall_num desc) rnum, b.* from challenge_list b) where rnum >= ? and rnum <= ?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

			rs = pstmt.executeQuery();

			result += "<chall_lists>";

			while (rs.next()) {
				
				if(rs.getInt("CHALL_CREATER_NUM") == 0) {
					mem_img = "admin_logo.svg";
					name = "공식 챌린지";
				}else {
					
					for(int i=0; i<list.size(); i++) {
						UserDTO dto = list.get(i);
						if(dto.getMem_num() == rs.getInt("CHALL_CREATER_NUM")) {
							name = dto.getMem_name();
							mem_img = dto.getMem_img();
						}
					}
				}

				result += "<chall_list>";
				result += "<chall_open>" +rs.getString("chall_open") +"</chall_open>";
				result += "<chall_num>" +rs.getInt("chall_num") +"</chall_num>";
				result += "<chall_title>" +rs.getString("chall_title") +"</chall_title>";
				result += "<chall_mainimage>" +rs.getString("chall_mainimage")+ "</chall_mainimage>";
				result += "<chall_cycle>" +rs.getString("chall_cycle")+ "</chall_cycle>";
				result += "<chall_duration>" +rs.getString("chall_duration")+ "</chall_duration>";
				result += "<chall_startdate>" +rs.getString("chall_startdate")+ "</chall_startdate>";
				result += "<chall_guide>" +rs.getString("chall_guide")+ "</chall_guide>";
				result += "<chall_successimage>" +rs.getString("chall_successimage")+ "</chall_successimage>";
				result += "<chall_failimage>" +rs.getString("chall_failimage")+ "</chall_failimage>";
				result += "<chall_regitimestart>" +rs.getString("chall_regitimestart")+ "</chall_regitimestart>";
				result += "<chall_regitimeend>" +rs.getString("chall_regitimeend")+ "</chall_regitimeend>";
				result += "<chall_cont>" +rs.getString("chall_cont")+ "</chall_cont>";
				result += "<chall_depositdefault>" +rs.getInt("chall_depositdefault")+ "</chall_depositdefault>";
				result += "<chall_depositmax>" +rs.getInt("chall_depositmax")+ "</chall_depositmax>";
				result += "<chall_maxpeople>" +rs.getInt("chall_maxpeople")+ "</chall_maxpeople>";
				result += "<chall_category_num>" +rs.getString("chall_category_code_fk")+ "</chall_category_num_fk>";
				result += "<chall_keyword1>" +rs.getString("chall_keyword1")+ "</chall_keyword1>";
				result += "<chall_admin_id>" +rs.getString("admin_id_fk")+ "</chall_admin_id>";
				result += "<chall_ongoingpeople>" +rs.getInt("chall_ongoingpeople")+ "</chall_ongoingpeople>";
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
				result += "<chall_creater_img>" +mem_img+ "</chall_creater_img>";
				result += "</chall_list>";
				 
			}
			result += "</chall_lists>";
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return result;
	}
	
	
	public String getSearchKeyList(String keyword, int page) {
		
		String result="";
		String name = "";
		String mem_img = "";
		int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<UserDTO> list = new ArrayList<UserDTO>();
		List<KeywordDTO> listKey = new ArrayList<KeywordDTO>();
		
		try {
			openConn();
			
			sql = "select * from user_member";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				UserDTO dto = new UserDTO();
				
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_img(rs.getString("mem_img"));
				list.add(dto);
			}
			
			sql = "select * from challenge_keyword";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				
				KeywordDTO dto = new KeywordDTO();
				
				dto.setKeyword_name(rs.getString("keyword_name"));
				dto.setKeyword_count(rs.getInt("keyword_count"));
				dto.setKeyword_code(rs.getString("keyword_code"));
				
				listKey.add(dto);
			}
			
			
			
			sql = "select * from (select row_number() over (order by chall_num desc) rnum, b.* from challenge_list b  where chall_title like ? or chall_keyword1 = ? or chall_keyword2 = ? or chall_keyword3 = ?) where rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%" +keyword+ "%");
			pstmt.setString(2, keyword);
			pstmt.setString(3, keyword);
			pstmt.setString(4, keyword);
			pstmt.setInt(5, startNo);
			pstmt.setInt(6, endNo);
			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				
				for(int i=0; i<listKey.size(); i++) {
					
					KeywordDTO dto = listKey.get(i);
					int count = dto.getKeyword_count();
					if(dto.getKeyword_name().equals(rs.getString("chall_keyword1"))
						|| dto.getKeyword_name().equals(rs.getString("chall_keyword2"))
						|| dto.getKeyword_name().equals(rs.getString("chall_keyword3"))){
						
						count +=1;
						
						sql = "update challenge_keyword set keyword_count= ? where keyword_code = ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setInt(1, count);
						pstmt.setString(2, dto.getKeyword_code());
						
						pstmt.executeUpdate();
					}
				}
				
				
				if(rs.getInt("CHALL_CREATER_NUM") == 0) {
					mem_img = "admin_logo.svg";
					name = "공식 챌린지";
				}else {
					
					for(int i=0; i<list.size(); i++) {
						UserDTO dto = list.get(i);
						if(dto.getMem_num() == rs.getInt("CHALL_CREATER_NUM")) {
							name = dto.getMem_name();
							mem_img = dto.getMem_img();
						}
					}
				}
				
				result += "<chall_list>";
				result += "<chall_open>" +rs.getString("chall_open") +"</chall_open>";
				result += "<chall_num>" +rs.getInt("chall_num") +"</chall_num>";
				result += "<chall_title>" +rs.getString("chall_title") +"</chall_title>";
				result += "<chall_mainimage>" +rs.getString("chall_mainimage")+ "</chall_mainimage>";
				result += "<chall_cycle>" +rs.getString("chall_cycle")+ "</chall_cycle>";
				result += "<chall_duration>" +rs.getString("chall_duration")+ "</chall_duration>";
				result += "<chall_startdate>" +rs.getString("chall_startdate")+ "</chall_startdate>";
				result += "<chall_guide>" +rs.getString("chall_guide")+ "</chall_guide>";
				result += "<chall_successimage>" +rs.getString("chall_successimage")+ "</chall_successimage>";
				result += "<chall_failimage>" +rs.getString("chall_failimage")+ "</chall_failimage>";
				result += "<chall_regitimestart>" +rs.getString("chall_regitimestart")+ "</chall_regitimestart>";
				result += "<chall_regitimeend>" +rs.getString("chall_regitimeend")+ "</chall_regitimeend>";
				result += "<chall_cont>" +rs.getString("chall_cont")+ "</chall_cont>";
				result += "<chall_depositdefault>" +rs.getInt("chall_depositdefault")+ "</chall_depositdefault>";
				result += "<chall_depositmax>" +rs.getInt("chall_depositmax")+ "</chall_depositmax>";
				result += "<chall_maxpeople>" +rs.getInt("chall_maxpeople")+ "</chall_maxpeople>";
				result += "<chall_category_num>" +rs.getString("chall_category_code_fk")+ "</chall_category_num_fk>";
				result += "<chall_keyword1>" +rs.getString("chall_keyword1")+ "</chall_keyword1>";
				result += "<chall_admin_id>" +rs.getString("admin_id_fk")+ "</chall_admin_id>";
				result += "<chall_ongoingpeople>" +rs.getInt("chall_ongoingpeople")+ "</chall_ongoingpeople>";
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
				result += "<chall_creater_img>" +mem_img+ "</chall_creater_img>";
				result += "</chall_list>";
			}
			result += "</chall_lists>";
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		
		return result;
	}
	
	public String getSearchKeyList2(String keyword) {
		
		String result="";
		String name = "";
		String mem_img = "";
		
		
		List<UserDTO> list = new ArrayList<UserDTO>();
		
		try {
			openConn();
			
			sql = "select * from user_member";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				UserDTO dto = new UserDTO();
				
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_img(rs.getString("mem_img"));
				list.add(dto);
			}
			
			sql = "select * from challenge_list where chall_title like ? or chall_keyword1 = ? or chall_keyword2 = ? or chall_keyword3 = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%" +keyword+ "%");
			pstmt.setString(2, keyword);
			pstmt.setString(3, keyword);
			pstmt.setString(4, keyword);
			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				if(rs.getInt("CHALL_CREATER_NUM") == 0) {
					mem_img = "admin_logo.svg";
					name = "공식 챌린지";
				}else {
					
					for(int i=0; i<list.size(); i++) {
						UserDTO dto = list.get(i);
						if(dto.getMem_num() == rs.getInt("CHALL_CREATER_NUM")) {
							name = dto.getMem_name();
							mem_img = dto.getMem_img();
						}
					}
				}
				
				result += "<chall_list>";
				result += "<chall_open>" +rs.getString("chall_open") +"</chall_open>";
				result += "<chall_num>" +rs.getInt("chall_num") +"</chall_num>";
				result += "<chall_title>" +rs.getString("chall_title") +"</chall_title>";
				result += "<chall_mainimage>" +rs.getString("chall_mainimage")+ "</chall_mainimage>";
				result += "<chall_cycle>" +rs.getString("chall_cycle")+ "</chall_cycle>";
				result += "<chall_duration>" +rs.getString("chall_duration")+ "</chall_duration>";
				result += "<chall_startdate>" +rs.getString("chall_startdate")+ "</chall_startdate>";
				result += "<chall_guide>" +rs.getString("chall_guide")+ "</chall_guide>";
				result += "<chall_successimage>" +rs.getString("chall_successimage")+ "</chall_successimage>";
				result += "<chall_failimage>" +rs.getString("chall_failimage")+ "</chall_failimage>";
				result += "<chall_regitimestart>" +rs.getString("chall_regitimestart")+ "</chall_regitimestart>";
				result += "<chall_regitimeend>" +rs.getString("chall_regitimeend")+ "</chall_regitimeend>";
				result += "<chall_cont>" +rs.getString("chall_cont")+ "</chall_cont>";
				result += "<chall_depositdefault>" +rs.getInt("chall_depositdefault")+ "</chall_depositdefault>";
				result += "<chall_depositmax>" +rs.getInt("chall_depositmax")+ "</chall_depositmax>";
				result += "<chall_maxpeople>" +rs.getInt("chall_maxpeople")+ "</chall_maxpeople>";
				result += "<chall_category_num>" +rs.getString("chall_category_code_fk")+ "</chall_category_num_fk>";
				result += "<chall_keyword1>" +rs.getString("chall_keyword1")+ "</chall_keyword1>";
				result += "<chall_admin_id>" +rs.getString("admin_id_fk")+ "</chall_admin_id>";
				result += "<chall_ongoingpeople>" +rs.getInt("chall_ongoingpeople")+ "</chall_ongoingpeople>";
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
				result += "<chall_creater_img>" +mem_img+ "</chall_creater_img>";
				result += "</chall_list>";
			}
			result += "</chall_lists>";
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		
		return result;
	}
	
	public String getSearchCateList(String category, int page) {
		
		System.out.println("CateList 실행");
		String result="";
		String name = "";
		String mem_img = "";
		int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<UserDTO> list = new ArrayList<UserDTO>();
		
		try {
			openConn();
			
			sql = "select * from user_member";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				UserDTO dto = new UserDTO();
				
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_img(rs.getString("mem_img"));
				list.add(dto);
			}
			

			
			
			sql = "select * from challenge_list where chall_category_code_fk = ?";
			sql = "select * from (select row_number() over (order by chall_num desc) rnum, b.* from challenge_list b  where chall_category_code_fk = ?) where rnum >= ? and rnum <= ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, category);
			pstmt.setInt(2, startNo);
			pstmt.setInt(3, endNo);
			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				if(rs.getInt("CHALL_CREATER_NUM") == 0) {
					mem_img = "admin_logo.svg";
					name = "공식 챌린지";
				}else {
					
					for(int i=0; i<list.size(); i++) {
						UserDTO dto = list.get(i);
						if(dto.getMem_num() == rs.getInt("CHALL_CREATER_NUM")) {
							name = dto.getMem_name();
							mem_img = dto.getMem_img();
						}
					}
				}
				
				result += "<chall_list>";
				result += "<chall_open>" +rs.getString("chall_open") +"</chall_open>";
				result += "<chall_num>" +rs.getInt("chall_num") +"</chall_num>";
				result += "<chall_title>" +rs.getString("chall_title") +"</chall_title>";
				result += "<chall_mainimage>" +rs.getString("chall_mainimage")+ "</chall_mainimage>";
				result += "<chall_cycle>" +rs.getString("chall_cycle")+ "</chall_cycle>";
				result += "<chall_duration>" +rs.getString("chall_duration")+ "</chall_duration>";
				result += "<chall_startdate>" +rs.getString("chall_startdate")+ "</chall_startdate>";
				result += "<chall_guide>" +rs.getString("chall_guide")+ "</chall_guide>";
				result += "<chall_successimage>" +rs.getString("chall_successimage")+ "</chall_successimage>";
				result += "<chall_failimage>" +rs.getString("chall_failimage")+ "</chall_failimage>";
				result += "<chall_regitimestart>" +rs.getString("chall_regitimestart")+ "</chall_regitimestart>";
				result += "<chall_regitimeend>" +rs.getString("chall_regitimeend")+ "</chall_regitimeend>";
				result += "<chall_cont>" +rs.getString("chall_cont")+ "</chall_cont>";
				result += "<chall_depositdefault>" +rs.getInt("chall_depositdefault")+ "</chall_depositdefault>";
				result += "<chall_depositmax>" +rs.getInt("chall_depositmax")+ "</chall_depositmax>";
				result += "<chall_maxpeople>" +rs.getInt("chall_maxpeople")+ "</chall_maxpeople>";
				result += "<chall_category_num>" +rs.getString("chall_category_code_fk")+ "</chall_category_num_fk>";
				result += "<chall_keyword1>" +rs.getString("chall_keyword1")+ "</chall_keyword1>";
				result += "<chall_keyword2>" +rs.getString("chall_keyword2")+ "</chall_keyword2>";
				result += "<chall_keyword3>" +rs.getString("chall_keyword3")+ "</chall_keyword3>";
				result += "<chall_admin_id>" +rs.getString("admin_id_fk")+ "</chall_admin_id>";
				result += "<chall_ongoingpeople>" +rs.getInt("chall_ongoingpeople")+ "</chall_ongoingpeople>";
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
				result += "<chall_creater_img>" +mem_img+ "</chall_creater_img>";
				
				result += "</chall_list>";
			}
			result += "</chall_lists>";
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		
		return result;
	}

	public String getOptionList(String[] spOptionA, String[] spOptionB, String keyword, int page) {

		String result = "";
		String strA = "";
		String strB = "";
		int num = 0;
		int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		String name = "";
		String mem_img = "";
		List<UserDTO> list = new ArrayList<UserDTO>();
		
		try {
			openConn();
			
				for(int i=0; i<spOptionA.length-1; i++) {
					strA += "?,";
				}
				strA = strA.replaceAll(",$", "");
				
			
				for(int i=0; i<spOptionB.length-1; i++) {
					strB += "?,";
				}
				strB = strB.replaceAll(",$", "");
				
			
				/*
				 * sql = "select * from challenge_list where " +spOptionA[spOptionA.length-1]+
				 * " in(" +strA+ ") and " +spOptionB[spOptionB.length-1]+ " in(" +strB+
				 * ") and chall_title like ?";
				 */
				
				sql = "select * from (select row_number() over (order by chall_num desc) rnum, b.* from challenge_list b where " +spOptionA[spOptionA.length-1]+  " in(" +strA+ ") and " +spOptionB[spOptionB.length-1]+ " in(" +strB+ ") and chall_title like ?) where rnum >= ? and rnum <= ?";
				
				pstmt = con.prepareStatement(sql);
				
				
				for(int i=0; i<spOptionA.length-1; i++) {
					num +=1;
					System.out.println("num >>> " +num);
					pstmt.setString(num, spOptionA[i]);
				}
				
				for(int i=0; i<spOptionB.length-1; i++) {
					num +=1;
					pstmt.setString(num, spOptionB[i]);
				}
				
				pstmt.setString(num+1, "%" +keyword+ "%");
				pstmt.setInt(num+2, startNo);
				pstmt.setInt(num+3, endNo);

			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				if(rs.getInt("CHALL_CREATER_NUM") == 0) {
					mem_img = "admin_logo.svg";
					name = "공식 챌린지";
				}else {
					
					for(int i=0; i<list.size(); i++) {
						UserDTO dto = list.get(i);
						if(dto.getMem_num() == rs.getInt("CHALL_CREATER_NUM")) {
							name = dto.getMem_name();
							mem_img = dto.getMem_img();
						}
					}
				}
				
				result += "<chall_list>";
				result += "<chall_open>" +rs.getString("chall_open") +"</chall_open>";
				result += "<chall_num>" +rs.getInt("chall_num") +"</chall_num>";
				result += "<chall_title>" +rs.getString("chall_title") +"</chall_title>";
				result += "<chall_mainimage>" +rs.getString("chall_mainimage")+ "</chall_mainimage>";
				result += "<chall_cycle>" +rs.getString("chall_cycle")+ "</chall_cycle>";
				result += "<chall_duration>" +rs.getString("chall_duration")+ "</chall_duration>";
				result += "<chall_startdate>" +rs.getString("chall_startdate")+ "</chall_startdate>";
				result += "<chall_guide>" +rs.getString("chall_guide")+ "</chall_guide>";
				result += "<chall_successimage>" +rs.getString("chall_successimage")+ "</chall_successimage>";
				result += "<chall_failimage>" +rs.getString("chall_failimage")+ "</chall_failimage>";
				result += "<chall_regitimestart>" +rs.getString("chall_regitimestart")+ "</chall_regitimestart>";
				result += "<chall_regitimeend>" +rs.getString("chall_regitimeend")+ "</chall_regitimeend>";
				result += "<chall_cont>" +rs.getString("chall_cont")+ "</chall_cont>";
				result += "<chall_depositdefault>" +rs.getInt("chall_depositdefault")+ "</chall_depositdefault>";
				result += "<chall_depositmax>" +rs.getInt("chall_depositmax")+ "</chall_depositmax>";
				result += "<chall_maxpeople>" +rs.getInt("chall_maxpeople")+ "</chall_maxpeople>";
				result += "<chall_category_num>" +rs.getString("chall_category_code_fk")+ "</chall_category_num_fk>";
				result += "<chall_keyword1>" +rs.getString("chall_keyword1")+ "</chall_keyword1>";
				result += "<chall_admin_id>" +rs.getString("admin_id_fk")+ "</chall_admin_id>";
				result += "<chall_ongoingpeople>" +rs.getInt("chall_ongoingpeople")+ "</chall_ongoingpeople>";
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
				result += "<chall_creater_img>" +mem_img+ "</chall_creater_img>";
				result += "</chall_list>";
				
			}
			result += "</chall_lists>";
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}



	public String getOptionList(String[] spOption, String keyword, int page) {
		System.out.println("======인자 1개 옵션메서드 실행=======");
		
		for (int i=0; i<spOption.length; i++) {
		}
		
		String result = "";
		String str = "";
		
		String name = "";
		String mem_img = "";
		int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<UserDTO> list = new ArrayList<UserDTO>();
		int num = 0;
		
		try {
			openConn();
			
			sql = "select * from user_member";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				UserDTO dto = new UserDTO();
				
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_img(rs.getString("mem_img"));
				list.add(dto);
			}
			
			for(int i=0; i<spOption.length-1; i++) {
				str += "?,";
			}
			
			str = str.replaceAll(",$", "");
			
//			 sql = "select * from challenge_list where " +spOption[spOption.length-1]+" in(" +str+ ") and chall_title like ?";
			 
			
			sql = "select * from (select row_number() over (order by chall_num desc) rnum, b.* from challenge_list b  where " +spOption[spOption.length-1]+" in(" +str+ ") and chall_title like ?) where rnum >= ? and rnum <= ?";
			
			pstmt = con.prepareStatement(sql);
			
			
			
			for(int i=0; i<spOption.length-1; i++) {
				num +=1;
				pstmt.setString(num, spOption[i]);
			}
			
			pstmt.setString(num+1, "%" +keyword+ "%");
			pstmt.setInt(num+2, startNo);
			pstmt.setInt(num+3, endNo);
			
			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				if(rs.getInt("CHALL_CREATER_NUM") == 0) {
					mem_img = "admin_logo.svg";
					name = "공식 챌린지";
				}else {
					
					for(int i=0; i<list.size(); i++) {
						UserDTO dto = list.get(i);
						if(dto.getMem_num() == rs.getInt("CHALL_CREATER_NUM")) {
							name = dto.getMem_name();
							mem_img = dto.getMem_img();
						}
					}
				}
				
				result += "<chall_list>";
				result += "<chall_open>" +rs.getString("chall_open") +"</chall_open>";
				result += "<chall_num>" +rs.getInt("chall_num") +"</chall_num>";
				result += "<chall_title>" +rs.getString("chall_title") +"</chall_title>";
				result += "<chall_mainimage>" +rs.getString("chall_mainimage")+ "</chall_mainimage>";
				result += "<chall_cycle>" +rs.getString("chall_cycle")+ "</chall_cycle>";
				result += "<chall_duration>" +rs.getString("chall_duration")+ "</chall_duration>";
				result += "<chall_startdate>" +rs.getString("chall_startdate")+ "</chall_startdate>";
				result += "<chall_guide>" +rs.getString("chall_guide")+ "</chall_guide>";
				result += "<chall_successimage>" +rs.getString("chall_successimage")+ "</chall_successimage>";
				result += "<chall_failimage>" +rs.getString("chall_failimage")+ "</chall_failimage>";
				result += "<chall_regitimestart>" +rs.getString("chall_regitimestart")+ "</chall_regitimestart>";
				result += "<chall_regitimeend>" +rs.getString("chall_regitimeend")+ "</chall_regitimeend>";
				result += "<chall_cont>" +rs.getString("chall_cont")+ "</chall_cont>";
				result += "<chall_depositdefault>" +rs.getInt("chall_depositdefault")+ "</chall_depositdefault>";
				result += "<chall_depositmax>" +rs.getInt("chall_depositmax")+ "</chall_depositmax>";
				result += "<chall_maxpeople>" +rs.getInt("chall_maxpeople")+ "</chall_maxpeople>";
				result += "<chall_category_num>" +rs.getString("chall_category_code_fk")+ "</chall_category_num_fk>";
				result += "<chall_keyword1>" +rs.getString("chall_keyword1")+ "</chall_keyword1>";
				result += "<chall_admin_id>" +rs.getString("admin_id_fk")+ "</chall_admin_id>";
				result += "<chall_ongoingpeople>" +rs.getInt("chall_ongoingpeople")+ "</chall_ongoingpeople>";
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
				result += "<chall_creater_img>" +mem_img+ "</chall_creater_img>";
				result += "</chall_list>";
				
			}
			result += "</chall_lists>";
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}

	public String getOptionList(String[] spOptionA, String[] spOptionB, String[] spOptionC, String keyword, int page) {
		
		String result = "";
		String strA = "";
		String strB = "";
		String strC = "";
		int num = 0;
		String name = "";
		String mem_img = "";
		int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		
		List<UserDTO> list = new ArrayList<UserDTO>();
		
		try {
			openConn();
			
				for(int i=0; i<spOptionA.length-1; i++) {
					strA += "?,";
				}
				strA = strA.replaceAll(",$", "");
				
			
				for(int i=0; i<spOptionB.length-1; i++) {
					strB += "?,";
				}
				strB = strB.replaceAll(",$", "");
				
				
				for(int i=0; i<spOptionC.length-1; i++) {
					strC += "?,";
				}
				strC = strC.replaceAll(",$", "");
				
			
				/*
				 * sql = "select * from challenge_list where " +spOptionA[spOptionA.length-1]+
				 * " in(" +strA+ ") and " +spOptionB[spOptionB.length-1]+ " in(" +strB+ ") and "
				 * +spOptionC[spOptionC.length-1]+ " in(" +strC+ ") " +"and chall_title like ?";
				 */
				
				sql = "select * from (select row_number() over (order by chall_num desc) rnum, b.* from challenge_list b  where " +spOptionA[spOptionA.length-1]+  " in(" +strA+ ") and " +spOptionB[spOptionB.length-1]+ " in(" +strB+ ") and " +spOptionC[spOptionC.length-1]+ " in(" +strC+ ") " +"and chall_title like ?) where rnum >= ? and rnum <= ?";
				
				
				pstmt = con.prepareStatement(sql);
				
				
				for(int i=0; i<spOptionA.length-1; i++) {
					num +=1;
					pstmt.setString(num, spOptionA[i]);
				}
				
				for(int i=0; i<spOptionB.length-1; i++) {
					num +=1;
					pstmt.setString(num, spOptionB[i]);
				}
				
				for(int i=0; i<spOptionC.length-1; i++) {
					num +=1;
					pstmt.setString(num, spOptionC[i]);
				}
				
				pstmt.setString(num+1, "%" +keyword+ "%");
				pstmt.setInt(num+2, startNo);
				pstmt.setInt(num+3, endNo);

			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				if(rs.getInt("CHALL_CREATER_NUM") == 0) {
					mem_img = "admin_logo.svg";
					name = "공식 챌린지";
				}else {
					
					for(int i=0; i<list.size(); i++) {
						UserDTO dto = list.get(i);
						if(dto.getMem_num() == rs.getInt("CHALL_CREATER_NUM")) {
							name = dto.getMem_name();
							mem_img = dto.getMem_img();
						}
					}
				}
				
				result += "<chall_list>";
				result += "<chall_open>" +rs.getString("chall_open") +"</chall_open>";
				result += "<chall_num>" +rs.getInt("chall_num") +"</chall_num>";
				result += "<chall_title>" +rs.getString("chall_title") +"</chall_title>";
				result += "<chall_mainimage>" +rs.getString("chall_mainimage")+ "</chall_mainimage>";
				result += "<chall_cycle>" +rs.getString("chall_cycle")+ "</chall_cycle>";
				result += "<chall_duration>" +rs.getString("chall_duration")+ "</chall_duration>";
				result += "<chall_startdate>" +rs.getString("chall_startdate")+ "</chall_startdate>";
				result += "<chall_guide>" +rs.getString("chall_guide")+ "</chall_guide>";
				result += "<chall_successimage>" +rs.getString("chall_successimage")+ "</chall_successimage>";
				result += "<chall_failimage>" +rs.getString("chall_failimage")+ "</chall_failimage>";
				result += "<chall_regitimestart>" +rs.getString("chall_regitimestart")+ "</chall_regitimestart>";
				result += "<chall_regitimeend>" +rs.getString("chall_regitimeend")+ "</chall_regitimeend>";
				result += "<chall_cont>" +rs.getString("chall_cont")+ "</chall_cont>";
				result += "<chall_depositdefault>" +rs.getInt("chall_depositdefault")+ "</chall_depositdefault>";
				result += "<chall_depositmax>" +rs.getInt("chall_depositmax")+ "</chall_depositmax>";
				result += "<chall_maxpeople>" +rs.getInt("chall_maxpeople")+ "</chall_maxpeople>";
				result += "<chall_category_num>" +rs.getString("chall_category_code_fk")+ "</chall_category_num_fk>";
				result += "<chall_keyword1>" +rs.getString("chall_keyword1")+ "</chall_keyword1>";
				result += "<chall_admin_id>" +rs.getString("admin_id_fk")+ "</chall_admin_id>";
				result += "<chall_ongoingpeople>" +rs.getInt("chall_ongoingpeople")+ "</chall_ongoingpeople>";
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
				result += "<chall_creater_img>" +mem_img+ "</chall_creater_img>";
				result += "</chall_list>";
				
			}
			result += "</chall_lists>";
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	}

	public SearchDTO getContent(int num) {
		
		
		
		
		return null;
	}


}