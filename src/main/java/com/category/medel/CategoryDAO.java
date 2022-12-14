package com.category.medel;

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

public class CategoryDAO {
	Connection con = null;
	PreparedStatement st = null;
	ResultSet rs = null;
	String sql = null;

	private static CategoryDAO instance;
	private CategoryDAO() {  }  // 기본 생성자
	public static CategoryDAO getInstance() {

		if(instance == null) {
			instance = new CategoryDAO();
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
	public List<CategoryDTO> getCategoryList() {
		openConn();
		List<CategoryDTO> list = new ArrayList<CategoryDTO>();
		try {
			sql = "select * from challenge_category order by category_name";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			while(rs.next()) {
				CategoryDTO dto = new CategoryDTO();
				dto.setCategory_num(rs.getInt("category_num"));
				dto.setCategory_code(rs.getString("category_code"));
				dto.setCategory_name(rs.getString("category_name"));
				dto.setCategory_image(rs.getString("category_image"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return list;
	}
	public int deletecategory(int category_num) {
		int result = 0;
		openConn();
		try {
			sql = "delete from challenge_category where category_num = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,category_num);
			result = st.executeUpdate();
			sql = "update challenge_category set category_num = category_num - 1 where category_num > ?";
			st = con.prepareStatement(sql);
			st.setInt(1,category_num);
			st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public int insertCategory(CategoryDTO dto) {
		int result = 0 , count = 0;
		openConn();
		try {
			sql = "select max(category_num) from challenge_category";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}
			sql = "insert into challenge_category values(?,?,?,?)";
			st = con.prepareStatement(sql);
			st.setInt(1,count);
			st.setString(2,dto.getCategory_code());
			st.setString(3,dto.getCategory_name());
			st.setString(4,dto.getCategory_image());
			result = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public CategoryDTO getCategoryContent(int category_num) {
		CategoryDTO dto = null;
		openConn();
		try {
			sql = "select * from challenge_category where category_num = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,category_num);
			rs = st.executeQuery();
			if(rs.next()) {
				dto = new CategoryDTO();
				dto.setCategory_num(rs.getInt("category_num"));
				dto.setCategory_code(rs.getString("category_code"));
				dto.setCategory_name(rs.getString("category_name"));
				dto.setCategory_image(rs.getString("category_image"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return dto;
	}
	public int CategoryModify(CategoryDTO dto) {
		int result = 0;
		openConn();
		if(dto.getCategory_image() == null) {
			try {
				sql = "update challenge_category set category_code = ? , category_name = ? where category_num = ? ";
				st = con.prepareStatement(sql);
				st.setString(1,dto.getCategory_code());
				st.setString(2,dto.getCategory_name());
				st.setInt(3,dto.getCategory_num());
				result = st.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				closeConn(rs, st, con);
			}
		} else {
			try {
				sql = "update challenge_category set category_code = ? , category_name = ?, category_image = ? where category_num = ? ";
				st = con.prepareStatement(sql);
				st.setString(1,dto.getCategory_code());
				st.setString(2,dto.getCategory_name());
				st.setString(3,dto.getCategory_image());
				st.setInt(4,dto.getCategory_num());
				result = st.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				closeConn(rs, st, con);
			}
		}
		return result;
	}
	public String getSubList(int category_num) {
		String result = "";
		openConn();
		try {
			sql = "select * from challenge_category_sub where category_num = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,category_num);
			rs = st.executeQuery();
			result += "<subs>";
			while(rs.next()) {
				result += "<sub>";
				result += "<sub_category_num>" + rs.getInt("sub_category_num") + "</sub_category_num>";
				result += "<sub_category_name>" + rs.getString("sub_category_name") + "</sub_category_name>";
				result += "<category_num>" + rs.getInt("category_num") + "</category_num>";
				result += "</sub>";
			}
			result += "</subs>";
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public List<SubDTO> getsub_list(int category_num) {
		List<SubDTO> list = new ArrayList<SubDTO>();
		openConn();
		sql = "select * from challenge_category_sub where category_num = ?";
		try {
			st = con.prepareStatement(sql);
			st.setInt(1,category_num);
			rs = st.executeQuery();
			while(rs.next()) {
				SubDTO dto = new SubDTO();
				dto.setCategory_num(rs.getInt("category_num"));
				dto.setSub_category_name(rs.getString("sub_category_name"));
				dto.setSub_category_num(rs.getInt("sub_category_num"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	public void subCategoryModify(String name, String input) {
		openConn();
		sql = "update challenge_category_sub set sub_category_name = ? where sub_category_name = ?";
		try {
			st = con.prepareStatement(sql);
			st.setString(1,input);
			st.setString(2,name);
			st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
	}
	public void deleteSub(String sub_category) {
		openConn();
		int count = 0;
		try {
			sql = "delete from challenge_category_sub where sub_category_name = ?";
			st = con.prepareStatement(sql);
			st.setString(1,sub_category);
			st.executeUpdate();
			
			sql = "select sub_category_num from challenge_category_sub where sub_category_name = ?";
			st = con.prepareStatement(sql);
			st.setString(1, sub_category);
			rs = st.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			sql = "update challenge_category_sub set sub_category_num = sub_category_num - 1 where sub_category_num > ?";
			st = con.prepareStatement(sql);
			st.setInt(1,count);
			st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
	}
	public void insertSub(int category_num, String sub_category_input) {
		openConn();
		int count = 0;
		try {
			sql = "select max(sub_category_num) from challenge_category_sub";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}
			sql = "insert into challenge_category_sub values(?,?,?)";
			st = con.prepareStatement(sql);
			st.setInt(1,count);
			st.setString(2,sub_category_input);
			st.setInt(3,category_num);
			st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
	}
}
