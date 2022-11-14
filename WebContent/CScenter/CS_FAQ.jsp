<%@page import="com.cs.model.FAQDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
   <% pageContext.setAttribute("replaceEnter", "\n"); %>
	
	<jsp:include page="../include/chall_top.jsp" />
	<jsp:include page="../include/CS_top.jsp" />


			<table class="full_table">
				<tr class="contentTitle">
					<td colspan="2">
						<h1>FAQ</h1>
						<div style="text-align :right">
		<span>검색 &nbsp; <input type="text" class="form-control" style="display: inline-block; width:25%;"></span>
	</div>
						<hr>
					</td>
				</tr>
				<tr>
					<td>
						<nav>
							<ul class="FAQ_menu">
								<li class="FAQ_cate" value="0">전체</li>
								<li class="FAQ_cate" value="1">인증</li>
								<li class="FAQ_cate" value="2">결제</li>
								<li class="FAQ_cate" value="3">상금</li>							
							</ul>
						</nav>
					</td>
				</tr>
				
				<c:set value="${FAQList}" var="list" />
				<c:if test="${!empty list }">
					<c:forEach items="${list }" var="dto">
						<tr>
						<td>
							<c:choose>
								<c:when test="${dto.getFAQ_category_num() == 1}">
									<div class="FAQ_cate_proof">
										<div class="question">
											<span class="q_cate">[인증]</span>
											<span class="q_title">${dto.getFAQ_title() }</span>
											<div class="q_arrow-wrap">
												<div class="q_arrow-top">
													<i class="bi bi-arrow-up"></i>
												</div>
												<div class="q_arrow-bottom">
													<i class="bi bi-arrow-down"></i>
												</div>
											</div>
										</div>
										
										<div class="answer">
											<span>
												${fn:replace(dto.getFAQ_content(), replaceEnter, "<br/>") }
											</span>
										</div>
									</div>
								</c:when>
								<c:when test="${dto.getFAQ_category_num() == 2}">
									<div class="FAQ_cate_pay">
										<div class="question">
											<span class="q_cate">[결제]</span>
											<span class="q_title">${dto.getFAQ_title() }</span>
											<div class="q_arrow-wrap">
												<div class="q_arrow-top">
													<i class="bi bi-arrow-up"></i>
												</div>
												<div class="q_arrow-bottom">
													<i class="bi bi-arrow-down"></i>
												</div>
											</div>
										</div>
										
										<div class="answer">
											<span>
												${fn:replace(dto.getFAQ_content(), replaceEnter, "<br/>") }
											</span>
										</div>
									</div>
								</c:when>
								<c:when test="${dto.getFAQ_category_num() == 3}">
									<div class="FAQ_cate_reward">
										<div class="question">
											<span class="q_cate">[상금]</span>
											<span class="q_title">${dto.getFAQ_title() }</span>
											<div class="q_arrow-wrap">
												<div class="q_arrow-top">
													<i class="bi bi-arrow-up"></i>
												</div>
												<div class="q_arrow-bottom">
													<i class="bi bi-arrow-down"></i>
												</div>
											</div>
										</div>
										
										<div class="answer">
											<span>
												${fn:replace(dto.getFAQ_content(), replaceEnter, "<br/>") }
											</span>
										</div>
									</div>
								</c:when>
							</c:choose>
						</td>
						</tr>
						</c:forEach>
						
							
				</c:if>
				<c:if test="${empty list }">
					<tr>
						<td>조회할 FAQ가 없습니다.</td>
					</tr>
				</c:if>

			</table>
			
			<script>
			
				$(".question").click(function(){
					if ($(this).hasClass('show')){
						$(this).next(".answer").slideUp(200);
						$(this).removeClass('show');
					}else {
						$(this).next(".answer").stop().slideDown(200);
						$(this).addClass('show');
					}
				});
			
				$(".FAQ_cate").click(function(){
					if ($(this).attr('value') == 0){
						$(".FAQ_cate_proof").show();
						$(".FAQ_cate_pay").show();
						$(".FAQ_cate_reward").show();
					}else if($(this).attr('value') == 1){
						$(".FAQ_cate_proof").show();
						$(".FAQ_cate_pay").hide();
						$(".FAQ_cate_reward").hide();
					}else if($(this).attr('value') == 2){
						$(".FAQ_cate_proof").hide();
						$(".FAQ_cate_pay").show();
						$(".FAQ_cate_reward").hide();
					}else if($(this).attr('value') == 3){
						$(".FAQ_cate_proof").hide();
						$(".FAQ_cate_pay").hide();
						$(".FAQ_cate_reward").show();
					}
				});
				
			</script>
		
	<jsp:include page="../include/CS_bottom.jsp" />
	<jsp:include page="../include/chall_bottom.jsp" />