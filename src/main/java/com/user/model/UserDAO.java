package com.user.model;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


public class UserDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	private static UserDAO instance;
		
	private UserDAO() {} 
	
	public static UserDAO getinstance() {
		if(instance == null) {
			instance = new UserDAO();
		}
		return instance;
	}
	

// Connection을 가져오는 메서드
	public void openConn() {
	
		String driver = "oracle.jdbc.driver.OracleDriver";

		String url = "jdbc:oracle:thin:@projectchallengers_high?TNS_ADMIN=C:/ncs/download/apache-tomcat-9.0.65/Wallet_ProjectChallengers/";


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
	
	
	// 회원 가입 시 입력받은 아이디가 DB 회원 테이블에 존재하면 1, 존재하지 않으면 0을 응답하는 메소드.
	public int joinCheckId(String id) {
		
		int count = 2;
		
		try {
			openConn();
			
			sql = "select count(*) from user_member where mem_id = ? ";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);	// 아이디 not null값임. 존재하면 1, 존재하지 않으면 0 
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return count;
		
	}	// joinCheckId() 메소드 end
	
	// 회원인 지 체크하는 메소드.
	public int userCheck(String id, String pwd) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select * from user_member where mem_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				if(pwd.equals(rs.getString("mem_pwd"))) {
					// 회원인 경우
					result = 1;
				}else {
					// 회원 아이디는 맞으나 비밀번호가 틀린 경우
					result = -1;
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}	// userCheck() 메소드 end
	
	// id에 해당하는 회원의 정보를 조회하는 메소드
	public UserDTO getMember(String id) {
		
		UserDTO dto = null;

		try {
			openConn();
			
			sql = "select * from user_member where mem_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();	
			
			if(rs.next()) {
				dto = new UserDTO();
				
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setMem_id(rs.getString("mem_id"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_pwd(rs.getString("mem_pwd"));
				dto.setMem_age(rs.getInt("mem_age"));
				dto.setMem_phone(rs.getString("mem_phone"));
				dto.setMem_addr(rs.getString("mem_addr"));
				dto.setMem_xp(rs.getInt("mem_xp"));
				dto.setMem_level(rs.getString("mem_level"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setMem_money(rs.getInt("mem_money"));
				dto.setMem_reward(rs.getInt("mem_reward"));
				dto.setChallenge_count(rs.getInt("challenge_count"));
				dto.setChallenge_complete_count(rs.getInt("challenge_complete_count"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
		
	}	// getMember() 메소드 end
	
	// user_member 테이블에서 회원번호에 해당하는 회원의 정보를 가져오는 메소드
	public UserDTO getMemberInfo(int member_num) {
		
		UserDTO dto = null;
		
		try {
			openConn();
			
			sql = "select * from user_member where mem_num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, member_num);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new UserDTO();
				
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setMem_id(rs.getString("mem_id"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_pwd(rs.getString("mem_pwd"));
				dto.setMem_age(rs.getInt("mem_age"));
				dto.setMem_phone(rs.getString("mem_phone"));
				dto.setMem_addr(rs.getString("mem_addr"));
				dto.setMem_xp(rs.getInt("mem_xp"));
				dto.setMem_level(rs.getString("mem_level"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setMem_money(rs.getInt("mem_money"));
				dto.setMem_reward(rs.getInt("mem_reward"));
				dto.setChallenge_count(rs.getInt("challenge_count"));
				dto.setChallenge_complete_count(rs.getInt("challenge_complete_count"));
				dto.setMem_report_count(rs.getInt("mem_report_count"));
				dto.setMem_email(rs.getString("mem_email"));
				dto.setMem_gender(rs.getString("mem_gender"));
				dto.setMem_img(rs.getString("mem_img"));
				dto.setChallenge_made_count(rs.getInt("challenge_made_count"));
				dto.setChallenge_rating(rs.getInt("challenge_rating"));
				dto.setMem_birth(rs.getString("mem_birth"));
				dto.setPostcode(rs.getInt("postcode"));
				dto.setRoadAddress(rs.getString("roadaddress"));
				dto.setJibunAddress(rs.getString("jibunaddress"));
				dto.setDetailAddress(rs.getString("detailaddress"));
				dto.setExtraAddress(rs.getString("extraaddress"));
				dto.setEmailId(rs.getString("emailid"));
				dto.setEmailDomain(rs.getString("emaildomain"));
				dto.setNationNo(rs.getString("nationno"));
				dto.setPhoneNo(rs.getString("phoneno"));
				dto.setKakaoAccount(rs.getString("kakaoAccount"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}	// getMemberInfo() 메소드 end
	
	// 카카오 이메일로 DB에 존재하는 회원인지 확인하는 메소드.
	public String savedUserCheck(String email) {
		
		String savedUser = null;
		
		UserDTO dto = null;
		
		try {
			openConn();
			
			sql = "select * from user_member where mem_email=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {	// 카카오에서 받아온 이메일을 가진 회원이 이미 있으면 yes
				savedUser = "yes";
			}else {
				savedUser = "no";
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return savedUser;
		
	} // savedUserCheck() 메소드 end

	// user_member 테이블에 회원을 추가하는 메소드.
	public int insertMember(UserDTO dto) {
		
		int result = 0, count = 0;
		
		try {
			openConn();
			
			// 회원번호 최댓값 구하기
			sql = "select max(mem_num) from user_member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into user_member (mem_num, mem_id, mem_pwd, mem_name, mem_age, mem_gender, mem_email, mem_phone, mem_addr, regdate, mem_birth, emailid, emaildomain, postcode, roadAddress, jibunAddress, detailAddress, extraAddress, nationNo , phoneNo, kakaoAccount) values(?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?, 'NO' )";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getMem_id());
			pstmt.setString(3, dto.getMem_pwd());
			pstmt.setString(4, dto.getMem_name());
			pstmt.setInt(5, dto.getMem_age());
			pstmt.setString(6, dto.getMem_gender());
			pstmt.setString(7, dto.getMem_email());
			pstmt.setString(8, dto.getMem_phone());
			pstmt.setString(9, dto.getMem_addr());
			pstmt.setString(10, dto.getMem_birth());
			pstmt.setString(11, dto.getEmailId());
			pstmt.setString(12, dto.getEmailDomain());
			pstmt.setInt(13, dto.getPostcode());
			pstmt.setString(14, dto.getRoadAddress());
			pstmt.setString(15, dto.getJibunAddress());
			pstmt.setString(16, dto.getDetailAddress());
			pstmt.setString(17, dto.getExtraAddress());
			pstmt.setString(18, dto.getNationNo());
			pstmt.setString(19, dto.getPhoneNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	}	// insertMember() 메소드 end
	
	
	// 카카오에서 액세스 토큰 받아오는 메소드.
	// 카카오 로그인 완료 후 받은 인가코드를 매개변수로 할당
	public String getAccessToken (String auth_code) {
		String access_token = "";
		String refresh_token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			            
			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			            
			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=617a393522b6cb65ea54d2ed4350878e");
			sb.append("&redirect_uri=http://localhost:8282/Semi_Challengers/member_kakaoLoginOk.do");
			sb.append("&code=" + auth_code);
			bw.write(sb.toString());
			bw.flush();
			            
			//    결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			 
			//요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new java.io.InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			            
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			           
			//Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			            
			access_token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_token = element.getAsJsonObject().get("refresh_token").getAsString();
			            
			System.out.println("access_token : " + access_token);
			System.out.println("refresh_token : " + refresh_token);
			            
			br.close();
			bw.close();
			} catch (IOException e) {
				e.printStackTrace();
		} 
		return access_token;
	} // getAccessToken() 메소드 end
	
	// 카카오 사용자 정보를 받아오는 메소드
	public HashMap<String, Object> getKakaoUserInfo (String access_token) {
		HashMap<String, Object> kakaoUserInfo  = new HashMap<>();
	    String reqURL = "https://kapi.kakao.com/v2/user/me";
	    try{
	    	URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + access_token);   
	        int responseCode = conn.getResponseCode();       
	        BufferedReader br = new BufferedReader(new java.io.InputStreamReader(conn.getInputStream(),"UTF-8")); 
	        String line = "";
	        String result = "";    
	        while ((line = br.readLine()) != null) {
	        	result += line;
	        }
	        JsonParser parser = new JsonParser();
	        JsonElement element = parser.parse(result);
	        String id = element.getAsJsonObject().get("id").getAsString();
	        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();    
	        String nickname = properties.getAsJsonObject().get("nickname").getAsString();
	        
	        String profile_image = properties.getAsJsonObject().get("profile_image").getAsString();
	        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();    
	        String email = kakao_account.getAsJsonObject().get("email").getAsString();
	        String birthday = kakao_account.getAsJsonObject().get("birthday").getAsString();
	        String gender = kakao_account.getAsJsonObject().get("gender").getAsString();
	        
	        kakaoUserInfo.put("id", id);
	        kakaoUserInfo.put("nickname", nickname);
	        
	        kakaoUserInfo.put("profile_image", profile_image);
	        kakaoUserInfo.put("email", email);
	        kakaoUserInfo.put("birthday", birthday);
	        kakaoUserInfo.put("gender", gender);
	        System.out.println(properties);
	        br.close();
	            
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	        
	    return kakaoUserInfo;
	} // getKakaoUserInfo() 메소드 end
	
	// 카카오로 로그인한 회원이 기존 회원이면 true 반환하는 메소드.
	public boolean checkKakaoUser(String k_email ) {
		
		boolean isMember = false;
		
		try {
			openConn();
			// 카카오로 로그인한 회원의 이메일 정보와 일치하는 이메일이 챌린저스 DB에 있는지 확인
			sql = "select * from user_member where mem_email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, k_email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {	// 기존 회원이라면 (DB에 회원이 이미 있다면)
				isMember = true;
			}else {	// 기존 회원이 아니라면
				isMember = false;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return isMember;
		
	} // checkKakaoUser() 메소드 end
	
	// 카카오 로그인 시 해당 이메일을 가진 기존 회원 kakaoAccount 컬럼값을 'YES'로 바꾸는 메소드.
	public void connectKakaoMember(String k_email) {
		
			int result = 0;
		try {
			openConn();
			
			sql = "update user_member set kakaoAccount = 'YES' where mem_email = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, k_email);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
	} // connectKakaoMember() 메소드 end
	
	// 카카오 계정 이메일과 동일한 이메일을 가지고 있는 user_member 테이블의 회원 정보를 가져오는 메소드. 
	public UserDTO getMemberWithKakao(String k_email) {
		
		UserDTO dto = null;
		
		try {
			openConn();
			
			sql = "select * from user_member where mem_email=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, k_email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new UserDTO();
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setMem_id(rs.getString("mem_id"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_pwd(rs.getString("mem_pwd"));
				dto.setMem_age(rs.getInt("mem_age"));
				dto.setMem_phone(rs.getString("mem_phone"));
				dto.setMem_addr(rs.getString("mem_addr"));
				dto.setMem_xp(rs.getInt("mem_xp"));
				dto.setMem_level(rs.getString("mem_level"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setMem_money(rs.getInt("mem_money"));
				dto.setMem_reward(rs.getInt("mem_reward"));
				dto.setChallenge_count(rs.getInt("challenge_count"));
				dto.setChallenge_complete_count(rs.getInt("challenge_complete_count"));
				dto.setMem_report_count(rs.getInt("mem_report_count"));
				dto.setMem_email(rs.getString("mem_email"));
				dto.setMem_gender(rs.getString("mem_gender"));
				dto.setMem_img(rs.getString("mem_img"));
				dto.setChallenge_made_count(rs.getInt("challenge_made_count"));
				dto.setChallenge_rating(rs.getInt("challenge_rating"));
				dto.setMem_birth(rs.getString("mem_birth"));
				dto.setPostcode(rs.getInt("postcode"));
				dto.setRoadAddress(rs.getString("roadaddress"));
				dto.setJibunAddress(rs.getString("jibunaddress"));
				dto.setDetailAddress(rs.getString("detailaddress"));
				dto.setExtraAddress(rs.getString("extraaddress"));
				dto.setEmailId(rs.getString("emailid"));
				dto.setEmailDomain(rs.getString("emaildomain"));
				dto.setNationNo(rs.getString("nationno"));
				dto.setPhoneNo(rs.getString("phoneno"));
				
				System.out.println("dto>>>"+dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	} // getMemberWithKakao() 메소드 end
	
	// 카카오 계정 정보를 활용하여 회원 정보 추가하는 메소드.
	public int insertMemberWithKakao(String k_id, String k_nickname, String k_email, String k_gender, String k_profile_image) {
		
		int result=0 , count = 0;
		
		openConn();
		
		// 카카오 계정 이메일 아이디와 도메인으로 나누기.
		// @를 기준으로 문자열을 추출하기.
		// 먼저 @ 의 인덱스를 찾는다.
		int idx = k_email.indexOf("@");
		// 인덱스 0부터 @까지 자르기.
		String k_emailId = k_email.substring(0, idx);
	     // 아래 substring은 @ 바로 뒷부분인 n부터 추출된다.
        String k_emailDomain = k_email.substring(idx+1);
        
        // 카카오 성별 정보 mem_gender의 check 제약 조건(mem_gender IN('M', 'F', 'none'))에 맞게 변환.
        if (k_gender.equals("female")) {
        	k_gender = "F";
        }else{ // "male" 인 경우
        	k_gender = "M";
        }
        
		try {
			openConn();
			
			// 회원번호 최댓값 구하기
			sql = "select max(mem_num) from user_member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into user_member (mem_num, mem_id, mem_name, mem_email, mem_gender, mem_img, regdate, emailid, emaildomain, kakaoAccount) values(?, ?, ?, ?, ?, ?, sysdate, ?, ?, 'YES')";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setString(2, k_id);
			pstmt.setString(3, k_nickname);
			pstmt.setString(4, k_email);
			pstmt.setString(5, k_gender);
			pstmt.setString(6, k_profile_image);
			pstmt.setString(7, k_emailId);
			pstmt.setString(8, k_emailDomain);
			
			result = pstmt.executeUpdate();	
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;		
	}	// insertMemberWithKakao() 메소드 end
	
	// 카카오 로그아웃하는 메소드.
	public void logoutWithKakao(String access_Token) {
	    String reqURL = "https://kapi.kakao.com/v1/user/logout";
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String result = "";
	        String line = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        System.out.println("로그아웃된 카카오 아이디 : "+result);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}	// logoutWithKakao 메소드 end
	
	// 
	public void unlink(String access_Token) {
	    String reqURL = "https://kapi.kakao.com/v1/user/unlink";
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String result = "";
	        String line = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        System.out.println(result);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	}	
	
	// user_member 테이블에 해당 id가 있는 지 확인하는 메소드.
	public int doesEmailExist(String id) {
		
		int result = 2;
		
		try {
			openConn();
			
			sql = "select count(*) from user_member where mem_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}	// doesEmailExist() 메소드 end
	
	// user_member 테이블에서 해당 id를 가진 해당 사용자의 이메일 주소를 가져오는 메소드
	public String getMemberEmail(String id) {
		
		String mem_email = "";
		
		try {
			openConn();
			sql = "select mem_email from user_member where mem_id=?";			
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mem_email = rs.getString(1);
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return mem_email;
	}	// getMemberEmail() 메소드 end

	// 해당 이메일 정보를 가진 회원의 비밀번호를 수정하는 메소드.
	public int updatePwd(String mem_email, String rePwd){
		
		int result = 0;

		try {
			openConn();
			
			sql = "update user_member set mem_pwd = ? where mem_email = ?";
						
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, rePwd);
			pstmt.setString(2, mem_email);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
		}finally {
		closeConn(rs, pstmt, con);
		}
		return result;
		
	}	// dao.updatePwd() 메소드 end 
	

	public int getmemberid(String mem_id_reported) {
		int result = 0;
		openConn();
		try {
			sql = "select mem_id from user_member where mem_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_id_reported);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = 1;
			}
			
			sql = "select mem_name from user_member where mem_name = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,mem_id_reported);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = 2;
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}

		return result;
	}	

	
	
	// 인증 완료 시 경험치(mem_xp) +25
	public void updateXp(int memberNum) {
		try {
			openConn();
			sql = "update user_member set mem_xp = mem_xp+25 where mem_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
	}	// updateXp() end
}