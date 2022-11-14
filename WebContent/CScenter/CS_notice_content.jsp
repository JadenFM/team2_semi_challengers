<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("replaceEnter", "\n"); %>
    
    <jsp:include page="../include/chall_top.jsp" />
	<jsp:include page="../include/CS_top.jsp" />
	<c:set value="${noticeContent}" var="dto" />
	<c:set value="${noticeContentPrev}" var="dtoPrev" />
	<c:set value="${noticeContentNext}" var="dtoNext" />
	
	<table class="full_table">
		<tr class="contentTitle">
			<td colspan="2">
				<h1>공지사항</h1>
				<hr>
			</td>
		</tr>
		<tr>
			<td>
				<div class ="noticeTitleWrap">
					<c:if test="${dto.getNotice_category().equals('notice')}">
						<span class="noticeCate">[공지]</span>
					</c:if>
					<c:if test="${dto.getNotice_category().equals('event')}">
						<span class="noticeCate">[이벤트]</span>
					</c:if>
					<span class="noticeTitle">${dto.getNotice_title() }</span>
				
					<span class="noticeRegdate">${dto.getNotice_regdate().substring(0, 10) }</span>
				</div>
				<div class="noticeContent">
					<span>${fn:replace(dto.getNotice_content(), replaceEnter, "<br/>") }</span>
				</div>
				
				<div class="noticeArticles">
					
					<c:if test="${dtoNext.getNotice_content() ne null}">
						<a href="<%=request.getContextPath()%>/CS_notice_content.do?no=${dto.getNotice_num()+1}">
							<span>윗글</span>&nbsp;
							<span>
								<c:if test="${dtoNext.getNotice_category().equals('notice') }">
									[공지]
								</c:if>
								<c:if test="${dtoNext.getNotice_category().equals('event') }">
									[이벤트]
								</c:if>
							</span>
							&nbsp;
							<span>
								${dtoNext.getNotice_title() }
							</span>
						</a>
					</c:if>
					<c:if test="${dtoNext.getNotice_content() eq null}">
						<span>윗글</span>&nbsp;
						<span>
							마지막 글입니다.
						</span>
					</c:if>
					
					<hr color="lightgray">
					
					<c:if test="${dtoPrev.getNotice_content() ne null}">
						<a href="<%=request.getContextPath()%>/CS_notice_content.do?no=${dto.getNotice_num()-1}">
							<span>아랫글</span>&nbsp;
							<span>
								<c:if test="${dtoPrev.getNotice_category().equals('notice') }">
									[공지]
								</c:if>
								<c:if test="${dtoPrev.getNotice_category().equals('event') }">
									[이벤트]
								</c:if>
							</span>
							&nbsp;
							<span>
								${dtoPrev.getNotice_title() }
							</span>
						</a>
					</c:if>
					<c:if test="${dtoPrev.getNotice_content() eq null}">
						<span>아랫글</span>&nbsp;
						<span>
							이전 글이 없습니다.
						</span>
					</c:if>

				</div>
				<div class="noticeBtn">
					<button onclick="location.href='<%=request.getContextPath()%>/CS_main.do'">목록</button>
				</div>
			</td>
		</tr>
	</table>
	
	<jsp:include page="../include/CS_bottom.jsp" />
	<jsp:include page="../include/chall_bottom.jsp" />