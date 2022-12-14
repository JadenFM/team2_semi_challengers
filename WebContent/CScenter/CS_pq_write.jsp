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
	
	 
	int mem_num = (int)session.getAttribute("memberNum");

	int rowsize = 5;
	int block = 3;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<!-- toastr -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript" src="../searchJS/location.js"></script>
<script type="text/javascript" src="searchJS/location.js"></script>
<!-- bootstrp -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

<!-- js & css -->
<link rel="stylesheet" href="CScenter/CScenter.css?a">
</head>
<body>

<div>
	<c:set value="<%=dto %>" var="userInfo"/>
	<c:set value="<%=qcatelist %>" var="qcatelist" />

	<div>
		<div><span style="font-weight: bold;">${userInfo.getMem_name() }</span>?????? ???????????????.
		<input type="hidden" id="pq_user_no" value="${userInfo.getMem_num() }"></div>

		<div id="pq_regdate">
		<span>?????????</span>
		<span></span>
		</div>
		<br>

	
		<div>
		<span>????????????</span>&nbsp;<span style="color:red;">*</span><br>
		<select id="pq_cate" class="form-select" aria-label="Default select example">
			<option selected>?????? ????????? ??????????????????.</option>
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
					<span>??????</span> <input id="report_title" name="report_title">
				</div>

				<br>

				<div>
					<span>?????? ????????? ?????? ??????</span> <input id="report_member"
						name="report_member" placeholder="????????? ????????? ????????? ?????? ????????? ????????? ????????????.">
				</div>

				<br>

				<div>
					<span>?????? ??????</span> <select id="report_cause" name="report_cause">
						<option value="???????????? ?????? ?????????">???????????? ?????? ?????????</option>
						<option value="????????? ?????? ???????????? ??????">????????? ?????? ???????????? ??????</option>
						<option value="??????">??????</option>
					</select>
				</div>
				
				<br>
				
				<div>
					<span>?????????</span>
					<input type="file" id="report_image" name="report_image">
				</div>

				<br>

				<div>
					<span>????????????</span> <input id="report_content" name="report_content">
				</div>

				<input id="reportbtn" type="submit" value="????????????" onclick="report()">
				<input type="button" value="??????">
				
			</form>
		</div>
    
		<br>
		

		<div id="oldbox">
      <div>
      <span>??????</span>&nbsp;<span style="color:red;">*</span><br>
      <input class="form-control" type="text" id="pq_title"  style="width:100%;">
      </div>
      <br>
		
      <div>
      <span>??????</span>&nbsp;<span style="color:red;">*</span><br>
      <textarea class="form-control" id="pq_content" rows="10" cols="100"></textarea>
      </div>
      
      <div align="center" class="d-grid gap-2 d-md-flex justify-content-md-end">
        <button class="btn btn-primary" onclick="insertPQ()">??????</button>
        <button id="pq_write_cancel" class="btn btn-outline-primary" onclick="cancelPQ()">??????</button>
      </div>
		<!-- ????????? ?????? -->
			<div id="confirm_modal" class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="staticBackdropLabel">????????? ????????? ?????? ???????????????.</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        ?????? ?????????????????????????
			      </div>
			      <div class="modal-footer">
			        <button id="cancel_confirm_yes" type="button" class="btn btn-primary" data-bs-dismiss="modal">??????</button>
			        <button id="cancel_confirm_no" type="button" class="btn btn-outline-primary">??????</button>
			      </div>
			    </div>
			  </div>
			</div>
		<!-- ?????? ??? -->
	</div>
      
		</div>
</div>

<script>

