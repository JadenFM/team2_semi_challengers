<%@page import="com.cs.model.Q_categoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.cs.model.CScenterDAO"%>
<%@page import="com.user.model.UserDTO"%>
<%@page import="com.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	int userNum = Integer.parseInt(request.getParameter("pq_user_no").trim());
	UserDAO dao = UserDAO.getinstance();
	UserDTO dto = dao.getMemberInfo(userNum);
	
	CScenterDAO csdao = CScenterDAO.getinstance();
	List<Q_categoryDTO> qcatelist = csdao.getQ_categoryList();
	
	 
	int mem_num = (int)session.getAttribute("memberNum");

	int rowsize = 5;
	int block = 3;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>


<div>
	<c:set value="<%=dto %>" var="userInfo"/>
	<c:set value="<%=qcatelist %>" var="qcatelist" />

	<div>
		<div><span style="font-weight: bold;">${userInfo.getMem_name() }</span>님의 문의입니다.
		<input type="hidden" id="pq_user_no" value="${userInfo.getMem_num() }"></div>

		<div id="pq_regdate">
		<span>등록일</span>
		<span></span>
		</div>
		<br>

	
		<div>
		<span>문의유형</span>&nbsp;<span style="color:red;">*</span><br>
		<select id="pq_cate" class="form-select" aria-label="Default select example">
			<option selected>문의 유형을 선택해주세요.</option>
			<c:forEach var="qcate" items="${qcatelist }">
				<option value="${qcate.getQ_category_num()}">${qcate.getQ_category_type()}</option>
			</c:forEach>
		</select>
		</div>
		<br>

			
		<div id="newbox">
			<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/insert_report.do">
				<input type="hidden" name="report_mem_id" value="${userInfo.getMem_id() }">
				<div>
					<span>제목</span> <input class="form-control" id="report_title" name="report_title">
				</div>

				<br>

				<div>
					<span>회원 아이디 또는 이름</span> <input class="form-control" id="report_member"
						name="report_member" placeholder="신고할 회원의 아이디 또는 이름을 입력해 주십시오.">
				</div>

				<br>

				<div>
					<span>사유 선택</span> <select class="form-control" id="report_cause" name="report_cause">
						<option value="부적절한 홍보 게시물">부적절한 홍보 게시물</option>
						<option value="음란성 또는 부적합한 내용">음란성 또는 부적합한 내용</option>
						<option value="기타">기타</option>
					</select>
				</div>
				
				<br>
				
				<div>
					<span>이미지</span>
					<input type="file" class="form-control" id="report_image" name="report_image">
				</div>

				<br>

				<div>
					<span>상세내용</span> <input class="form-control" id="report_content" name="report_content">
				</div>
				<br>
				<div align="center" class="d-grid gap-2 d-md-flex justify-content-md-end">

				<input class="btn btn-primary" id="reportbtn" type="submit" value="신고하기" onclick="report()">
				<input class="btn btn-outline-primary" type="button" value="취소">
				</div>
			</form>
		</div>
    
		<br>
		

		<div id="oldbox">
      <div>
      <span>제목</span>&nbsp;<span style="color:red;">*</span><br>
      <input class="form-control" type="text" id="pq_title"  style="width:100%;">
      </div>
      <br>
		
      <div>
      <span>내용</span>&nbsp;<span style="color:red;">*</span><br>
      <textarea class="form-control" id="pq_content" rows="10" cols="100"></textarea>
      </div>
      <br>
      <div align="center" class="d-grid gap-2 d-md-flex justify-content-md-end">
        <button class="btn btn-primary" onclick="insertPQ()">등록</button>
        <button id="pq_write_cancel" class="btn btn-outline-primary" onclick="cancelPQ()">취소</button>
      </div>
		<!-- 컨펌창 모달 -->
			<div id="confirm_modal" class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="staticBackdropLabel">작성한 내용이 모두 사라집니다.</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        정말 취소하시겠습니까?
			      </div>
			      <div class="modal-footer">
			        <button id="cancel_confirm_yes" type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
			        <button id="cancel_confirm_no" type="button" class="btn btn-outline-primary">취소</button>
			      </div>
			    </div>
			  </div>
			</div>
		<!-- 모달 끝 -->
	</div>
      
		</div>
</div>

<script type="text/javascript">

$(function(){
	let selected_pq_cate = "";
	let today = "";
});

today = new Date().toISOString().substring(0, 10);
console.log("오늘 날짜 >>> "+today);
document.querySelector("#pq_regdate span:nth-child(2)").innerHTML = today;

$("#newbox").hide();

$("#pq_cate").change(function(){
	selected_pq_cate = $(this).val();
	
	if ( selected_pq_cate == 4) {
		$("#newbox").show();
		$("#oldbox").hide();
	}else{
     $("#newbox").hide();
		$("#oldbox").show();
	}
});


function getPQList(page){
	
	if (<%=mem_num%> == 0){
		toastr.warning('로그인이 필요합니다.');
		setTimeout(function(){
			$(location).attr('href', "<%=request.getContextPath() %>/member_login.do");
		}, 1200);
	}else {
		
		$.ajax({
			url : "<%=request.getContextPath()%>/CS_PQ_list.do?page="+page,
			data : {
				mem_num : <%=mem_num%>
			},
			datatype : "html",
			success : function(data){
				$("#CS_content").empty();
				$("#CS_content").html(data);
			},
			error : function(){
				toastr.warning('데이터 통신 에러');
			}
		});
		
	}

} // getFAQ() 끝


function insertPQ(){
	
	$.ajax({
		url : "/Semi_Challengers/CS_privateQ_insert.do",
		data : {
			pq_user_num : $("#pq_user_no").val(),
			pq_title : $("#pq_title").val(),
			pq_content : $("#pq_content").val(),
			pq_cate_no : selected_pq_cate
		},
		datatype : "text",
		success : function(data){
			if (data > 0) {
				toastr.success('일대일문의가 등록되었습니다');
				getPQList(1);
			}else {
				toastr.error('필수 사항을 모두 입력해주세요.');
			}
		},
		error : function(){
			toastr.warning('데이터 통신 에러');
		}
		
	});
} // function insertPQ() 끝


function cancelPQ(){
	$("#pq_write_cancel").click(function(){
		$("#confirm_modal").modal("show");
		
		$("#cancel_confirm_yes").click(function(){
			$("#confirm_modal").modal("hide");
			getPQList(1);
		});
		$("#cancel_confirm_no").click(function(){
			$("#confirm_modal").modal("hide");
			return;
		});
	});
	
} // function cacelPQ() 끝



</script>

</body>
</html>