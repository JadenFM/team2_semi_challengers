<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%
		int mem_num = (int)session.getAttribute("memberNum");
	%>

	<jsp:include page="../include/chall_top.jsp" />
	<jsp:include page="../include/CS_top.jsp" />
	
	<script type="text/javascript">
						
			$(function(){
			
				function getPraviteQList() {
					$.ajax({
						url : "<%= request.getContextPath()%>/CS_privateQ_list.do",
						data : {
							pq_user_no : <%= mem_num%>,
						},
						datatype: "xml",
						success : function(data){
							
							let result = "";
							let answerStatus = "";
							let answer = "";
							
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
								
								result += "<div class='question'><span>"+$(this).find("num").text()+"</span>"				
								result += "<span>"+$(this).find("title").text()+"</span>"
								result += "<span>"+$(this).find("regdate").text().substring(0,10)+"</span>"
								result += "<span>"+answerStatus + "</span></div>"
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
				
				getPraviteQList();
				
			}); // $(document).ready(function(){}) 끝
			
			</script>
			
			<table class="full_table">
				<tr class="contentTitle">
					<td colspan="2">
						<h1>일대일문의</h1>
						<hr>
					</td>
				</tr>
			</table>
			<div id = "PQ_content">
				<div id="PQ_table_th">
					<span>접수번호</span>
					<span>문의</span>
					<span>등록일</span>
					<span>상태</span>
				</div>
				
				<div id="PQ_Accordian_wrap">
					<div align ="center">
					<p><span>아직 일대일 문의를 등록하지 않으셨네요!</span></p>
					<p><span>오른쪽 하단의 문의하기 버튼을 이용해주세요.</span></p>
					</div>
				</div>
			</div>
			
			
			
			<script>
				function pqWrite(){
					
					console.log('plz~~~');
					
					$.ajax({
						url : "<%= request.getContextPath()%>/CScenter/CS_pq_write.jsp",
						data : {
							pq_user_no : <%= mem_num%>
						},
						datatype : "html",
						success : function(data) {
							$("#PQ_content").html(data);
							$("#PQ_write_button").remove();
						},
						error : function() {
							toastr.warning('데이터 통신 에러');
						}
					});
				
				}
				
			</script>
			
			<div id="PQ_write_button">
				<button onclick="pqWrite()">문의하기</button>
			</div>
			
			
			
			
	<jsp:include page="../include/CS_bottom.jsp" />
	<jsp:include page="../include/chall_bottom.jsp" />