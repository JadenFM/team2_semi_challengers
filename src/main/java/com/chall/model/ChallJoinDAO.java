package com.chall.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.chall.controller.OjdbcUrl;

import com.user.model.UserDTO;

public class ChallJoinDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	private static ChallJoinDAO instance;
		
	private ChallJoinDAO() {} 
	
	public static ChallJoinDAO getInstance() {
		if(instance == null) {
			instance = new ChallJoinDAO();
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
	
	
	// (Member)기존 '임시' 상태 챌린지 삭제
	public void deleteExistingChall(int mem_num) {
		try {
			openConn();
			sql="delete from challenge_list where chall_creater_num = ? and chall_status = '임시'";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	}	// deleteExistingChall() end
	
	
	// (Admin)기존 '임시' 상태 챌린지 삭제
	public void deleteExistingChall(String ad_id) {
		try {
			openConn();
			sql="delete from challenge_list where admin_id_fk = ? and chall_status = '임시'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ad_id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	}	// deleteExistingChall_admin() end
		
		
	// ('임시저장'이 아닐 때)맨처음 list테이블에 등록(1-챌린지 고유 번호/2-개설자 회원 번호/3-챌린지 상태)
	public int insertChall_0(int mem_num) {
		
		int count = 0;
		
		try {
			openConn();
			sql = "select max(chall_num) from challenge_list";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1) + 1;
			}
			sql = "insert into challenge_list values('',?,'','','','','','','','','','','','','','','','','','',?,?,default,'','','','','')";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, "임시");
			pstmt.setInt(3, mem_num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	} // insertChall_0() end
	
	
	// (Member)첫번째 정보 업데이트(1-공개여부)
	public int updateChall_1(String open, int chall_num) {
		int result = 0;
		try {
			openConn();
			sql = "update challenge_list set chall_open = ? where chall_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, open);
			pstmt.setInt(2, chall_num);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} // updateChall_1() end
		
	
	// (Admin)첫번째 정보 입력(1-공개여부/2-챌린지 고유 번호/3-챌린지 상태/4-개설자 관리자 번호)
	public int insertChall_1(String open, String ad_id) {
		
		int result = 0, count = 0;
		
		try {
			openConn();
			sql = "select max(chall_num) from challenge_list";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1) + 1;
			}
			sql = "insert into challenge_list values(?,?,'','','','','','','','','','','','','','','','','',?,?,'',default,'','','','','')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, open);
			pstmt.setInt(2, count);
			pstmt.setString(3, ad_id);
			pstmt.setString(4, "임시");
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} // insertChall_1_admin() end
	
	
	// (Member)앞 페이지에서 개설하던 챌린지의 고유 번호 가져오기
	public int continueChallNum(int mem_num) {
		int count = 0;
		try {
			openConn();
			sql = "select max(chall_num) from challenge_list where chall_creater_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	}	// continueChallNum() end
	
	
	// (Admin)앞 페이지에서 개설하던 챌린지의 고유 번호 가져오기
	public int continueChallNum(String ad_id) {
		int count = 0;
		try {
			openConn();
			sql = "select max(chall_num) from challenge_list where admin_id_fk = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ad_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	}	// continueChallNum() end
	
	
	// 두번째 정보 입력(1-제목/2-인증빈도/3-기간/4-시작일/5-인증방법/6-인증시작시간/7-인증종료시간/8-소개/9-인증성공이미지/10-인증실패이미지/11-소개이미지)
	public int updateChall_2(ChallJoinDTO dto) {
		
		int result = 0;
		
		try {
			openConn();
			sql = "update challenge_list set chall_title = ?, chall_cycle = ?,"
					+ "chall_duration = ?, chall_startdate = ?, chall_guide = ?,"
					+ "chall_regitimestart = ?, chall_regitimeend = ?,"
					+ "chall_cont = ?, chall_successimage = ?, chall_failimage = ?,"
					+ "chall_contimage = ? where chall_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getChall_title());
			pstmt.setString(2, dto.getChall_cycle());
			pstmt.setString(3, dto.getChall_duration());
			pstmt.setString(4, dto.getChall_startDate());
			pstmt.setString(5, dto.getChall_guide());
			pstmt.setString(6, dto.getChall_regiTimeStart());
			pstmt.setString(7, dto.getChall_regiTimeEnd());
			pstmt.setString(8, dto.getChall_cont());
			pstmt.setString(9, dto.getChall_successImage());
			pstmt.setString(10, dto.getChall_failImage());
			pstmt.setString(11, dto.getChall_contImg());
			pstmt.setInt(12, dto.getChall_num());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} // updateChall_2() end

	
	// 세번째 정보 입력(1-예치금(기본)/2-예치금(최대)/3-비공개 참여코드/4-최대 모집인원)
	public int updateChall_3(ChallJoinDTO dto) {
		int result = 0;
		
		try {
			openConn();
			sql = "update challenge_list set chall_depositDefault = ?, chall_depositMax = ?,"
					+ "chall_privateCode = ?, chall_maxPeople = ? where chall_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getChall_depositDefault());
			pstmt.setString(2, dto.getChall_depositMax());
			pstmt.setString(3, dto.getChall_privateCode());
			pstmt.setString(4, dto.getChall_maxPeople());
			pstmt.setInt(5, dto.getChall_num());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// updateChall_3() end
	
	
	// 카테고리 기본 메인 이미지 파일명 가져오기
	public String getCateDefaultImg(String categoryCode) {
		String img = "";
		try {
			openConn();
			sql = "select category_image from challenge_category where category_code = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, categoryCode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				img = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return img;
	}	// getCateDefaultImg() end
	
	
	// (Member)네번째 정보 입력(1-카테고리 코드/2-대표사진/3-키워드1/4-키워드2/5-키워드3)
	public int updateChall_4(ChallJoinDTO dto) {
		int result = 0;
		
		try {
			openConn();
			sql = "update challenge_list set chall_category_code_fk = ?, chall_keyword1 = ?,"
					+ "chall_keyword2 = ?, chall_keyword3 = ?, chall_mainImage = ?, chall_status = '임시저장' where chall_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getChall_category_code_fk());
			pstmt.setString(2, dto.getChall_keyword1());
			pstmt.setString(3, dto.getChall_keyword2());
			pstmt.setString(4, dto.getChall_keyword3());
			pstmt.setString(5, dto.getChall_mainImage());
			pstmt.setInt(6, dto.getChall_num());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// updateChall_4() end
	
	
	// (Admin)네번째 정보 입력(1-카테고리 코드/2-대표사진/3-키워드1/4-키워드2/5-키워드3)
	public int updateChall_4(ChallJoinDTO dto, String ad_id) {
		int result = 0;
		
		try {
			openConn();
			sql = "update challenge_list set chall_category_code_fk = ?, chall_keyword1 = ?,"
					+ "chall_keyword2 = ?, chall_keyword3 = ?, chall_mainImage = ? where chall_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getChall_category_code_fk());
			pstmt.setString(2, dto.getChall_keyword1());
			pstmt.setString(3, dto.getChall_keyword2());
			pstmt.setString(4, dto.getChall_keyword3());
			pstmt.setString(5, dto.getChall_mainImage());
			pstmt.setInt(6, dto.getChall_num());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// updateChall_4() end
		
	
	// 해당 챌린지 정보 가져오기
	public ChallJoinDTO getChallContent(int challNum) {
		ChallJoinDTO dto = new ChallJoinDTO();
		try {
			openConn();
			sql = "select * from challenge_list where chall_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, challNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setChall_open(rs.getString("chall_open"));
				dto.setChall_title(rs.getString("chall_title"));
				dto.setChall_mainImage(rs.getString("chall_mainImage"));
				dto.setChall_cycle(rs.getString("chall_cycle"));
				dto.setChall_duration(rs.getString("chall_duration"));
				dto.setChall_startDate(rs.getString("chall_startDate"));
				dto.setChall_guide(rs.getString("chall_guide"));
				dto.setChall_successImage(rs.getString("chall_successImage"));
				dto.setChall_failImage(rs.getString("chall_failImage"));
				dto.setChall_regiTimeStart(rs.getString("chall_regiTimeStart"));
				dto.setChall_regiTimeEnd(rs.getString("chall_regiTimeEnd"));
				dto.setChall_cont(rs.getString("chall_cont"));
				dto.setChall_contImg(rs.getString("chall_contImage"));
				dto.setChall_depositDefault(rs.getString("chall_depositDefault"));
				dto.setChall_depositMax(rs.getString("chall_depositMax"));
				dto.setChall_privateCode(rs.getString("chall_privateCode"));
				dto.setChall_maxPeople(rs.getString("chall_maxPeople"));
				dto.setChall_category_code_fk(rs.getString("chall_category_code_fk"));
				dto.setChall_ongoingPeople(rs.getInt("chall_ongoingPeople"));
				dto.setChall_creater_num(rs.getInt("chall_creater_num"));
				dto.setChall_status(rs.getString("chall_status"));
				dto.setChall_num(rs.getInt("chall_num"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}	// getChallContent() end
	
	
	// 챌린지 정보 보기 페이지에서 필요한 회원 정보 가져오기(개설수, 평점, 프로필 사진)
	public UserDTO getMemInfo(int createrNum) {
		UserDTO dto = new UserDTO();
		try {
			openConn();
			sql = "select * from user_member where mem_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, createrNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setMem_id(rs.getString("mem_id"));
				dto.setChallenge_made_count(rs.getInt("challenge_made_count"));
				dto.setChallenge_rating(rs.getInt("challenge_rating"));
				dto.setMem_img(rs.getString("mem_img"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}	// getMemInfo() end
	
	
	// 해당 회원의 예치금 정보 가져오기
	public int getMemMoney(int mem_num) {
		int mem_money = 0;
		try {
			openConn();
			sql = "select mem_money from user_member where mem_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mem_money=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return mem_money;
	}	// getMemMoney() end
	
	
	// (Member)결제완료 시 해당 챌린지 정보 업데이트(현재 참여 인원 : +1 / 상태 : ‘임시저장’ → ‘진행중’)
	public void challJoinOk(int challNum) {
		try {
			openConn();
			sql = "update challenge_list set chall_ongoingPeople = 1, chall_status = '진행중', CHALL_REGDATE = sysdate where chall_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, challNum);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	}	// challJoinOk() end
	
	
	// (Admin)결제완료 시 해당 챌린지 정보 업데이트(현재 참여 인원 : +1 / 상태 : ‘임시저장’ → ‘진행중’)
	public void challJoinOk(int challNum, String ad_id) {
		try {
			openConn();
			sql = "update challenge_list set chall_status = '진행중', CHALL_REGDATE = sysdate where chall_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, challNum);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	}	// challJoinOk() end
	
	
	// 결제완료 시 해당 회원 정보 업데이트(챌린지 개설 횟수 : +1 / 예치금 : 사용한 만큼 차감) challenge_made_count +1, 예치금(mem_money) 차감
	public void memChallJoinUpdate_creater(int mem_num, int dpM) {
		try {
			openConn();
			sql = "update user_member set challenge_count = challenge_count+1, challenge_made_count = challenge_made_count+1, mem_money = mem_money-? where mem_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dpM);
			pstmt.setInt(2, mem_num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	}	// memChallJoinUpdate() end
	
	
	// 결제완료 시 해당 회원 정보 업데이트(챌린지 개설 횟수 : +1 / 예치금 : 사용한 만큼 차감) challenge_made_count +1, 예치금(mem_money) 차감
	public void memChallJoinUpdate_participant(int mem_num, int dpM) {
		try {
			openConn();
			sql = "update user_member set challenge_count = challenge_count+1, mem_money = mem_money-? where mem_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dpM);
			pstmt.setInt(2, mem_num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	}	// memChallJoinUpdate() end
	
	
	// 비공개 코드 확인
	public int checkPrivateCode(int challNum, String paramCode) {
		String originalCode = "";
		int result = 0;   // 아이디 중복 여부 체크 변수
		try {
			openConn();
			sql = "select chall_privateCode from challenge_list where chall_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, challNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				// 중복이 되는 경우
				originalCode = rs.getString("chall_privateCode");
				if((originalCode).equals(paramCode)) {
					result = 1;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// checkPrivateCode() end
}
