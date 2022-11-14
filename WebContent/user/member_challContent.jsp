<%@page import="com.chall.model.ChallJoinDTO"%>
<%@page import="com.user.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>챌린지 상세페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript" src="searchJS/getLocal.js"></script>

<%
	ChallJoinDTO dto = (ChallJoinDTO)request.getAttribute("challContent");
%>
<style type="text/css">
	.title_hr {
		border: 0;
    	height: 2px;
    	background: #ff4d54;
    	opacity: 100;
    	width: 13%;
	}
	.join_hr {
		border: 0;
    	height: 2px;
    	background: #ff4d54;
    	opacity: 80;
    	width: 40%;
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
   
   		<!-- 로그인하면 넘어오는 세션 값
		session.setAttribute("memberId", dto.getMem_id());
		session.setAttribute("memberName", dto.getMem_name());
		session.setAttribute("memberNum", dto.getMem_num()); -->
		<c:set var="dto" value="${challContent }"/>	<!-- 챌린지 정보 가져옴 -->
		
		<input type="hidden" id="local_num" value="${dto.getChall_num() }">
		<input type="hidden" id="local_title" value="${dto.getChall_title() }">
		<input type="hidden" id="local_image" value="${dto.getChall_mainImage() }">
		
		<div align="center">
			<br>
			<c:choose>
				<c:when test="${dto.getChall_status() eq '진행중'}">
					<h3><b>챌린지 상세 페이지</b></h3>
				</c:when>
				<c:otherwise>
					<h3><b>챌린지 개설 미리보기 페이지</b></h3>
				</c:otherwise>
			</c:choose>
			<hr class="title_hr" color="red">
			<br>
			
			
			<c:choose>
				<c:when test="${dto.getChall_open() eq 'admin'}">
				</c:when>
				<c:otherwise>
					<c:set var="user_dto" value="${userInfo }"/> <!-- 개설자 프사, 개설 챌린지 수, 평점 데이터 가져옴 -->
				</c:otherwise>
			</c:choose>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
			<script type="text/javascript">
				onload = function() {
					moment.lang('ko', {
					    weekdaysShort: ["일","월","화","수","목","금","토"]
					});
					moment.locale("ko");    //한글 날짜 형식으로 지정
					var dto_startDate = ${dto.getChall_startDate()};
					var startDate = moment(dto_startDate,'YYYYMMDD').format("MM.DD (ddd)");
					var dto_duration = ${dto.getChall_duration()};
					var endDate = moment(dto_startDate,'YYYYMMDD').add(dto_duration,'w').format("MM.DD (ddd)");
					$("#startDate").text(startDate); 
					$("#endDate").text(endDate);
				}
			</script>
					<img id="image" height="300" width="300" border="2" src="<%=request.getContextPath()%>/memUpload/${dto.getChall_mainImage() }" class="rounded mx-auto d-block">
					<br>
			<c:choose>
				<c:when test="${dto.getChall_open() eq 'admin'}">
					공식챌린지
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
			
			<h2>${dto.getChall_title() }</h2>
			
			<br>
			<span class="badge rounded-pill text-bg-primary">${dto.getChall_cycle() }</span>
			<span class="badge rounded-pill text-bg-success">${dto.getChall_duration() }주</span><br>
			<span id="startDate"></span> - <span id="endDate"></span>
			
			<br>
			<c:if test="${empty dto.getChall_maxPeople()}"> <!-- 최대 인원 설정 X -->
			현재 : ${dto.getChall_ongoingPeople() }명<br>
			</c:if>
			<c:if test="${!empty dto.getChall_maxPeople()}"> <!-- 최대 인원 설정 O -->
			모집현황 : ${dto.getChall_ongoingPeople() }명 신청중 / ${dto.getChall_maxPeople() }명 모집<br>
			</c:if> 
			
			<c:choose>
				<c:when test="${dto.getChall_open() eq 'admin'}"> <!-- for 제이 / '참가자 후기' 공간 -->
					<br>
					<hr class="join_hr" width="50%" color="red">
					<h4>참가자 후기</h4>
					<button type="button" class="btn btn-dark" onclick="후기 전체보기 경로">후기 모두 보기</button>
				</c:when>
				<c:otherwise>
					<hr class="join_hr" width="50%" color="red">
					<h4>챌린지 리더</h4>
					<img id="image" height="70" width="70" border="2" 
					src="<%=request.getContextPath()%>/memUpload/${user_dto.getMem_img() }" 
					style="border-radius: 50%">
					${user_dto.getMem_id()} <br>
					챌린지개설 : ${user_dto.getChallenge_made_count()}개 / 평점 : ${user_dto.getChallenge_rating()}<br><!-- 챌린지개설 수와 평점 불러오기 -->
				</c:otherwise>
			</c:choose>
			
			<hr class="join_hr" width="50%" color="red">
			<h4>저의 챌린지를 소개해요!</h4>
			<br>
			${dto.getChall_cont() }<br>
			<img src="<%=request.getContextPath()%>/memUpload/${dto.getChall_contImg() }" width="300" height="300"><br>
			<br>
			
			<hr class="join_hr" width="50%" color="red">
			<h4>이렇게 인증 해주세요</h4>
			<br>
			${dto.getChall_guide() }<br><!-- 색깔있는 박스 안에 넣어 돋보이게 해주기 -->
			<br>
			<table>
			  <tr>
			    <td><img id="image1" height="200" width="200" border="2" src="<%=request.getContextPath()%>/memUpload/${dto.getChall_successImage() }" class="rounded mx-auto d-block"></td>
			    <td><img id="image2" height="200" width="200" border="2" src="<%=request.getContextPath()%>/memUpload/${dto.getChall_failImage() }" class="rounded mx-auto d-block"></td>
			  <tr>
			  <tr align="center">
			  	<td>O</td>
			  	<td>X</td>
			  </tr>
			</table>
			
			<br>
			<hr class="join_hr" width="50%" color="red">
			<h4>챌린지 진행 시 꼭 알아주세요!</h4>
			${dto.getChall_regiTimeStart() } ~ ${dto.getChall_regiTimeEnd() } 사이에 인증 하셔야 합니다.<br>
			${dto.getChall_duration() }주 동안 ${dto.getChall_cycle() } 인증샷을 촬영하셔야 합니다.<br>
			
			<hr class="join_hr" width="50%" color="red">
			
			<br><br>
			<c:choose>
				<c:when test="${dto.getChall_status() eq '진행중'}">
					<c:choose>
						<c:when test="${!empty admin_name}"> <!-- (관리자 로그인) -->
							<button type="button" class="btn btn-dark" disabled>(관리자)</button>
						</c:when>
						<c:otherwise> <!-- (회원 로그인) -->
							<c:choose>
								<c:when test="${checkJoin == 1}"> <!-- (회원 로그인) 참가한 챌린지일 때 -->
									<button type="button" class="btn btn-dark" disabled>참가 완료</button>
									<button class="btn btn-dark" onclick="location.href='member_challProof.do'">인증하러 가기</button>
								</c:when>
								<c:otherwise> <!-- (회원 로그인) 참가 안한 챌린지일 때 -->
									<button type="button" class="btn btn-dark" onclick="location.href='member_challJoin_pay.do'">참가하기</button>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-dark" onclick="history.back()">다시 설정하기</button>
					<c:choose>
						<c:when test="${dto.getChall_open() eq 'admin'}">
							<button class="btn btn-danger" onclick="location.href='admin_challJoin_complete.do'">개설하기</button>
						</c:when>
						<c:otherwise>
							<button class="btn btn-danger" onclick="location.href='member_challJoin_pay.do'">참가하기</button>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</div>
		<br>
		<c:choose>
			<c:when test="${dto.getChall_status() eq '진행중'}">
			</c:when>
			<c:otherwise>
		   		<div class="progress">
		  			<div class="progress-bar" role="progressbar" aria-label="Example with label" style="width: 97%;" aria-valuenow="97" aria-valuemin="0" aria-valuemax="100">99 %</div>
				</div>
			</c:otherwise>
		</c:choose>
		<br>
   <jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>