package com.question.model;

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

import com.FAQ.model.FAQDTO;
import com.user.model.UserDTO;

public class QuestionDAO {
	Connection con = null;
	PreparedStatement st = null;
	ResultSet rs = null;
	String sql = null;

	private static QuestionDAO instance;
	private QuestionDAO() {  }  // 기본 생성자
	public static QuestionDAO getInstance() {

		if(instance == null) {
			instance = new QuestionDAO();
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
	public List<QuestionDTO> getQuestionList(int startNo, int lastNo) {
		List<QuestionDTO> list = new ArrayList<QuestionDTO>();
		openConn();
		try {
			sql = "select * from (select rownum as rnum , a.* from (select * from private_q order by p_q_num desc)a where rownum <= ? ) where rnum >= ? ";
			st = con.prepareStatement(sql);
			st.setInt(1,lastNo);
			st.setInt(2,startNo);
			rs = st.executeQuery();
			while(rs.next()) {
				QuestionDTO dto = new QuestionDTO();
				dto.setP_q_num(rs.getInt("p_q_num"));
				dto.setP_q_chall_num(rs.getInt("p_q_chall_num"));
				dto.setP_q_title(rs.getString("p_q_title"));
				dto.setP_q_content(rs.getString("p_q_content"));
				dto.setP_q_category_num(rs.getInt("p_q_category_num"));
				dto.setP_q_regdate(rs.getString("p_q_regdate"));
				dto.setP_q_answer_cont(rs.getString("p_q_answer_cont"));
				dto.setP_q_answer_regdate(rs.getString("p_q_answer_regdate"));
				dto.setP_q_again_num(rs.getInt("p_q_again_num"));
				dto.setP_q_answer_num(rs.getInt("p_q_answer_num"));
				dto.setP_q_user_num(rs.getInt("p_q_user_num"));
				dto.setP_q_check(rs.getInt("p_q_check"));
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
			sql = "select count(*) from private_q";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	public int gettotalrecord_check_O() {
		int result = 0;
		openConn();
		try {
			sql = "select count(*) from private_q where p_q_answer_cont is not null";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	public int gettotalrecord_check_X() {
		int result = 0;
		openConn();
		try {
			sql = "select count(*) from private_q where p_q_answer_cont is null";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	public QuestionDTO getQuestionContent(int p_q_num) {
		QuestionDTO dto = null;
		openConn();
		try {
			sql = "select * from private_q where p_q_num = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,p_q_num);
			rs = st.executeQuery();
			if(rs.next()) {
				dto = new QuestionDTO();
				dto.setP_q_num(rs.getInt("p_q_num"));
				dto.setP_q_chall_num(rs.getInt("p_q_chall_num"));
				dto.setP_q_title(rs.getString("p_q_title"));
				dto.setP_q_content(rs.getString("p_q_content"));
				dto.setP_q_category_num(rs.getInt("p_q_category_num"));
				dto.setP_q_regdate(rs.getString("p_q_regdate"));
				dto.setP_q_answer_cont(rs.getString("p_q_answer_cont"));
				dto.setP_q_answer_regdate(rs.getString("p_q_answer_regdate"));
				dto.setP_q_again_num(rs.getInt("p_q_again_num"));
				dto.setP_q_answer_num(rs.getInt("p_q_answer_num"));
				dto.setP_q_user_num(rs.getInt("p_q_user_num"));
				dto.setP_q_check(rs.getInt("p_q_check"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return dto;
	}
	public int writeanswer(QuestionDTO dto) {
		int result = 0;
		int check = 1;
		openConn();
		try {
			sql = "update private_q set p_q_answer_num = p_q_answer_num + 1 , p_q_answer_cont = ? , p_q_check = ? , p_q_answer_regdate = sysdate where p_q_num = ?";
			st = con.prepareStatement(sql);
			st.setString(1, dto.getP_q_answer_cont());
			st.setInt(2,check);
			st.setInt(3,dto.getP_q_num());
			result = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public QuestionDTO getQuestionByMem_num(int mem_num, int p_q_check) {
		QuestionDTO dto = null;
		openConn();
		try {
			sql = "select * from private_q where p_q_user_num = ? and p_q_check = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,mem_num);
			st.setInt(2,p_q_check);
			rs = st.executeQuery();
			if(rs.next()) {
				dto = new QuestionDTO();
				dto.setP_q_num(rs.getInt("p_q_num"));
				dto.setP_q_chall_num(rs.getInt("p_q_chall_num"));
				dto.setP_q_title(rs.getString("p_q_title"));
				dto.setP_q_content(rs.getString("p_q_content"));
				dto.setP_q_category_num(rs.getInt("p_q_category_num"));
				dto.setP_q_regdate(rs.getString("p_q_regdate"));
				dto.setP_q_answer_cont(rs.getString("p_q_answer_cont"));
				dto.setP_q_answer_regdate(rs.getString("p_q_answer_regdate"));
				dto.setP_q_again_num(rs.getInt("p_q_again_num"));
				dto.setP_q_answer_num(rs.getInt("p_q_answer_num"));
				dto.setP_q_user_num(rs.getInt("p_q_user_num"));
				dto.setP_q_check(rs.getInt("p_q_check"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return dto;
	}
	public List<QuestionDTO> getAnswerCheck(int mem_num) {
		List<QuestionDTO> list = new ArrayList<QuestionDTO>();
		int result = 0;
		openConn();
		try {
			sql = "select p_q_check from private_q where p_q_user_num = ? and p_q_check = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,mem_num);
			st.setInt(2,1);
			rs = st.executeQuery();
			while(rs.next()) {
				QuestionDTO dto = new QuestionDTO();
				dto.setP_q_check(rs.getInt("p_q_check"));
				System.out.println(dto.getP_q_check());
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return list;
	}
	public int updateAnswerCheck(int p_q_num) {
		int result = 0 , check = 0;
		openConn();
		try {
			sql = "update private_q set p_q_check = ? where p_q_num = ?";
			st = con.prepareStatement(sql);
			st.setInt(1,check);
			st.setInt(2,p_q_num);
			result = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return result;
	}
	public List<QuestionDTO> getAnswerCheckO(int startNo, int lastNo) {
		List<QuestionDTO> list = new ArrayList<QuestionDTO>();
		openConn();
		try {
			sql = "select * from (select rownum as rnum , a.* from (select * from private_q where p_q_answer_cont is not null order by p_q_num desc) a where rownum <= ?) where rnum >= ?";
			st = con.prepareStatement(sql);
			st.setInt(1,lastNo);
			st.setInt(2,startNo);
			rs = st.executeQuery();
			while(rs.next()) {
				QuestionDTO dto = new QuestionDTO();
				dto.setP_q_num(rs.getInt("p_q_num"));
				dto.setP_q_chall_num(rs.getInt("p_q_chall_num"));
				dto.setP_q_title(rs.getString("p_q_title"));
				dto.setP_q_content(rs.getString("p_q_content"));
				dto.setP_q_category_num(rs.getInt("p_q_category_num"));
				dto.setP_q_regdate(rs.getString("p_q_regdate"));
				dto.setP_q_answer_cont(rs.getString("p_q_answer_cont"));
				dto.setP_q_answer_regdate(rs.getString("p_q_answer_regdate"));
				dto.setP_q_again_num(rs.getInt("p_q_again_num"));
				dto.setP_q_answer_num(rs.getInt("p_q_answer_num"));
				dto.setP_q_user_num(rs.getInt("p_q_user_num"));
				dto.setP_q_check(rs.getInt("p_q_check"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, st, con);
		}
		return list;
	}
	public List<QuestionDTO> getAnswerCheckX(int startNo, int lastNo) {
		List<QuestionDTO> list = new ArrayList<QuestionDTO>();
		openConn();
		try {
			sql = "select * from (select rownum as rnum , a.* from (select * from private_q where p_q_answer_cont is null order by p_q_num desc) a where rownum <= ?) where rnum >= ?";
			st = con.prepareStatement(sql);
			st.setInt(1,lastNo);
			st.setInt(2,startNo);
			rs = st.executeQuery();
			while(rs.next()) {
				QuestionDTO dto = new QuestionDTO();
				dto.setP_q_num(rs.getInt("p_q_num"));
				dto.setP_q_chall_num(rs.getInt("p_q_chall_num"));
				dto.setP_q_title(rs.getString("p_q_title"));
				dto.setP_q_content(rs.getString("p_q_content"));
				dto.setP_q_category_num(rs.getInt("p_q_category_num"));
				dto.setP_q_regdate(rs.getString("p_q_regdate"));
				dto.setP_q_answer_cont(rs.getString("p_q_answer_cont"));
				dto.setP_q_answer_regdate(rs.getString("p_q_answer_regdate"));
				dto.setP_q_again_num(rs.getInt("p_q_again_num"));
				dto.setP_q_answer_num(rs.getInt("p_q_answer_num"));
				dto.setP_q_user_num(rs.getInt("p_q_user_num"));
				dto.setP_q_check(rs.getInt("p_q_check"));
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
			sql = "select count(*) from private_q where p_q_title like ?";
			st = con.prepareStatement(sql);
			st.setString(1, "%"+search+"%");
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
	public String findout(String search , int startNo , int lastNo) {
		String result = "";
		openConn();
		try {
			sql = "select * from (select rownum as rnum , a.* from (select * from private_q where p_q_title like ? order by p_q_num desc) a where rownum <= ?) where rnum >= ? ";
			st = con.prepareStatement(sql);
			st.setString(1,"%"+search+"%");
			st.setInt(2,lastNo);
			st.setInt(3,startNo);
			rs = st.executeQuery();
			result += "<questions>";
			while(rs.next()) {
				result += "<question>";
				result += "<p_q_num>" + rs.getInt("p_q_num") + "</p_q_num>";
				result += "<p_q_chall_num>" + rs.getInt("p_q_chall_num") + "</p_q_chall_num>";
				result += "<p_q_title>" + rs.getString("p_q_title") + "</p_q_title>"; 
				result += "<p_q_content>" + rs.getString("p_q_content") + "</p_q_content>";
				result += "<p_q_category_num>" + rs.getInt("p_q_category_num") + "</p_q_category_num>";
				result += "<p_q_regdate>" + rs.getString("p_q_regdate") + "</p_q_regdate>";
				result += "<p_q_answer_cont>" + rs.getString("p_q_answer_cont") + "</p_q_answer_cont>";
				result += "<p_q_asnwer_regdate>" + rs.getString("p_q_answer_regdate") + "</p_q_answer_regdate>";
				result += "<p_q_again_num>" + rs.getInt("p_q_again_num") + "</p_q_again_num>";
				result += "<p_q_answer_num>" + rs.getInt("p_q_answer_num") + "</p_q_asnwer_num>";
				result += "<p_q_user_num>" + rs.getInt("p_q_user_num") + "</p_q_user_num>";
				result += "<p_q_check>" + rs.getInt("p_q_check") + "</p_q_check>";
				result += "</question>";
			}
			result += "</questions>";
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
}