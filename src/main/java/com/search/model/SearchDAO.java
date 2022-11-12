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

// Connection을 가져오는 메서드
	public void openConn() {

		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@projectchallengers_high?TNS_ADMIN=C:/NCS/downroad/apache-tomcat-9.0.65/Wallet_ProjectChallengers";
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

	public String getChallList() {
		
		String result = "";
		String name = "";

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
				list.add(dto);
			}

			sql = "select * from challenge_list order by chall_num desc";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			result += "<chall_lists>";

			while (rs.next()) {
				
				for(int i=0; i<list.size(); i++) {
					UserDTO dto = list.get(i);
					if(dto.getMem_num() == rs.getInt("CHALL_CREATER_NUM")) {
						name = dto.getMem_name();
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
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
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
	
	
	public String getSearchKeyList(String keyword) {
		
		System.out.println("KeyList 실행");
		String result="";
		String name = "";

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
				list.add(dto);
			}
			
			sql = "select * from challenge_keyword";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				System.out.println("키워드 확인");
				
				KeywordDTO dto = new KeywordDTO();
				
				dto.setKeyword_name(rs.getString("keyword_name"));
				dto.setKeyword_count(rs.getInt("keyword_count"));
				dto.setKeyword_code(rs.getString("keyword_code"));
				
				listKey.add(dto);
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
				
				for(int i=0; i<list.size(); i++) {
					UserDTO dto = list.get(i);
					if(dto.getMem_num() == rs.getInt("chall_creater_num")) {
						name = dto.getMem_name();
					}
				}
				
				for(int i=0; i<listKey.size(); i++) {
					
					System.out.println("키워드 비교");
					KeywordDTO dto = listKey.get(i);
					int count = dto.getKeyword_count();
					if(dto.getKeyword_name().equals(rs.getString("chall_keyword1"))
						|| dto.getKeyword_name().equals(rs.getString("chall_keyword2"))
						|| dto.getKeyword_name().equals(rs.getString("chall_keyword3"))){
						
						System.out.println("if문 실행 완료>>> " +count);
						count +=1;
						
						System.out.println("count+1 >>> " +count);
						sql = "update challenge_keyword set keyword_count= ? where keyword_code = ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setInt(1, count);
						pstmt.setString(2, dto.getKeyword_code());
						
						pstmt.executeUpdate();
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
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";

				
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
		
		System.out.println("KeyList 실행");
		String result="";
		String name = "";
		
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
				list.add(dto);
			}
			
			sql = "select * from challenge_list where chall_title like ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%" +keyword+ "%");
			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				for(int i=0; i<list.size(); i++) {
					UserDTO dto = list.get(i);
					if(dto.getMem_num() == rs.getInt("chall_creater_num")) {
						name = dto.getMem_name();
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
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
				
				
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
	
	public String getSearchCateList(String category) {
		
		System.out.println("CateList 실행");
		String result="";
		String name = "";
		
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
				list.add(dto);
			}
			

			
			
			sql = "select * from challenge_list where chall_category_code_fk = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, category);
			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				for(int i=0; i<list.size(); i++) {
					UserDTO dto = list.get(i);
					if(dto.getMem_num() == rs.getInt("chall_creater_num")) {
						name = dto.getMem_name();
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
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
				
				
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

	public String getOptionList(String[] spOptionA, String[] spOptionB, String keyword) {

		System.out.println("인자2개 옵션 메서드 실행");
		String result = "";
		String strA = "";
		String strB = "";
		int num = 0;
		
		String name = "";
		List<UserDTO> list = new ArrayList<UserDTO>();
		
		try {
			openConn();
			
				for(int i=0; i<spOptionA.length-1; i++) {
					strA += "?,";
				}
				strA = strA.replaceAll(",$", "");
				
				System.out.println("strC >>> " +strA);
			
				for(int i=0; i<spOptionB.length-1; i++) {
					strB += "?,";
				}
				strB = strB.replaceAll(",$", "");
				
				System.out.println("strD >>> " +strB);
			
				sql = "select * from challenge_list where " +spOptionA[spOptionA.length-1]+ " in(" +strA+ ") and " +spOptionB[spOptionB.length-1]+ " in(" +strB+ ") and chall_title like ?";
				pstmt = con.prepareStatement(sql);
				
				System.out.println("sql >>> " +sql);
				
				for(int i=0; i<spOptionA.length-1; i++) {
					num +=1;
					System.out.println("num >>> " +num);
					pstmt.setString(num, spOptionA[i]);
				}
				
				for(int i=0; i<spOptionB.length-1; i++) {
					num +=1;
					System.out.println("D num >>> " +num);
					pstmt.setString(num, spOptionB[i]);
				}
				
				System.out.println("총합 num >>>" +num);
				pstmt.setString(num+1, "%" +keyword+ "%");
				

			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				for(int i=0; i<list.size(); i++) {
					UserDTO dto = list.get(i);
					if(dto.getMem_num() == rs.getInt("chall_creater_num")) {
						name = dto.getMem_name();
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
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
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



	public String getOptionList(String[] spOption, String keyword) {
		System.out.println("======인자 1개 옵션메서드 실행=======");
		
		for (int i=0; i<spOption.length; i++) {
			System.out.println("배열 >>> " +spOption[i]);
		}
		
		String result = "";
		String str = "";
		
		String name = "";
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
				list.add(dto);
			}
			
			for(int i=0; i<spOption.length-1; i++) {
				str += "?,";
			}
			
			str = str.replaceAll(",$", "");
			System.out.println("? 갯수 >>> " +str);
			System.out.println("마지막 값 >>> " +spOption[spOption.length-1]);

			sql = "select * from challenge_list where " +spOption[spOption.length-1]+" in(" +str+ ") and chall_title like ?";
			pstmt = con.prepareStatement(sql);
			
			for(int i=0; i<spOption.length-1; i++) {
				num +=1;
				System.out.println("num >>> " +num);
				pstmt.setString(num, spOption[i]);
				System.out.println("opton[i] >>>" +spOption[i]);
			}
			
			pstmt.setString(num+1, "%" +keyword+ "%");
			
			System.out.println("sql >>> " +sql);
			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				for(int i=0; i<list.size(); i++) {
					UserDTO dto = list.get(i);
					if(dto.getMem_num() == rs.getInt("chall_creater_num")) {
						name = dto.getMem_name();
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
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
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

	public String getOptionList(String[] spOptionA, String[] spOptionB, String[] spOptionC, String keyword) {
		
		System.out.println("인자3개 옵션 메서드 실행");
		String result = "";
		String strA = "";
		String strB = "";
		String strC = "";
		int num = 0;
		String name = "";
		List<UserDTO> list = new ArrayList<UserDTO>();
		
		try {
			openConn();
			
				for(int i=0; i<spOptionA.length-1; i++) {
					strA += "?,";
				}
				strA = strA.replaceAll(",$", "");
				
				System.out.println("strA >>> " +strA);
			
				for(int i=0; i<spOptionB.length-1; i++) {
					strB += "?,";
				}
				strB = strB.replaceAll(",$", "");
				
				System.out.println("strB >>> " +strB);
				
				for(int i=0; i<spOptionC.length-1; i++) {
					strC += "?,";
				}
				strC = strC.replaceAll(",$", "");
				
				System.out.println("strC >>> " +strC);
			
				sql = "select * from challenge_list where " +spOptionA[spOptionA.length-1]+ " in(" +strA+ ") and " +spOptionB[spOptionB.length-1]+ " in(" +strB+ ") and "
						+spOptionC[spOptionC.length-1]+ " in(" +strC+ ") " +"and chall_title like ?";
				pstmt = con.prepareStatement(sql);
				
				System.out.println("sql >>> " +sql);
				
				for(int i=0; i<spOptionA.length-1; i++) {
					num +=1;
					System.out.println("Anum >>> " +num);
					pstmt.setString(num, spOptionA[i]);
				}
				
				for(int i=0; i<spOptionB.length-1; i++) {
					num +=1;
					System.out.println("Bnum >>> " +num);
					pstmt.setString(num, spOptionB[i]);
				}
				
				for(int i=0; i<spOptionC.length-1; i++) {
					num +=1;
					System.out.println("Cnum >>> " +num);
					pstmt.setString(num, spOptionC[i]);
				}
				
				System.out.println("총합 num >>>" +num);
				pstmt.setString(num+1, "%" +keyword+ "%");
				

			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				for(int i=0; i<list.size(); i++) {
					UserDTO dto = list.get(i);
					if(dto.getMem_num() == rs.getInt("chall_creater_num")) {
						name = dto.getMem_name();
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
				result += "<chall_creater_name>" +name+ "</chall_creater_name>";
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