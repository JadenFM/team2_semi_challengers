package com.review.model;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.chall.controller.OjdbcUrl;


public class ReviewDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	private static ReviewDAO instance;
		
	private ReviewDAO() {} 
	
	public static ReviewDAO getinstance() {
		if(instance == null) {
			instance = new ReviewDAO();
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
	
		} catch(Exception e){
			e.printStackTrace();
		}
	} // openConn() END
	
	
// 사용한 자원을 반환하는 메서드
	public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {
	
		try {
	
			if (rs != null) { rs.close(); }
			if (pstmt != null) { pstmt.close(); }
			if (con != null) { con.close(); }
	
		}catch(SQLException e){
			e.printStackTrace();
		}
	} // closeConn() END
	
	
	public String getReviewListString() {
		
		String result = "";
		
		try {

			openConn();
			
			sql ="select json_object('review_num' value REVIEW_NUM, 'review_chall_num' value REVIEW_CHALL_NUM, 'review_mem_num'value REVIEW_MEM_NUM, 'review_content'value REVIEW_CONTENT, 'review_star'value REVIEW_STAR, 'review_regdate'value REVIEW_REGDATE) as json_result from review order by review_num desc";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			result += "[";
			while (rs.next()) {
				result += rs.getString("json_result")+",";
			}
			result = result.substring(0, result.length()-1);
			result += "]";
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
	
		return result;
	}	
	
	
	public List<ReviewDTO> getReviewList(int page, int rowsize) throws ParseException{
		
		List<ReviewDTO> list = new ArrayList<ReviewDTO>();
		String result = "";
		int startNo = (page * rowsize) - (rowsize -1 ); 
		int endNo = (page * rowsize);
		
		try {

			openConn();
			
			sql = "SELECT json_object('review_num' value REVIEW_NUM, "
					+ "'review_chall_num' value REVIEW_CHALL_NUM, "
					+ "'review_chall_title' value (select chall_title from challenge_list where chall_num = a.REVIEW_CHALL_NUM), "
					+ "'review_mem_num' value REVIEW_MEM_NUM, "
					+ "'review_mem_name' value (select mem_name from user_member where mem_num = a.REVIEW_MEM_NUM), "
					+ "'review_content' value REVIEW_CONTENT, "
					+ "'review_star'value REVIEW_STAR, "
					+ "'review_regdate' value REVIEW_REGDATE) "
					+ "AS json_result "
					+ "FROM (select * from (select row_number() over(order by review_num desc) rnum, b.* from review b) where rnum >= ? and rnum <= ?) a "
					+ "order by review_num desc";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			
			rs = pstmt.executeQuery();
			
			result += "{\"reviews\":";
			result += "[";
			while (rs.next()) {
				result += rs.getString("json_result")+",";
			}
			result = result.substring(0, result.length()-1);
			result += "]}";
			System.out.println(result);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(result);
		JSONObject jsonObj = (JSONObject)obj;
		
		JSONArray reviewArray = (JSONArray)jsonObj.get("reviews");
		for (int i =0; i<reviewArray.size(); i++) {
			JSONObject tempObj = (JSONObject)reviewArray.get(i);
			ReviewDTO dto = new ReviewDTO();
			
			dto.setReview_num(Integer.parseInt(String.valueOf(tempObj.get("review_num"))));
			dto.setReview_chall_num(Integer.parseInt(String.valueOf(tempObj.get("review_chall_num"))));
			dto.setReview_mem_num(Integer.parseInt(String.valueOf(tempObj.get("review_mem_num"))));
			dto.setReview_content(String.valueOf(tempObj.get("review_content")));
			dto.setReview_star(Integer.parseInt(String.valueOf(tempObj.get("review_star"))));
			dto.setReview_regdate(String.valueOf(tempObj.get("review_regdate")));
			dto.setReview_mem_name(String.valueOf(tempObj.get("review_mem_name")));
			dto.setReview_chall_title(String.valueOf(tempObj.get("review_chall_title")));
			
			list.add(dto);
		}
		
		return list;
		
	}
	
	public int reviewInsert(int mem_num, int chall_num, int star, String cont) {
		int result = 0, count = 0;
		
		try {
			openConn();
			sql = "select max(review_num) from review";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into review values(?, ?, ?, ?, ?, sysdate)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setInt(2, chall_num);
			pstmt.setInt(3, mem_num);
			pstmt.setString(4, cont);
			pstmt.setInt(5, star);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}
	
	
	public String getChall() {
		
		String result ="";
		
		try {
			openConn();
			
			sql ="select json_object('chall_num' value CHALL_NUM, "
					+ "'chall_title' value CHALL_TITLE) "
					+ "AS json_result "
					+ "from challenge_list "
					+ "order by chall_num";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			result += "[";
			while (rs.next()) {
				result += rs.getString("json_result")+",";
			}
			result = result.substring(0, result.length()-1);
			result += "]";
			System.out.println("getChall 결과 >>> "+ result);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
	
		return result;
		
	} // getChall() END
	
	
	
	
	public String getChall(String keyword) {
		
		String result ="";
		
		try {
			openConn();
			
			sql ="select json_object('chall_num' value CHALL_NUM, "
					+ "'chall_title' value CHALL_TITLE) "
					+ "AS json_result "
					+ "from challenge_list "
					+ "where CHALL_NUM like ? or CHALL_TITLE like ? "
					+ "order by chall_num";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyword+"%");
			pstmt.setString(2, "%"+keyword+"%");
			rs = pstmt.executeQuery();
			
			result += "[";
			while (rs.next()) {
				result += rs.getString("json_result")+",";
			}
			result = result.substring(0, result.length()-1);
			result += "]";
			System.out.println("getChall 결과 >>> "+ result);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	} // getChall() END
	
	
	
	public int getReviewCount() {
		
		int result = 0;

		try {
			openConn();
			sql = "select count(*) from review";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	}
	
	public int getReviewChallCount(int challNo) {
		
		int result = 0;

		try {
			openConn();
			sql = "select count(*) from review where review_chall_num = ?";
	
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, challNo);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	}
	
	
	public List<ReviewDTO> getReviewPreview(int challNo) throws ParseException{
		
		List<ReviewDTO> list = new ArrayList<ReviewDTO>();
		
		openConn();
		
		sql = "SELECT review.*, chall.CHALL_TITLE "
				+ "FROM (select * from (select row_number() over(order by review_num desc) rnum, b.* from review b where review_chall_num = ?) where rnum <= 5) review, "
				+ "(select chall_title from challenge_list where chall_num = ?) chall";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, challNo);
			pstmt.setInt(2, challNo);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ReviewDTO dto = new ReviewDTO();
				
				dto.setReview_num(rs.getInt("review_num"));
				dto.setReview_chall_num(rs.getInt("review_chall_num"));
				dto.setReview_mem_num(rs.getInt("review_mem_num"));
				dto.setReview_content(rs.getString("review_content"));
				dto.setReview_star(rs.getInt("review_star"));
				dto.setReview_regdate(rs.getString("review_regdate"));
				dto.setReview_chall_title(rs.getString("chall_title"));
				
				list.add(dto);			
			}
			
			sql = "select mem_name from user_member where mem_num = ?";
			pstmt = con.prepareStatement(sql);
			for (int i=0; i<list.size(); i++) {
				pstmt.setInt(1, list.get(i).getReview_mem_num());
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					list.get(i).setReview_mem_name(rs.getString(1));
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		
		return list;
		
	} // getReviewPreview() END
	
	
	
	public List<ReviewDTO> getReviewAll(int challNo, int page, int rowsize) throws ParseException{
		
		System.out.println("여기까지옴!!!!!!"+challNo+page+rowsize);
		
		List<ReviewDTO> list = new ArrayList<ReviewDTO>();
		
		int startNo = (page * rowsize) - (rowsize -1 ); 
		int endNo = (page * rowsize);
		
		openConn();
		
		sql = "SELECT review.*, chall.CHALL_TITLE FROM (select * from (select row_number() over(order by review_num desc) rnum, b.* from review b where review_chall_num = ?) where rnum >= ? and rnum <= ?) review, (select chall_title from challenge_list where chall_num = ?) chall";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, challNo);
			pstmt.setInt(2, startNo);
			pstmt.setInt(3, endNo);
			pstmt.setInt(4, challNo);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				
				dto.setReview_num(rs.getInt("review_num"));
				System.out.println("말해봐..................."+dto.getReview_num());
				dto.setReview_chall_num(rs.getInt("review_chall_num"));
				System.out.println("왜...?"+dto.getReview_chall_num());
				dto.setReview_mem_num(rs.getInt("review_mem_num"));
				dto.setReview_content(rs.getString("review_content"));
				dto.setReview_star(rs.getInt("review_star"));
				dto.setReview_regdate(rs.getString("review_regdate"));
				dto.setReview_chall_title(rs.getString("chall_title"));
				System.out.println("왜????????????" + dto.getReview_chall_title());
				
				
				list.add(dto);			
			}
			

			sql = "select mem_name from user_member where mem_num = ?";
			pstmt = con.prepareStatement(sql);
			for (int i=0; i<list.size(); i++) {
				pstmt.setInt(1, list.get(i).getReview_mem_num());
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					list.get(i).setReview_mem_name(rs.getString(1));
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		
		return list;
		
	} // getReviewAll() END
	
	
	public int checkReview(int challNo) {
		int result = 0;
		
		try {

			openConn();
			
			sql = "select review_chall_num from review where review_chall_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, challNo);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if (rs.getString(1).equals("")) {
					result = -1;
				}else {
					result = 1;
				}
			}else {
				result= -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	}
	
	
	public int deleteReview(int review_num) {
	      int result = 0;
	      
	      try {

	         openConn();
	         
	         sql = "delete from review where review_num = ?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, review_num);
	         result = pstmt.executeUpdate();
	         
	      } catch (SQLException e) {
	         e.printStackTrace();
	      }finally {
	         closeConn(rs, pstmt, con);
	      }
	      
	      return result;
	   }
	
	

}