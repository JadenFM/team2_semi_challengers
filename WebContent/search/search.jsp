<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript" src="./searchJS/search_list.js"></script>
<script type="text/javascript" src="searchJS/search_menu.js"></script>
<%

	String keyword="";
 	String category="";
	if(request.getParameter("keyword") != "" &&request.getParameter("keyword") != null){
		keyword = request.getParameter("keyword").trim();
		System.out.println("search_jsp페이지 파라메터 키워드 >>> " +keyword);
	}else{
		System.out.println("키워드 else");
	}

	if(request.getParameter("category") != "" && request.getParameter("category") != null){
		category = request.getParameter("category").trim();
		System.out.println("search_jsp페이지 파라메터 카테고리 >>> " +category);	
	}else{
		System.out.println("카테고리 else");
	}
	
/* 	if(!request.getParameter("category").equals("")){
		
		keyword = request.getParameter("keyword").trim();
		System.out.println("search_jsp페이지 파라메터 >>> " +keyword);
		
	} */
	

/*  	String optionCy="";
	String optionCa="";
	String optionDu="";
	
	if(!request.getParameter("optionCy").equals("")){
		optionCy = request.getParameter("optionCy").trim();
	}
	if(!request.getParameter("optionCa").equals("")){
		optionCa = request.getParameter("optionCa").trim();
	}
	if(!request.getParameter("optionDu").equals("")){
		optionDu = request.getParameter("optionDu").trim();
	}
	
	System.out.println("jsp optionCy >>> " +optionCy);
	System.out.println("jsp optionCa >>> " +optionCa);
	System.out.println("jsp optionDu >>> " +optionDu); */
%>
</head>
<body>
	<input type="hidden" value="<%=keyword %>" name="keyword" id="keyword">
	<input type="hidden" value="<%=category %>" name="category" id="category">
<%-- 	<input type="hidden" value="<%=category %>" name="keyword" id="keyword"> --%>
<%-- 	<input type="hidden" value="<%=optionCy %>" name="optionCy" id="optionCy">
	<input type="hidden" value="<%=optionCa %>" name="optionCa" id="optionCa">
	<input type="hidden" value="<%=optionDu %>" name="optionDu" id="optionDu"> --%>

<%-- 	<%
		if(!request.getParameter("optionCy").equals("")){
	%>		
			<input type="hidden" value="<%=request.getParameter("optionCy") %>" name="optionCy" id="optionCy" class="text">
	<%
		}
	%>		
	
	<%
		if(!request.getParameter("optionCa").equals("")){
	%>		
			<input type="hidden" value="<%=request.getParameter("optionCa") %>" name="optionCa" id="optionCa" class="text">
	<%
		}
	%>
	
	<%
		if(!request.getParameter("optionDu").equals("")){
	%>		
			<input type="hidden" value="<%=request.getParameter("optionDu") %>" name="optionDu" id="optionDu" class="text">
	<%
		}
	%> --%>
	<jsp:include page="/include/chall_top.jsp" />
	
				<aside id="side_category">
		<ul class="search_menu">
			<li class="option1">
				<a>필터</a>
			</li>
			<li class="option">
				<a class="toggle_menu">카테고리</a>
				<span><a class="toggle_icon">+</a></span>
				<ul class="search_submenu">
					<li><input type="checkbox" id="category_all" name="category_all"><label for="category_all"><a>전체</a></label></li>
					<li><input type="checkbox" id="category1" class="category" name="category" value="C001"><label for="category1"><a>운동</a></label></li>
					<li><input type="checkbox" id="category2" class="category" name="category" value="C002"><label for="category2"><a>식습관</a></label></li>
					<li><input type="checkbox" id="category3" class="category" name="category" value="C003"><label for="category3"><a>생활</a></label></li>
					<li><input type="checkbox" id="category4" class="category" name="category" value="C004"><label for="category4"><a>정서</a></label></li>
					<li><input type="checkbox" id="category5" class="category" name="category" value="C005"><label for="category5"><a>취미</a></label></li>
					<li><input type="checkbox" id="category6" class="category" name="category" value="C006"><label for="category6"><a>환경·펫</a></label></li>
					<li><input type="checkbox" id="category7" class="category" name="category" value="C008"><label for="category7"><a>공부</a></label></li>
					<li><input type="checkbox" id="category8" class="category" name="category" value="C009"><label for="category8"><a>셀프케어</a></label></li>
					<li><input type="checkbox" id="category9" class="category" name="category" value="C007"><label for="category9"><a>기타</a></label></li>
				</ul>
			</li>
			<li class="option">
				<a class="toggle_menu">빈도</a>
				<span><a class="toggle_icon">+</a></span>
				<ul class="search_submenu">
					<li><input type="checkbox" id="cycle_all" name="cycle_all"><label for="cycle_all"><a>전체</a></label></li>
					<li><input type="checkbox" id="cycle_daily" class="cycle" name="cycle" value="매일"><label for="cycle_daily"><a>매일</a></label></li>
					<li><input type="checkbox" id="cycle1" class="cycle" name="cycle" value="주 1일"><label for="cycle1"><a>주1일</a></label></li>
					<li><input type="checkbox" id="cycle2" class="cycle" name="cycle" value="주 2일"><label for="cycle2"><a>주2일</a></label></li>
					<li><input type="checkbox" id="cycle3" class="cycle" name="cycle" value="주 3일"><label for="cycle3"><a>주3일</a></label></li>
					<li><input type="checkbox" id="cycle4" class="cycle" name="cycle" value="주 4일"><label for="cycle4"><a>주4일</a></label></li>
				</ul>
			</li>
			<li class="option">
				<a class="toggle_menu">기간</a>
				<span><a class="toggle_icon">+</a></span>
				<ul class="search_submenu">
					<li><input type="checkbox" id="duration_all" name="duration_all"><label for="duration_all"><a>전체</a></label></li>
					<li><input type="checkbox" id="duration1" class="duration" name="duration" value="1"><label for="duration1"><a>1주</a></label></li>
					<li><input type="checkbox" id="duration2" class="duration" name="duration" value="2"><label for="duration2"><a>2주</a></label></li>
					<li><input type="checkbox" id="duration3" class="duration" name="duration" value="3"><label for="duration3"><a>3주</a></label></li>
					<li><input type="checkbox" id="duration4" class="duration" name="duration" value="4"><label for="duration4"><a>4주</a></label></li>
				</ul>
			</li>
		</ul>
		
		<input type="button" id="search_option" class="search_option" value="선택완료">
		
	</aside>
	
	
	
	<article id="art" align="center">

		<div id="card_container" align="center">
			<div id="input_chall">
				<div id="card_chall">
				</div>
			</div>
		</div>		
	</article>
	
	<div class="top_btn">
			<img src="<%=request.getContextPath()%>/search_image/Top.PNG">
	</div>

 	<jsp:include page="../include/chall_bottom.jsp" />