let today = new Date().toISOString().substring(0, 10);
console.log("?????? ?????? >>> "+today);
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

	function getPrivateQList(page) {
		
		if (page == null){
			page = 1;
		}
		
		$.ajaxSetup({
			ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type : "post"								
		}); // ajaxSetup ???
		
		$.ajax({
			url : "<%= request.getContextPath()%>/CS_privateQ_list.do?page="+page,
			async : false,
			data : {
				pq_user_no : <%= mem_num%>,
				rowsize : <%= rowsize %>,
				block : <%= block %>
			},
			datatype: "xml",
			success : function(data){
				
				$("#paging").empty();
				
				let result = "";
				let answerStatus = "";
				let answer = "";
				
				if ($(data).find("regdate").text() != null){
						$("#PQ_Accordian_wrap").empty();
					}
				
				$(data).find("PQNA").each(function(){
					
					if($(this).find("answerCont").text() == "null") {
							answerStatus = "<font color='#bd3232'>?????????</font>";
							answer = "<p>???????????????, ?????????????????????.</p>"
							+ "<p>???????????? ????????? ????????? ?????????????????????.</p>"
							+ "<p>???????????? ???????????? ????????? ?????? ?????? ????????????.</p>"
							+ "<p>????????? ???????????? ??? ????????? ?????????????????????.</p>"
							+ "<p>???????????????.</p>";
							
						}else if($(this).find("answerCont").text() != "null") {
							answerStatus = "<font color='#324bbd'>????????????</font>";
							answer = "?????? ????????? : "+$(this).find("answerRegdate").text().substring(0, 10)+"<br><br>"+$(this).find("answerCont").text();
						}
					
					result += "<div class='question'><span>"+$(this).find("num").text()+"</span>";				
					result += "<span>"+$(this).find("title").text()+"</span>";
					result += "<span>"+$(this).find("regdate").text().substring(0,10)+"</span>";
					result += "<span>"+answerStatus + "</span></div>";
					result += "<div class='answer'>"+"<span>"+$(this).find("content").text()+"</span>"+"<br><br>"+
								"<div><span>"+answer+"</span></div>"+"</div>";
					
					
				});
				
				console.log("ajax success page ??? >>> "+page);
				let block = <%=block %>;
				console.log("ajax success block ??? >>> "+block);
				let allPage = $(data).find("allPage").text();
				console.log("ajax success allPage ??? >>> "+allPage);
				let startNo = $(data).find("startNo").text();
				console.log("ajax success startNo ??? >>> "+startNo);
				let endNo = $(data).find("endNo").text();
				console.log("ajax success endNo ??? >>> "+endNo);
				let startBlock = $(data).find("startBlock").text();
				console.log("ajax success startBlock ??? >>> "+startBlock);
				let endBlock = $(data).find("endBlock").text();
				console.log("ajax success endblock ??? >>> "+endBlock);
				
				let pagination = "<ul class='pagination'>";
				
				if (page > block){
					pagination += "<li id='goFirstPage'><a class='page-link' href='#' onclick='getPrivateQList(1)'><i class='bi bi-chevron-double-left'></i></a></li>";
					pagination += "<li id='goPrevPage'><a class='page-link' href='#' onclick='getPrivateQList("+startBlock+"-1)'><i class='bi bi-chevron-left'></i></a></li>";
				}
				
				for (var i = startBlock; i <= endBlock; i++){
					if (i == page){
						pagination += "<li class='page-item active' aria-current='page'><a class='page-link' href='#' onclick='getPrivateQList("+i+")'>"+i+"</a></li>";
					}else {
						pagination += "<li class='page-item' aria-current='page'><a class='page-link' href='#' onclick='getPrivateQList("+i+")'>"+i+"</a></li>";
					}
				}
				
				if (endBlock < allPage){
					pagination += " <li id='goNextPage'><a class='page-link' href='#' onclick='getPrivateQList("+endBlock+"+1)'><i class='bi bi-chevron-right'></i></a></li>";
					pagination += "<li id='goLastPage'><a class='page-link' href='#' onclick='getPrivateQList("+allPage+")'><i class='bi bi-chevron-double-right'></i></a></li>";
				}
				
				$("#PQ_Accordian_wrap").append(result);
				$("#paging").append(pagination);
				
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
				toastr.warning('????????? ?????? ??????');
			}
			
		}); // ajax ???

	} // function getPraviteQList(); ??? 
	
	
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
					toastr.success('?????????????????? ?????????????????????');
					getPrivateQList(1);
				}else {
					toastr.error('?????? ????????? ?????? ??????????????????.');
				}
			},
			error : function(){
				toastr.warning('????????? ?????? ??????');
			}
			
		});
	} // function insertPQ() ???
	

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
		
	} // function cacelPQ() ???
	
</script>

</body>
</html>