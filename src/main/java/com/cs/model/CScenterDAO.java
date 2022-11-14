package com.cs.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CScenterDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	private static CScenterDAO instance;
		
	private CScenterDAO() {} 
	
	public static CScenterDAO getinstance() {
		if(instance == null) {
			instance = new CScenterDAO();
		}
		return instance;
	}
	

// Connection을 가져오는 메서드
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
	
	
	public List<NoticeDTO> getNoticeList(){
		List<NoticeDTO> list= new ArrayList<NoticeDTO>();

		try {
			openConn();
			
			sql="select * from notice order by notice_num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				NoticeDTO dto = new NoticeDTO();
				dto.setNotice_num(rs.getInt("notice_num"));
				dto.setNotice_title(rs.getString("notice_title"));
				dto.setNotice_content(rs.getString("notice_content"));
				dto.setNotice_regdate(rs.getString("notice_regdate"));
				dto.setNotice_category(rs.getString("notice_category"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
	} // getNoticeList() END
	
	
	
	public List<NoticeDTO> getNoticeList(int page, int rowsize){
		
		int startNo = (page * rowsize) - (rowsize -1 );
		int endNo = (page * rowsize);
		
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		
		try {

			openConn();
			sql = "select * from (select row_number() over(order by notice_num desc) rnum, b.* from notice b) where rnum >= ? and rnum <= ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNotice_num(rs.getInt("notice_num"));
				dto.setNotice_title(rs.getString("notice_title"));
				dto.setNotice_content(rs.getString("notice_content"));
				dto.setNotice_regdate(rs.getString("notice_regdate"));
				dto.setNotice_category(rs.getString("notice_category"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
		
	}
	
	
	public List<FAQDTO> getFAQList(){
		List<FAQDTO> list = new ArrayList<FAQDTO>();

		try {
			openConn();
			
			sql="select * from FAQ order by FAQ_num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				FAQDTO dto = new FAQDTO();
				
				dto.setFAQ_Num(rs.getInt("faq_num"));
				dto.setFAQ_title(rs.getString("faq_title"));
				dto.setFAQ_content(rs.getString("faq_content"));
				dto.setFAQ_regdate(rs.getString("faq_regdate"));
				dto.setFAQ_category_num(rs.getString("faq_category_num"));
				
				list.add(dto);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
	
	} // getFAQList() END
	
	
	
	public List<PrivateQDTO> getPagedPQList(int no){
		List<PrivateQDTO> list = new ArrayList<PrivateQDTO>();
		
		try {

			openConn();
			
			sql = "select * from (select row_number() over(order by p_q_num) rnum, b.* from private_q b) where rnum >= ? and rnum <= ?";
			                                                                                                                                                                                                                                                                                                                                   
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PrivateQDTO dto = new PrivateQDTO(); 
				
				dto.setP_q_num(rs.getInt("p_q_num"));
				dto.setP_q_user_num(rs.getInt("p_q_user_num"));
				dto.setP_q_chall_num(rs.getInt("p_q_chall_num"));
				dto.setP_q_title(rs.getString("p_q_title"));
				dto.setP_q_regdate(rs.getString("p_q_regdate"));
				dto.setP_q_answer_cont(rs.getString("p_q_answer_cont"));
				dto.setP_q_answer_num(rs.getInt("p_q_answer_num"));;
				dto.setP_q_answer_regdate(rs.getString("p_q_answer_regdate"));
				
				list.add(dto);				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
	} // privateQList() END
	
	
	public String getPQList(int user_no) { 
		
		String result="";
		
		try {
			openConn();

			sql = "select * from private_q where p_q_user_num = ? order by p_q_num desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, user_no);
			rs = pstmt.executeQuery();
			
			result += "<PQNAs>";
			
			while (rs.next()) {
				result += "<PQNA>";
				result += "<num>" + rs.getInt("p_q_num") + "</num>";
				result += "<challNum>" + rs.getInt("p_q_chall_num") + "</challNum>";
				result += "<title>" + rs.getString("p_q_title") + "</title>";
				
				String p_q_cont = rs.getString("p_q_content").replace("\n", "<br>");
				
				result += "<content>" + p_q_cont  + "</content>";
				result += "<cateNum>" + rs.getInt("p_q_category_num") + "</cateNum>";
				result += "<regdate>" + rs.getString("p_q_regdate") + "</regdate>";
				
				
				if (rs.getString("p_q_answer_cont") != null) {
					String p_q_answercont = rs.getString("p_q_answer_cont").replace("\n", "<br>");
					result += "<answerCont>" + p_q_answercont + "</answerCont>";
				}else {
					result += "<answerCont>" + rs.getString("p_q_answer_cont") + "</answerCont>";
				}
				
				result += "<answerRegdate>" + rs.getString("p_q_answer_regdate") + "</answerRegdate>";
				result += "<againNum>" + rs.getInt("p_q_again_num") + "</agianNum>";
				result += "<aswerNum>" + rs.getInt("p_q_answer_num") + "</answerNum>";
				result += "<userNum>" + rs.getInt("p_q_user_num") + "</userNum>";
				result += "</PQNA>";
			}
			
			result += "</PQNAs>";
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	} //getPQList() END
	
	
	public NoticeDTO getNoticeContent(int no) {
		NoticeDTO dto = new NoticeDTO();
		
		openConn();
		
		sql = "select * from notice where notice_num = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNotice_num(rs.getInt("notice_num"));
				dto.setNotice_title(rs.getString("notice_title"));
				dto.setNotice_content(rs.getString("notice_content"));
				dto.setNotice_regdate(rs.getString("notice_regdate"));
				dto.setNotice_category(rs.getString("notice_category"));	
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
		
	} // getNoticeContent() END
	
	
	
	public int getBoardCount() {
		
		int result = 0;

		try {
			openConn();
			sql = "select count(*) from notice";
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
	
	
	public List<Q_categoryDTO> getQ_categoryList() {
		
		List<Q_categoryDTO> list = new ArrayList<Q_categoryDTO>();
		
		openConn();
		sql = "select * from q_category order by q_category_num";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Q_categoryDTO dto = new Q_categoryDTO();
				dto.setQ_category_num(rs.getInt("q_category_num"));
				dto.setQ_category_type(rs.getString("q_category_type"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	
	public int insertPQ(PrivateQDTO dto) {
		int result = 0, count = 0;
		
		try {

			openConn();
			
			sql = "select max(p_q_num) from private_q";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1)+1;
				System.out.println(count);
			}
			
			sql = "insert into private_q values(?, 1, ?, ?, ?, sysdate, ?, ?, ?, ?, ?, ?, 'NO')";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getP_q_title());
			pstmt.setString(3, dto.getP_q_content());
			pstmt.setInt(4, dto.getP_q_category_num());
			pstmt.setString(5, dto.getP_q_answer_cont());
			pstmt.setString(6, dto.getP_q_answer_regdate());
			pstmt.setInt(7, dto.getP_q_again_num());
			pstmt.setInt(8, dto.getP_q_answer_num());
			pstmt.setInt(9, dto.getP_q_user_num());
			pstmt.setInt(10, dto.getP_q_check());
			
			result = pstmt.executeUpdate();
						
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}
	
}