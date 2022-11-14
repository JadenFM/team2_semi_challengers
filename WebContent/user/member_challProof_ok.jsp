<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.chall.model.ChallProofDTO"%>
<%@page import="com.chall.model.ChallJoinDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int Ch_deposit_SC = (int)request.getAttribute("ChallDeposit");
	ChallJoinDTO challContent_SC = (ChallJoinDTO)request.getAttribute("challContent");
	List<ChallProofDTO> Pr_list_SC = (List<ChallProofDTO>)request.getAttribute("ProofList");
	String lastestDate_SC = (String)request.getAttribute("LastestDate");
	pageContext.setAttribute("LastDate", lastestDate_SC);
	System.out.println("최근 인증 날짜 >>>"+lastestDate_SC);
	
	String startDate = challContent_SC.getChall_startDate(); 					// ★시작일
	Date startDate_format = new SimpleDateFormat("yyyyMMdd").parse(startDate);
	
	Calendar cal = Calendar.getInstance(); 										// cal 객체 생성
	cal.setTime(startDate_format);												// 날짜 계산을 위해 시작일을 cal형태의 시간으로 설정 
	int endDate_cal = Integer.parseInt(challContent_SC.getChall_duration()) * 7;// [★챌린지 기간] * [7일]
	cal.add(Calendar.DATE, endDate_cal); 										// cal형태로 설정된 시작일에 endDate더하기
	SimpleDateFormat dtFormat = new SimpleDateFormat("yyyyMMdd"); 				// 특정 형식으로 변환하기 위한 객체 생성
	String endDate = dtFormat.format(cal.getTime()); 							// 종료일  (특정 형식으로 변환해 종료일 설정)
	Date endDate_format = new SimpleDateFormat("yyyyMMdd").parse(endDate);		// 종료일을 date format으로 재설정
	
	long diffSec = (endDate_format.getTime()-startDate_format.getTime())/1000;	//초 차이(일자수 차이 계산을 위한 전단계)
	float diffDays = (float)diffSec / (24*60*60); 								// ★일자수 차이
	
	int proof_count = Pr_list_SC.size();								// ★인증 횟수
	float achv_rate = (float)(proof_count / diffDays) * 100;			// ★달성률(ex:70.22)
	achv_rate = Float.parseFloat(String.format("%.2f", achv_rate)); 	// 달성률 소수점 2째 자리까지만 표현
	float gained_depositF = (float)Ch_deposit_SC * (achv_rate / 100);
	int gained_deposit = (int) Math.ceil(gained_depositF);				// ★현재 확보한 예치금
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<style type="text/css">

	.join_hr {
		border: 0;
    	height: 5px;
    	background: #ff4d54;
    	opacity: 80;
	}
	.progress{
		width: 50%;
	}
	/* 부트스트랩 적용 후 바뀌는 부분 조절(include) */      
   .container{
    margin-right: 0px;
    margin-left: 0px;   
    max-width: 100%;
    padding: 0px;
    box-sizing: content-box;
      }
   
    .search_text{
   box-sizing:content-box;
    }
    
    .rogoImg{
   box-sizing: content-box;
    }
    
    .top{
   margin: 16px 0px 16px 0px; 
    }
    
    .menu li{
    box-sizing: content-box;
    }
/* 부트스트랩 적용 후 바뀌는 부분(include) end */

</style>
</head>
<body>
<jsp:include page="/include/chall_top.jsp" />
	<div align="center">
		<h4>인증완료!<br>
		오늘도 멋지게 해내셨네요</h4>
		${challContent.getChall_title() }
		
		<br>
		<span>현재 달성률</span><br>
		<span><%=achv_rate%>%</span>
		<div class="progress">
		  <div class="progress-bar bg-danger" role="progressbar" aria-label="Danger example" style="width: <%=achv_rate%>%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
		</div>
		<span>현재 확보한 예치금</span><br>
		<span><%=gained_deposit%>원</span><br>
		
		<br><br>
		<button class="btn btn-dark" onclick="location.href='member_challProof.do'">인증페이지 다시 가기</button>
	</div>
<jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>