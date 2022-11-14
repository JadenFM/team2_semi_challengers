<%@page import="com.cs.model.FAQDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("replaceEnter", "\n"); %>
<% List<FAQDTO> FAQList = (List<FAQDTO>)request.getAttribute("FAQList"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<table class="full_table">
		<tr class="contentTitle">
			<td colspan="2">
				<h1>FAQ</h1>
				<div style="text-align :right">
					<span><i class="bi bi-search"></i> <input id="faq-search" type="text" class="form-control" style="display: inline-block; width:25%;" placeholder="검색..."></span>
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

</body>
</html>