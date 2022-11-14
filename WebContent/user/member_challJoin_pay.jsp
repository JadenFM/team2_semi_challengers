<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제하기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">
onload = function() {
	var payFinal = 0;
	var depositOG = 0;
	var depositMinus = 0;
	
	function pay() {
		depositOG = document.getElementById("depositOG_input").value;
	    document.getElementById("perfect").innerText = depositOG;
	    document.getElementById("85%").innerText = depositOG;
	    document.getElementById("depositOriginalArea").innerText = depositOG;
	    
	    //보유 예치금(${mem_money}) > 참가 예치금(depositOG) => 사용예치금(depositMinus) : 참가예치금(depositOG)
	    //보유 예치금(${mem_money}) < 참가 예치금(depositOG) => 사용예치금(depositMinus) : 보유예치금 전액(${mem_money})
	    if(${mem_money} > depositOG) {
			document.getElementById("depositMinusArea").innerText = "-"+depositOG;
			depositMinus = depositOG;
	    }else {
			document.getElementById("depositMinusArea").innerText = "-"+${mem_money};
			depositMinus = ${mem_money};
	    }
	    payFinal = depositOG - depositMinus;
	    document.getElementById("payFinalArea").innerText = payFinal;
	    if(payFinal == 0) {
	    	document.getElementById("pay_btn").innerText = "보유 예치금으로 바로 참가하기";
	    }else {
		    document.getElementById("pay_btn").innerText = payFinal+"원 결제하기";
	    }
	}
	pay();
	
	$("#depositOG_input").on("change", function() {
		 var n = $(this).val();
	     n = Math.floor(n/10000) * 10000;
	     $(this).val(n);
	     if(Number($(this).val()) > Number(${challContent.getChall_depositMax()})) { // 최대 예치금 제한
	    	 $(this).val(Number(${challContent.getChall_depositMax()}));
	     }
	     if(Number($(this).val()) < Number(${challContent.getChall_depositDefault()})) { // 최소 예치금 제한
	    	 $(this).val(Number(${challContent.getChall_depositDefault()}));
	     }
	     pay();
	});
	
	
	$("#check_module").click(function () {	// 결제 시스템
		
		if(payFinal == 0) {
			location.href = "member_challJoin_pay_ok.do?dpOG="+depositOG+"&dpMi="+depositMinus+"&payF="+payFinal;
	    }else {
			var IMP = window.IMP; // 생략가능
		    IMP.init('imp51311811'); 
		    // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		    // i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
		    IMP.request_pay({
		        pg: 'html5_inicis', // version 1.1.0부터 지원.
		        /* 
		            'kakao':카카오페이, 
		            html5_inicis':이니시스(웹표준결제)
		                'nice':나이스페이
		                'jtnet':제이티넷
		                'uplus':LG유플러스
		                'danal':다날
		                'payco':페이코
		                'syrup':시럽페이
		                'paypal':페이팔
		            */
		        pay_method: 'card',
		        /* 
		            'samsung':삼성페이, 
		            'card':신용카드, 
		            'trans':실시간계좌이체,
		            'vbank':가상계좌,
		            'phone':휴대폰소액결제 
		        */
		        merchant_uid: 'merchant_' + new Date().getTime(),
		        /* 
		            merchant_uid에 경우 
		            https://docs.iamport.kr/implementation/payment
		            위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
		            참고하세요. 
		            나중에 포스팅 해볼게요.
		         */
		        name: '${challContent.getChall_title()} 챌린지 결제',
		        //결제창에서 보여질 이름
		        amount: payFinal,
		        //가격 
		        buyer_email: 'iamport@siot.do',
		        buyer_name: '구매자이름',
		        buyer_tel: '010-1234-5678',
		        buyer_addr: '서울특별시 강남구 삼성동',
		        buyer_postcode: '123-456',
		        m_redirect_url: 'https://www.yourdomain.com/payments/complete'
		        /*  
		            모바일 결제시,
		            결제가 끝나고 랜딩되는 URL을 지정 
		            (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐) 
		            */
		    }, function (rsp) {
		        console.log(rsp);
		        if (rsp.success) {
		            var msg = '결제가 완료되었습니다.';
		            msg += '고유ID : ' + rsp.imp_uid;
		            msg += '상점 거래ID : ' + rsp.merchant_uid;
		            msg += '결제 금액 : ' + rsp.paid_amount;
		            msg += '카드 승인번호 : ' + rsp.apply_num;
		        } else {
		            var msg = '결제에 실패하였습니다.';
		            msg += '에러내용 : ' + rsp.error_msg;
		        }
		        alert(msg);
		        location.href = "member_challJoin_pay_ok.do?dpOG="+depositOG+"&dpMi="+depositMinus+"&payF="+payFinal;
		    });
	    }
	});	// 결제 시스템 end
	
}
</script>
<style type="text/css">
	.join_hr {
		border: 0;
    	height: 1px;
    	background: #ff4d54;
    	opacity: 100;
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
			${challContent.getChall_title()}
			<hr class="join_hr" width="20%" color="red">
			<br>
			<h5><b>예치금</b></h5>
			<p>챌린지 시작 전에 돈을 걸고 종료 후 돌려드려요!</p>
			
			<br>
			<c:if test="${empty challContent.getChall_depositMax()}"> <!-- 고정예치금 O -->
			<input type="number" id="depositOG_input" value="${challContent.getChall_depositDefault()}" readonly>원(고정)
			</c:if>
			<c:if test="${!empty challContent.getChall_depositMax()}"> <!-- 고정예치금 X -->
			<p>예치금 : 최소 <fmt:formatNumber value="${challContent.getChall_depositDefault()}"/>원 ~ 
			최대 <fmt:formatNumber value="${challContent.getChall_depositMax()}"/>원(1만원 단위 가능)</p>
			<input type="number" id="depositOG_input" step="10000" max="${challContent.getChall_depositMax()}">원
			</c:if>
			<hr class="join_hr" width="20%" color="red">
			<fieldset>
				<div>
					<span>100% 성공</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="perfect"></span>원+상금<br>
					<span>85% 이상 성공</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="85%"></span>원<br>
					<span>85% 미만 성공</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>예치금 일부 환급(성공률 만큼)</span>
				</div>
			</fieldset>
			
			<br><br>
			<fieldset>
				<legend>예치금 충전 및 결제</legend>
				<div>
					<span>참가 예치금</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="depositOriginalArea"></span>원<br>
					<span>사용 예치금</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="depositMinusArea"></span>원<br>
					<span>(현재 보유 예치금:</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>${mem_money}</span>원)<br>
					<span>충전 금액</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="payFinalArea"></span>원<br>
				</div>
			</fieldset>
		
			<br>
			<button type="button" class="btn btn-dark" onclick="history.back()">이전</button>
			<button id="check_module" class="btn btn-danger"><span id="pay_btn"></span></button>
		</div>
	<jsp:include page="/include/chall_bottom.jsp" />
</body>
</html>