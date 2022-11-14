<%@page import="java.util.List"%>
<%@page import="com.chall.model.ChallJoinDTO"%>
<%@page import="com.chall.model.ChallProofDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
	int remainProof_count = (int)diffDays - proof_count;
	System.out.println("남은 인증 횟수 >>>"+remainProof_count);
	
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd(E)");
	String startDate2 = simpleDateFormat.format(startDate_format); 		// ★시작일(출력용)
	String endDate2 = simpleDateFormat.format(endDate_format); 			// ★종료일(출력용)
	
	SimpleDateFormat todayCheckDateFormat = new SimpleDateFormat("yy/MM/dd");
	String today = todayCheckDateFormat.format(new Date());					// ★오늘 날짜
	pageContext.setAttribute("Today", today);
	System.out.println("오늘 날짜 >>>"+today);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>챌린지 인증페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script type="text/javascript">
	// modal 창 관련
	/* const myModal = document.getElementById('myModal')
	const myInput = document.getElementById('myInput')
	
	myModal.addEventListener('shown.bs.modal', () => {
	  myInput.focus()
	}) */
	// modal 창 관련 끝
	
	onload = function() {
		moment.locale("ko");    //한글 날짜 형식으로 지정
		var dto_startDate = ${dto.getChall_startDate()};
		var startDate = moment(dto_startDate,'YYYYMMDD').format("YYYY.MM.DD (ddd)");
		var dto_duration = ${dto.getChall_duration()};
		var endDate = moment(dto_startDate,'YYYYMMDD').add(dto_duration,'w').format("YYYY.MM.DD (ddd)");
		$("#startDate").text(startDate); 
		$("#endDate").text(endDate);
	}
	
	function previewFile1() { 
        var preview = document.querySelector('#image_proof'); 
        var file = document.querySelector('#proof_image_input').files[0]; 
        var reader  = new FileReader(); 
        reader.onloadend = function () {
              preview.src = reader.result; 
       } 
       if (file) {
             reader.readAsDataURL(file); 
       } else {
             preview.src = ""; 
       } 
    }
</script>
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

