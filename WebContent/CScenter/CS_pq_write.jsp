<%@page import="java.util.List"%>
<%@page import="com.cs.model.CScenterDAO"%>
<%@page import="com.cs.model.Q_categoryDTO"%>
<%@page import="com.user.model.UserDTO"%>
<%@page import="com.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
	int userNum = Integer.parseInt(request.getParameter("pq_user_no").trim());
	UserDAO dao = UserDAO.getinstance();
	UserDTO dto = dao.getMemberInfo(userNum);
	
	CScenterDAO csdao = CScenterDAO.getinstance();
	List<Q_categoryDTO> qcatelist = csdao.getQ_categoryList();
%>
    
<!-- <div id="alert">
	<div class="wrap">
		<div><i class="bi bi-exclamation-triangle"></i></div>
		<div>내용</div>
	</div>
</div> -->
    
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
					<span>제목</span> <input id="report_title" name="report_title">
				</div>

				<br>

				<div>
					<span>회원 아이디 또는 이름</span> <input id="report_member"
						name="report_member" placeholder="신고할 회원의 아이디 또는 이름을 입력해 주십시오.">
				</div>

				<br>

				<div>
					<span>사유 선택</span> <select id="report_cause" name="report_cause">
						<option value="부적절한 홍보 게시물">부적절한 홍보 게시물</option>
						<option value="음란성 또는 부적합한 내용">음란성 또는 부적합한 내용</option>
						<option value="기타">기타</option>
					</select>
				</div>
				
				<br>
				
				<div>
					<span>이미지</span>
					<input type="file" id="report_image" name="report_image">
				</div>

				<br>

				<div>
					<span>상세내용</span> <input id="report_content" name="report_content">
				</div>

				<input id="reportbtn" type="submit" value="신고하기" onclick="report()">
				<input type="button" value="취소" onclick="if(confirm('정말 취소하시겠습니까? 작성한 내용이 모두 사라집니다.')){ location.href='CS_privateQ.do' } else { return; }">
				
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

<script>

let today = new Date().toISOString().substring(0, 10);
console.log("오늘 날짜 >>> "+today);
document.querySelector("#pq_regdate span:nth-child(2)").innerHTML = today;

	let selected_pq_cate = "";
	
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

	function getPraviteQList() {
		$.ajax({
			url : "<%= request.getContextPath()%>/CS_privateQ_list.do",
			data : {
				pq_user_no : ${userInfo.getMem_num() }
			},
			datatype: "xml",
			success : function(data){
				
				let result = "";
				let table = "";
				let answerStatus = "";
				let answer = "";
				
				table = "<div id = 'PQ_content'><div id='PQ_table_th'>"
					+"<span>접수번호</span>"
					+"<span>문의</span>"
					+"<span>등록일</span>"
					+"<span>상태</span>"
					+"</div><div id='PQ_Accordian_wrap'>"
					+"<div align ='center'>"
					+"<p><span>아직 일대일 문의를 등록하지 않으셨네요!</span></p>"
					+"<p><span>오른쪽 하단의 문의하기 버튼을 이용해주세요.</span></p>"
					+"</div></div></div>"
					+"<div id='PQ_write_button'>"
					+"<button onclick='pqWrite()' class='btn btn-primary'>문의하기</button></div>"
				
				$("#PQ_content").empty();
				$("#PQ_content").append(table);
				
				if ($(data).find("regdate").text() != null){
					$("#PQ_Accordian_wrap").empty();
				}
				$(data).find("PQNA").each(function(){
					
					if($(this).find("answerCont").text() == "null") {
							answerStatus = "<font color='#bd3232'>접수중</font>";
							answer = "<p>안녕하세요, 챌린저스입니다.</p>"
							+ "<p>고객님의 일대일 문의가 접수되었습니다.</p>"
							+ "<p>담당자가 확인하여 답변을 작성 중에 있습니다.</p>"
							+ "<p>빠르게 답변드릴 수 있도록 노력하겠습니다.</p>"
							+ "<p>감사합니다.</p>";
							
						}else if($(this).find("answerCont").text() != "null") {
							answerStatus = "<font color='#324bbd'>답변완료</font>";
							answer = "답변 등록일 : "+$(this).find("answerRegdate").text().substring(0, 10)+"<br><br>"+$(this).find("answerCont").text();
						}
					
					result +=  "<div class='question'><span>"+$(this).find("num").text()+"</span>"				
					result +=  "<span>"+$(this).find("title").text()+"</span>"
					result +=  "<span>"+$(this).find("regdate").text().substring(0,10)+"</span>"
					result +=  "<span>"+answerStatus + "</span></div>"
					result += "<div class='answer'>"+"<span>"+$(this).find("content").text()+"</span>"+"<br><br>"+
								"<div><span>"+answer+"</span></div>"+"</div>";
					
				});
				
				$("#PQ_Accordian_wrap").append(result);
				
				$(".question").click(function(){
					if ($(this).hasClass('show')){
						$(this).next(".answer").slideUp(200);
						$(this).removeClass('show');
					}else {
						$(this).next(".answer").stop().slideDown(200);
						$(this).addClass('show');
					}
				});
				
				
			},
			error : function(){
				toastr.warning('데이터 통신 에러');
			}
		}); // ajax 끝
	} // function getPraviteQList(); 끝 
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
					getPraviteQList();
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
				location.href="CS_privateQ.do";
			});
			$("#cancel_confirm_no").click(function(){
				$("#confirm_modal").modal("hide");
				return;
			});
		});
		
	} // function cacelPQ() 끝
	
</script>

