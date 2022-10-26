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

import com.chall.model.UserDTO;

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
}