</style>
</head>
<body>
   <jsp:include page="/include/chall_top.jsp" />
   
   		<!-- 로그인하면 넘어오는 세션 값
		session.setAttribute("memberId", dto.getMem_id());
		session.setAttribute("memberName", dto.getMem_name());
		session.setAttribute("memberNum", dto.getMem_num()); -->
		
		<!-- ChallProof서블릿에서 넘어오는 값
		"challContent"
		"ProofList" -->
		
		<div align="center">
			<br>
				<h3><b>챌린지 인증 페이지</b></h3>
			<hr class="join_hr" width="50%" color="red">
			<br>
			
			<img id="image" height="300" width="300" border="2" src="<%=request.getContextPath()%>/memUpload/${challContent.getChall_mainImage() }" class="rounded mx-auto d-block">
			<br>
			
			<br>
			<h2>${challContent.getChall_title() }</h2>
			
			<br>
			<br>
			
			<br>
			${challContent.getChall_cycle() }, ${challContent.getChall_duration() }주 동안<br>
			<%=startDate2 %> - <%=endDate2 %><br>
			인증가능 시간 : ${challContent.getChall_regiTimeStart() }~${challContent.getChall_regiTimeEnd() }
			<br>
			
			
			<hr class="join_hr" width="50%" color="red">
			
		   	<!-- Button trigger 인증방법 modal -->
			<button id="proofGuide" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#proofGuideModal">
			  인증방법
			</button>
			
			<!-- 인증방법 Modal 창 시작-->
			<div class="modal fade" id="proofGuideModal" tabindex="-1" aria-labelledby="proofGuideModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="proofGuideModalLabel">인증규정</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        <table>
					  <tr>
					    <td><img id="image1" height="200" width="200" border="2" src="<%=request.getContextPath()%>/memUpload/${challContent.getChall_successImage() }" class="rounded mx-auto d-block"></td>
					    <td><img id="image2" height="200" width="200" border="2" src="<%=request.getContextPath()%>/memUpload/${challContent.getChall_failImage() }" class="rounded mx-auto d-block"></td>
					  <tr>
					  <tr align="center">
					  	<td>O</td>
					  	<td>X</td>
					  </tr>
					</table>
					<br>
			      	${challContent.getChall_guide() }
					<br>
					<hr class="join_hr" width="50%" color="red">
					<h4>챌린지 진행 시 꼭 알아주세요!</h4>
					${challContent.getChall_regiTimeStart() } ~ ${challContent.getChall_regiTimeEnd() } 사이에 인증 하셔야 합니다.<br>
					${challContent.getChall_duration() }주 동안 ${challContent.getChall_cycle() } 인증샷을 촬영하셔야 합니다.<br>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-dark" data-bs-dismiss="modal">확인했어요!</button>
			      </div>
			    </div>
			  </div>
			</div>
			<!-- 인증방법 Modal 창 끝-->
			
		    
		    <!-- Button trigger 환급규정 modal -->
			<button id="refundRule" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#refundRuleModal">
			  챌린지 환급 규정
			</button>
			
			<!-- 환급규정 Modal 창 시작-->
			<div class="modal fade" id="refundRuleModal" tabindex="-1" aria-labelledby="refundRuleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="refundRuleModalLabel">챌린지 환급 안내</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        <span>100% 성공</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>예치금 전액 환급 + 상금</span><br>
			        <span>85% 성공</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>예치금 전액 환급</span><br>
			        <span>85% 미만 성공</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>예치금 일부 환급(성공률 만큼)</span><br>
			        <hr class="join_hr" width="50%" color="red">
			        ● 상금은 85% 미만 성공한 참가자들의 벌금으로 마련돼요.<br>
			        ● 최종 상금은 내가 건 돈에 비례해서 정해져요. 그래서 예치금이 많을수록 상금도 높아져요!<br>
			        ● 인증을 놓쳤을 때는 인증패스를 사용해서 만회할 수 있어요. 단, 인증패스를 사용해서 100% 성공한 경우 공정성을 위해 상금은 받을 수 없어요.
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-light" data-bs-dismiss="modal">확인</button>
			      </div>
			    </div>
			  </div>
			</div>
			<!-- 환급규정 Modal 창 끝-->
		    
		    <c:choose>
				<c:when test="${challContent.getChall_open() eq 'private'}">
					<!-- Button trigger 비공개 참여 코드 modal -->
					<button id="privateCode" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#privateCodeModal">
					  비공개 참여 코드
					</button>
					
					<!-- 비공개 참여 코드 Modal 창 시작-->
					<div class="modal fade" id="privateCodeModal" tabindex="-1" aria-labelledby="privateCodeModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="privateCodeModalLabel">비공개 참여 코드</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					        <span>${challContent.getChall_privateCode()}</span>
					        <hr class="join_hr" width="50%" color="red">
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-light" data-bs-dismiss="modal">확인</button>
					      </div>
					    </div>
					  </div>
					</div>
					<!-- 비공개 참여 코드 Modal 창 끝-->
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
			
			<hr class="join_hr" width="50%" color="red">
			<h4>나의 인증 현황</h4>
			<br>
			<span>현재 달성률</span><br>
			<span><%=achv_rate%>%</span>
			<div class="progress">
			  <div class="progress-bar bg-danger" role="progressbar" aria-label="Danger example" style="width: <%=achv_rate%>%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
			</div>
			<span>현재 확보한 예치금</span><br>
			<span><%=gained_deposit%>원</span><br>
			<span>걸어둔 예치금</span><br>
			<span><%=Ch_deposit_SC%>원</span>
			<br>
			<hr class="join_hr" width="50%" color="red">
			<br>
			<span>인증 성공</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>남은 인증</span><br>
			<span><%=proof_count%>회</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><%=remainProof_count%>회</span>
			<hr class="join_hr" width="50%" color="red">
			<br>
			
			<h4>나의 인증샷</h4>
			
			<table>
			<tr>
			<c:if test="${!empty ProofList}">
				<c:forEach items="${ProofList }" var="dto" varStatus="i" begin="0">
						<c:choose>
							<c:when test="${(i.index%3) == 0}">
								</tr>
								<tr>
							    	<td><img id="image1" height="200" width="200" border="2" src="<%=request.getContextPath()%>/ProofUpload/${dto.getProof_image() }" class="rounded mx-auto d-block"></td>
							</c:when>
							<c:otherwise>
						    	<td><img id="image1" height="200" width="200" border="2" src="<%=request.getContextPath()%>/ProofUpload/${dto.getProof_image() }" class="rounded mx-auto d-block"></td>
							</c:otherwise>
						</c:choose>
				</c:forEach>
			</c:if>
			</tr>
			</table>
			
			<br><br>
			
			<c:choose>
				<c:when test="${LastDate == Today}">
					<button type="button" class="btn btn-dark" disabled>인증 완료</button>
				</c:when>
				<c:otherwise>
					<!-- <button type="button" class="btn btn-dark" onclick="">인증하기</button> -->
					
					<!-- Button trigger 인증하기 modal -->
					<button id="uploadProofShot" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#uploadProofShotModal">
					인증하기
					</button>
					
					<!-- 인증하기 Modal 창 시작-->
					<div class="modal fade" id="uploadProofShotModal" tabindex="-1" aria-labelledby="uploadProofShotModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="uploadProofShotModalLabel">인증샷 올리기</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <form id="form" method="post" enctype="multipart/form-data" action="member_challProofOk.do">
					      <div class="modal-body"> <!-- 내용 부분 시작 -->
					        <input type='text' name="proof_img" id='proof_img' style='display: none;'> 
							<img id="image_proof" src='<%=request.getContextPath()%>/uploadFile/proof_shot_upload.jpg' height="300" width="300" border="2" onclick='document.all.proofImgFile.click(); document.all.proof_img.value=document.all.proofImgFile.value' class="rounded mx-auto d-block">
							<input type="file" name="proofImgFile" id="proof_image_input" accept="image/jpg, image/jpeg, image/png, image/gif"
							  	onchange="previewFile1()" style='display: none;'>
					      </div>
					      <div class="modal-footer"> <!-- 내용 부분 끝 -->
					        <button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
					        <button type="submit" class="btn btn-primary">인증하기</button>
					      </div>
					      </form>
					    </div>
					  </div>
					</div>
					<!-- 인증하기 Modal 창 끝-->
					
				</c:otherwise>
			</c:choose>
			<button class="btn btn-dark" onclick="location.href='member_challContent.do'">챌린지 소개 페이지가기</button>
		</div>
		<br>
		<br>
   <jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>