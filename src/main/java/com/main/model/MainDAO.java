package com.main.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.category.medel.CategoryDTO;
import com.chall.controller.OjdbcUrl;
import com.user.model.UserDTO;

public class MainDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	private static MainDAO instance;

	private MainDAO() {
	}

	public static MainDAO getinstance() {
		if (instance == null) {
			instance = new MainDAO();
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


	public String getCategoryList() {

		String result = "";

		try {
			openConn();
			
			sql = "select * from challenge_category order by category_num desc";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			result += "<chall_lists>";

			while (rs.next()) {
				
				result += "<chall_list>";
				result += "<chall_category_code>" +rs.getString("category_code") +"</chall_category_code>";
				result += "<chall_category_name>" +rs.getString("category_name") +"</chall_category_name>";
				result += "<chall_category_image>" +rs.getString("category_image") +"</chall_category_image>";
				result += "<chall_category_num>" +rs.getString("category_num")+ "</chall_category_num>";
				result += "</chall_list>";
				 
			}
			result += "</chall_lists>";
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return result;
	} // getCategoryList() end
	

	public String getMostCategory() {
		
		String result = "";
		String name = "";
		String image = "";
		
		try {
			openConn();
			
			sql = "select * from challenge_category";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<CategoryDTO> list = new ArrayList<CategoryDTO>();
			
			while(rs.next()) {
				
				CategoryDTO dto = new CategoryDTO();
				dto.setCategory_code(rs.getString("CATEGORY_CODE"));
				dto.setCategory_image(rs.getString("category_image"));
				dto.setCategory_name(rs.getString("category_name"));
				
				list.add(dto);
			}
			
			sql = "select * from "
					+ "(select chall_category_code_fk, count(chall_category_code_fk) as most "
					+ "from challenge_list group by chall_category_code_fk order by most desc) "
					+ "where rownum<=5";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				
				for(int i=0; i<list.size(); i++) {
					CategoryDTO dto = list.get(i);
					if(dto.getCategory_code().equals(rs.getString("chall_category_code_fk"))) {
						
						name = dto.getCategory_name();
						image = dto.getCategory_image();
					}
				}
				
				
				result += "<chall_list>";
				result += "<chall_category_name>" +name+"</chall_category_name>";
				result += "<chall_category_image>" +image+"</chall_category_image>";
				result += "<chall_category_code>" +rs.getString("chall_category_code_fk")+"</chall_category_code>";
				result += "</chall_list>";
			}
			
			result += "</chall_lists>";
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		
		return result;
	}

	public String getMostKeyword() {
		
		String result = "";
		
		try {
			
			openConn();
			
			sql = "select * from (select * from challenge_keyword order by keyword_count desc) where rownum <= 10";
			
			pstmt = con.prepareStatement(sql);
			
			rs= pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()) {
				
				result += "<chall_list>";
				result += "<chall_keyword_name>" +rs.getString("keyword_name") +"</chall_keyword_name>";
				result += "<chall_keyword_code>" +rs.getString("keyword_code") +"</chall_keyword_code>";
				result += "</chall_list>";
				
			}
			result += "</chall_lists>";
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}

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

	public String getMostChall() {
		
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
			
			sql = "select * from challenge_list where rownum <= 4 order by chall_ongoingpeople desc";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()){
				
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
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		
		return result;
	}

	public String getAdminChall() {
		
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
			
			sql = "select * from challenge_list where chall_open ='admin' and chall_status = '진행중' and rownum <= 4 order by chall_ongoingpeople desc";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			result += "<chall_lists>";
			
			while(rs.next()){
				
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
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		
		return result;
	}





}