</body>
<style>


.a:link{
	color: #000;
	font-weight: bold;
}

a:visited{
	color: #000;
	font-weight: bold;
}
.search_menu{
	text-align: left;
}


.option{
 	margin: 25px 0;
 	padding-bottom: 25px;
	border-bottom: 2px groove gray; 
}



.option1{
	font-weight: bold;
	font-size: 25;
	margin: 25px 200px 25px 0px;
}

.toggle_menu{
	cursor: pointer;
	font-weight: bold;
	font-size: 20;
	
}

.option > .search_submenu{
	display: none;
}

p {
	color: red;
}

ul {
	list-style-type: none;
	padding-left: 0px;
}


ul > li{
	list-style-type: none;
	padding-left: 0px;
	display: block;
	padding: 5px 0;
}

#side_category{
	float: left;
	margin-left: 3%;
}

.toggle_icon{

	clear:left;
	float: right;
	font-size: 16px;
	font-weight: bold;
}

.search_submenu li > label > a {
	display: inline-block;
	height:100%;
	width: 80%;
	cursor: pointer;
	color: #666;
}

.option > .toggle_menu{
	font-size: 16px;
}

.search_submenu li:hover{
	background-color: #ccc;
}


/* 체크박스  */

input, progress{
	accent-color:#ff4d54;
}

input[type="checkbox"]:checked +label a{
	font-weight: bold;
	color: #000;
}

.search_item img{

	width: 100px;
	height: 100px;
	border: 0;

}

.art{
	float: left;
}

.search_option{
	width: 100%;
	background-color: #ff4d54;
	color: white;
	font-weight: bold;
	font-size: 14px;
	border-radius: 5px;
}

/* 챌린지 아이템 */

#card_container{
 	margin-top: 20px;
	overflow: auto;
}


.card_chall{
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 50px;
	flex-wrap:wrap;
	align-content: space-between;
	font-weight: bold;
}


.chall_items{
	margin: 0px 20px;
}


.chall_none{
	width: 282px;
	height: 384px;
}



.img_wrap{
	width: 100%;
	position: relative;
}

.most_chall_image{
	height: 282px;
	width: 282px;
}

.img_text{
	position: absolute;
	top: 10%;
	left: 80%;
	transform: translate(-50%, -50%);
	font-size: 25%;
	text-align: center;
	color: #fff;
	background-color: #000;
	width: 25%;
}

.icon_people{
	width: 25%;
}

.span_wrap{
	background-color: #ccc;
	opacity: 0.7;
}

.none2{
	margin: 300px auto;
	text-align: center;
	font-size: 16px;
	color: #AAA;
}

.profil{
	width: 20px;
	height: 20px;	
}

.chall_items{
	text-align: left;
	color: black;
}

.chall_items p{
	text-align: left;
	color: black;
}

.span_creater{
	color: black;
}

.top_btn{
	position: fixed;
	bottom: 150px;
    right: 20px;
    width: 44px;
    height: 48px;
    padding-top: 4px;
    border-radius: 30px;
    cursor: pointer;
}

.top_btn img{
	width: 50px;
	opacity: 0.6;
}

.top_btn img:hover {
	opacity: 1;
}
</html>